// Opens a fresh, isolated Chrome window on an app URL. A person signs in there
// (the agent never types a password). When the page has left the sign-in screen
// and stayed off it for a few seconds, the sign-in (cookies, local storage,
// IndexedDB) is saved to a storage-state file and the window closes.
//
// Called by harness/save-signin.ps1, which resolves the paths. Usage:
//   node save-signin.js <playwright module dir> <url> <out file> [timeout seconds]
// Prints one line of JSON at the end. Never prints cookie or token values.

const path = require('path');
const fs = require('fs');

const [, , moduleDir, url, outFile, timeoutArg] = process.argv;
if (!moduleDir || !url || !outFile) {
  console.error('usage: node save-signin.js <playwright module dir> <url> <out file> [timeout seconds]');
  process.exit(2);
}
const { chromium } = require(path.join(moduleDir, 'playwright'));
const timeoutMs = (Number(timeoutArg) || 300) * 1000;
const signInPath = /(log-?in|sign-?in|auth|oauth|sso|account\/|login\.microsoftonline)/i;
const appHost = new URL(url).host;

(async () => {
  const browser = await chromium.launch({ channel: 'chrome', headless: false });
  const context = await browser.newContext({ viewport: { width: 1440, height: 900 } });
  const page = await context.newPage();
  await page.goto(url);
  const started = Date.now();
  let offSince = 0;
  let result = { saved: false, reason: 'timeout' };
  while (Date.now() - started < timeoutMs) {
    if (page.isClosed()) { result = { saved: false, reason: 'window closed before sign-in finished' }; break; }
    let u;
    try { u = new URL(page.url()); } catch { u = null; }
    const onApp = u && u.host === appHost && !signInPath.test(u.pathname + u.search);
    let hasPassword = false;
    try { hasPassword = (await page.locator('input[type=password]').count()) > 0; } catch { /* navigating */ }
    if (onApp && !hasPassword) {
      if (!offSince) offSince = Date.now();
      if (Date.now() - offSince >= 5000) {
        fs.mkdirSync(path.dirname(outFile), { recursive: true });
        const state = await context.storageState({ path: outFile, indexedDB: true });
        const origins = (state.origins || []).map(o => ({
          origin: o.origin,
          localStorage: (o.localStorage || []).length,
          indexedDB: (o.indexedDB || []).length,
        }));
        const cookies = (state.cookies || []).length;
        const expiries = (state.cookies || []).map(c => c.expires).filter(e => e && e > 0);
        result = {
          saved: true,
          file: outFile,
          landedOn: u.origin + u.pathname,
          cookies,
          origins,
          earliestCookieExpiry: expiries.length ? new Date(Math.min(...expiries) * 1000).toISOString() : null,
          savedAt: new Date().toISOString(),
        };
        break;
      }
    } else {
      offSince = 0;
    }
    await new Promise(r => setTimeout(r, 1000));
  }
  await browser.close().catch(() => {});
  console.log(JSON.stringify(result));
  process.exit(result.saved ? 0 : 1);
})().catch(e => { console.log(JSON.stringify({ saved: false, reason: String(e && e.message || e) })); process.exit(1); });
