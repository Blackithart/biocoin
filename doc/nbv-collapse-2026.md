# Collapse of biocoin_nbv (2026-09-12)

Record of folding the second public BioCoin source tree into this repository. English only. This is not a chain recovery.

**Hard stop does not change.** Same chain, two dead DNS lists, zero new blocks. Work from this side still stops here.

## What we tried

We compared this tree (`Blackithart/biocoin`, live client **1.0.1.2**) with the public snapshot [`Blackithart/biocoin_nbv`](https://github.com/Blackithart/biocoin_nbv) (client **1.0.2.17**, tag `v1.0.2`).

`biocoin_nbv` is NETTRASH's 2018–2019 client, not a Blackithart build. Last unique code landed in January 2019 (`fix -seednode`, OSX dmg background, README). Shipping into January 2019 makes the hole after height **115366** clearer, not smaller: a second maintainer kept releasing a compiler while the live island we have still ends on **2018-03-29**.

Neither tree has `blk*.dat`, `bootstrap.dat`, wallets, or peers past 115366.

## What is the same

| item | both trees |
| --- | --- |
| Network magic | `b4 f9 e1 a5` |
| Protocol | `90000` |
| Hardened checkpoints | through **170000** (`0x47e9b3ae…85049e`, unix `1533686156`) |
| Hardcoded `pnSeed[]` | the same dead IPv4 list on `:24885` |
| Chain after 115366 | **absent** |

Checkpoint **170000** is now dual-maintainer confirmed (this tree and NETTRASH). That is a client-consensus fact, not a download of the missing blocks.

1.0.2.17 is a **client label**. It is not a second ledger.

## What was unique in nbv (and what we did)

| nbv change | action in this repo |
| --- | --- |
| Qt `src/qt/bitcoinunits.h`: comma after `uBTC` before `seeds` | **taken** |
| `contrib/macdeploy/background.png` / `background.psd` | **taken** |
| DNS / `-seednode` swap to `n001`–`n013.biocoin.pro` | **not compiled in** (comment only) |
| Client bump 1.0.1.2 → 1.0.2.17 | **not taken** (Railway still speaks `/BioCoin:1.0.1.2/`) |
| OpenSSL 1.0 / Ubuntu 18.04 build notes | **not taken** (this tree stays OpenSSL 3) |

`nbv` commit `c452e50` (`fix -seednode`) only swapped the hardcoded `AddOneShot` hostnames. It did not add a new peer-discovery mechanism.

## DNS recheck (2026-09-12)

`n001.biocoin.pro` through `n013.biocoin.pro` remain **NXDOMAIN** (no A/AAAA). The 1.0.1.2 names (`dnsseed.biocoin.help`, `dns1`–`dns5.seedbiocoin.ru`) are still empty.

Expired seed hostnames are a **hijack path**: anyone who re-registers them would be trusted by old 1.0.2 binaries. That is why they stay out of `strDNSSeed[]` and out of `init.cpp` one-shots.

## Archive

Full `biocoin_nbv` history is on this origin as branch **`archive/nbv-1.0.2`**, plus tag **`v1.0.2`** (commit `b857878`, “release 1.0.2 + new dns”). Tip of the archive branch is `9e9a4bc` (README after the OSX / seednode commits).

## LLM council after collapse (2026-09-12)

Independent notes from Claude Opus, GPT, Gemini, and Muse, then a chairman synthesis:

- Hard stop does **not** change. Same chain, two dead DNS lists, zero new blocks. 1.0.2.17 is a client label.
- **New:** NETTRASH shipped into January 2019, so the hole after 115366 is clearer, not smaller. Checkpoint 170000 is dual-maintainer confirmed.
- **Warning:** old seed hostnames can be re-registered and trusted by old binaries.
- **This side:** nothing further on recovery.

If someone else has authentic blocks past 115366, they can do that work themselves. Mail [info@blackithart.com](mailto:info@blackithart.com).
