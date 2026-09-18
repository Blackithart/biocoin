# GitHub issues, leftover branches, archives (2026-09-18)

Housekeeping of what was still hanging on `Blackithart/biocoin` after the 2026-09-12 final council. English only. This does not recover the chain after 115366 and does not change the Railway hold through **2027-09-12**.

Final council (unchanged): [`final-council-2026.md`](final-council-2026.md).

## New conclusions

1. The five open GitHub issues are from **2017–2018**. None of them is a 2026 product request. Three are already fixed on `master`. One is a README request already done. One is a first-sync hang on a network that no longer exists.
2. Leftover `cursor/*` branches were already in `master`. They were not a second copy of the work. They can be deleted from origin after this note.
3. `archive/nbv-1.0.2` (tag `v1.0.2`) must **stay a side branch**. Merging it onto `master` would replace the 2026 OpenSSL 3 / Ubuntu 24.04 tree with NETTRASH’s 1.0.2.17 (OpenSSL 1.0). Unique bits were already taken on 2026-09-12 (Qt comma, OSX dmg). See [`nbv-collapse-2026.md`](nbv-collapse-2026.md).
4. Railway `biocoin-peer` does **not** need a rebuild. Rechecked **2026-09-18**: both public proxies still speak magic `b4 f9 e1 a5`, protocol `90000`, user agent `/BioCoin:1.0.1.2/`, height **115366**. Local `makefile.unix` still links `BioCoind` on Ubuntu 24.04 / OpenSSL 3. Post-12-Sep `master` only added docs, comments, Qt comma, and OSX art; the daemon image recipe did not change in a way that requires a new deploy.
5. Hard stop and the one-year hold do **not** change. Enthusiasm is still welcome: [info@blackithart.com](mailto:info@blackithart.com).

## Open issues (all from 2017–2018)

GitHub leaves them open. This file is the in-tree verdict. This token cannot close GitHub issues.

| # | title | reporter | verdict on `master` |
| --- | --- | --- | --- |
| [#1](https://github.com/Blackithart/biocoin/issues/1) | Make it clearer that this is the biocoin wallet source | radoeka, 2017-09-30 | **Done.** The README now opens as the BioCoind / BioCoin-qt source, not a website and not a block database. |
| [#2](https://github.com/Blackithart/biocoin/issues/2) | `walletdb` undefined `boost::filesystem::detail::copy_file` (Boost 1.54 / openSUSE) | radoeka, 2017-10-01 | **Superseded.** `src/walletdb.cpp` selects `copy_options` / `copy_option` by `BOOST_VERSION`. The 2017 `BOOST_NO_CXX11_SCOPED_ENUMS` patch is not needed on Ubuntu 24.04 / Boost 1.83. Rechecked: `makefile.unix` links. |
| [#3](https://github.com/Blackithart/biocoin/issues/3) | Qt4 / OpenSSL 1.1 `CBigNum` inherit-`BIGNUM` / `BN_init` | viktorminko, 2017-11-27 | **Fixed (2026).** `src/bignum.h` is an OpenSSL 1.1 / 3 wrapper (`BN_new`, not `BN_init`). Same class of failure as the 2026 Linux build work on `master`. |
| [#4](https://github.com/Blackithart/biocoin/issues/4) | First-time network sync hangs (Ubuntu 16.04, BIO 1.0.0) | sbespalov, 2017-12-20 | **Not a 2026 bug we can ship.** Historical advice was restart / `rescan`. In 2026 there is **no** external peer network. A new node cannot pass checkpoint **170000** without blocks after **115366**. Do not strip checkpoints to hide the hang. |
| [#5](https://github.com/Blackithart/biocoin/issues/5) | `No rule to make target 'src/qt/qrencode.h'` | agsstaff, 2017-12-22 | **Documented / optional.** There is no `src/qt/qrencode.h`. The dialog includes `<qrencode.h>` from libqrencode, and only if `qmake USE_QRCODE=1`. README: install `libqrencode-dev` or omit QR. |

2018 operator comments on those tickets (try Qt5, add qrencode, restart / rescan) are historical. They do not add blocks.

## Leftover origin branches (2026-09-18)

| ref | tip | vs `master` (`031aefb` at check) | action |
| --- | --- | --- | --- |
| `master` | final council | — | keep |
| `cursor/final-council-railway-year-de47` | `031aefb` | **equal** to `master` | delete after this note is on `master` |
| `cursor/collapse-biocoin-nbv-2fb2` | `d2adfa7` | **one commit behind** `master` (already merged via PR #10) | delete |
| `archive/nbv-1.0.2` | `9e9a4bc` (2019-01-16) | 11 unique archive commits / 54 unique `master` commits | **keep as archive** |
| tag `v1.0.2` | `b857878` | NETTRASH 1.0.2 release | **keep** |
| tag `1.0.1.2` | Qt wallet release, 2018-08-16 | GitHub Releases are wallets, not chain data | **keep** |

Do not fast-forward `master` to `archive/nbv-1.0.2`. That is the opposite of the 2026 collapse.

## Railway recheck (2026-09-18)

P2P version handshake against the public proxies (magic `b4 f9 e1 a5`):

| proxy | user agent | protocol | advertised height |
| --- | --- | --- | --- |
| `altaria.proxy.rlwy.net:45218` | `/BioCoin:1.0.1.2/` | `90000` | **115366** |
| `altaria.proxy.rlwy.net:22792` | `/BioCoin:1.0.1.2/` | `90000` | **115366** |

On 2026-09-09 the second peer had been seen at 115365. On 2026-09-18 both advertise 115366. They still only see each other. No external historical peer appeared.

This environment has no Railway API token (`railway whoami` → Unauthorized), so a dashboard redeploy was not triggered. It is not needed: the running binaries match the intended client label, and `makefile.unix` still produces `BioCoind` from current `master`.

## What this side still will not do

Close or “finish” BioCoin. Restore old BIO. Reuse the BIO ticker. Merge `nbv` onto `master`. Strip checkpoints. Re-register expired seeds. Rebuild Railway for documentation-only commits.

**[info@blackithart.com](mailto:info@blackithart.com)**
