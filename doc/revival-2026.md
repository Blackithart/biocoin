# BioCoin revival notes (2026)

Status of the 2026 attempt to bring BioCoin peers and tooling back, so the next person does not repeat the same dead ends. This file is a record, not a roadmap with hidden data.

Nodes were built and two Railway peers talk to each other. The chain stops at height **115366**, tip hash `0553d020c4e03f4c54adbeeff37d48551c175e4eb273c202e077f1902714ef60`. Checkpoints require **170000**. A 2026-09-09 internet + GitHub-account search found **no** live external BIO peer and **no** downloadable `blk` / `bootstrap` past that height. The original operator has no more blk files, peers, or backups. Continuation needs authentic blocks past 115366 (ideally past 170000) or a live external BIO peer. Do not strip checkpoints; keep the Railway island. YoBit still lists BIO markets; contact attempts received no reply.

## What this tree is

- Daemon `BioCoind` and Qt wallet `BioCoin-qt`.
- PoS coin, ticker BIO, P2P `24885`, RPC `24889`.
- Magic in `src/main.cpp`: `unsigned char pchMessageStart[4] = { 0xb4, 0xf9, 0xe1, 0xa5 };`
- Protocol version `90000` (`src/version.h`).

## Checkpoints (do not strip)

`src/checkpoints.cpp` mainnet hardened checkpoints end at:

| height | time (unix) | note |
| --- | --- | --- |
| 170000 | 1533686156 | 2018-08-08, last compiled-in checkpoint |

`GetTotalBlocksEstimate()` returns that last height. A node that only has genesis (or anything below 170000 that does not match) will not be treated as caught up. Do not delete or skip these checkpoints to “finish sync”.

## What was done

### Linux / Docker / Railway

- OpenSSL 3 and current Boost patches so `makefile.unix` builds on Ubuntu 24.04.
- `Dockerfile` (multi-stage Ubuntu 24.04 → `BioCoind`), `docker/entrypoint.sh`, `railway.toml`.
- Related PRs on this GitHub repo: Linux/OpenSSL3/Boost + Docker/Railway; `BIOCOIN_ADDNODE` / docs. They may still be unmerged when you read this.

### Live peers (Railway project `biocoin-peer`)

Project id `2ff03dc3-90c6-4931-a46d-ae8ba13541e8`, environment `production`.

| service | public P2P | notes |
| --- | --- | --- |
| `biocoin-peer` | `altaria.proxy.rlwy.net:45218` | last observed height **115366**, moneysupply ≈ 818.6M BIO |
| `biocoin-peer-2` | `altaria.proxy.rlwy.net:22792` | `BIOCOIN_ADDNODE=altaria.proxy.rlwy.net:45218` |

Observed `getinfo` on 2026-09-09 via `railway ssh` (re-checked later the same day):

- `biocoin-peer`: `blocks` 115366, tip hash `0553d020c4e03f4c54adbeeff37d48551c175e4eb273c202e077f1902714ef60`, tip time **2018-03-29** (`1522360302`), `moneysupply` 818600206.73485589, `connections` 3–4, `testnet` false, sync-checkpoint policy **strict** (sync checkpoint still at genesis).
- `biocoin-peer-2`: `blocks` 115365, `connections` 3 (only the first Railway node / overlay).
- `getpeerinfo`: only `/BioCoin:1.0.1.2/` peers inside the Railway pair. No external historical peer.
- Hardened checkpoints **0 … 112342** on the live tip match `src/checkpoints.cpp`. Height **130000** is out of range (`Block number out of range`). Next compiled checkpoints are 130000 / 150000 / **170000**.

The two nodes can replicate **what they already have**. They cannot invent blocks after 115366.

## Internet + account sweep (2026-09-09)

### Verdict

**No live external BIO peer** and **no downloadable `blk*.dat` / `bootstrap.dat` past height 115366** were found. Railway island still at **115366**, tip hash above. Keep that island; do not strip checkpoints.

### Seed / peer probes

| target | result |
| --- | --- |
| DNS seeds in `src/net.cpp` (`dnsseed.biocoin.help`, `dns1`–`dns5.seedbiocoin.ru`) | empty — **no A/AAAA** |
| Hardcoded `pnSeed[]` IPs (28 unique) | TCP **24885** timed out / unreachable |
| Alternate seeds `n001`–`n013.biocoin.pro` | **NXDOMAIN** |
| Railway P2P proxies `:45218` / `:22792` | accept TCP; island peers only |
| Shodan / Censys | **unavailable without API** (web snippets only) |

### YoBit

Public API still lists `bio_*` markets. Order books and trade timestamps exist on the public trades endpoint (exchange ledger activity). **No** public node, height, or deposit-node information. Prior outreach was silent. That is **not** proof of a live BIO P2P peer past height 115366.

### Wayback Machine (historical evidence only)

Archived Iquidus explorer `block-explorer.biocoin.bio` JSON shows the chain historically continued well past 115366. This proves past life of the chain but is **not** a block download source. Compiled-in checkpoint **hashes** for 130000 / 150000 / 170000 were **not** archived for hash verification.

| archive date | source | height | note |
| --- | --- | --- | --- |
| 2018-04-07 | `/api/getblock` | **116391** | PoS; past tip 115366 |
| 2018-06-08 | `/ext/summary` | **144499** | between ckpt 130000 and 150000 |
| 2018-08-07 | `/ext/summary` | **169896** | just before ckpt 170000 (2018-08-08) |
| 2018-08-16 | `/api/getblock` | **170701** | hash `e7343889…5a17`; past ckpt 170000 |
| 2018-12-12 | `/ext/summary` | **222725** | |
| 2019-03-10 | `/ext/summary` | **259550** | supply ≈846.4M (CMC total supply ≈845.8M matches this era) |
| ~2019-03 | explorer summaries | **~259550–260725** | late archived range observed |

No `bootstrap.dat` / `blk*.dat` / torrent turned up in CDX / archive probes tried here. Marketing pages for `biocoin.org` / `www.biocoin.org` exist on Wayback; they do not host chain data.

### Blackithart GitHub account scan

Public repos under the account: `biocoin`, `biocoin_nbv`, `neiro`, `kuburan`, `privexchange`, `xeres`. Only **`biocoin`** and **`biocoin_nbv`** are BioCoin-relevant.

| check | result |
| --- | --- |
| `blk*.dat` / `bootstrap.dat` in account | **none** |
| wallet dumps / peer DBs | **none** |
| `biocoin_nbv` | mirrors same checkpoints / magic; dead DNS `n001`–`n013.biocoin.pro` |
| GitHub Releases | **Qt wallets only**, not chain data |

## Wallet

A local wallet can be used with the node. Wallets and keys must never be committed.

## Website (not this git repo)

The old public site was recovered and deployed separately.

- Public URL: https://biocoin.blackithart.com
- That project is independent of this C++ tree.

Do not copy the site sources into https://github.com/Blackithart/biocoin.

## Hard stop from the original operator

Artem Kalinin / Blackithart stated there is nothing more to give: no remaining `blk*.dat`, no extra peers to introduce, no backups. Treat that as a fact. Future work does not wait on the original team.

## How to continue

1. Obtain authentic BioCoin block files covering **at least past 115366**, preferably **past checkpoint 170000**. `bootstrap.dat` is useful if it is BIO magic `b4 f9 e1 a5` and actually contains that range.
2. Find any remaining live P2P peer (exchanges, old VPS, archived nodes) that still speaks BIO on port 24885 with that magic. Human outreach leads: YoBit (activity noticed, contact attempted, no reply), Telegram `@biocoinchat_ru` / `@biocoinchat`, former operators.
3. Run the Docker/Railway node from this repo (or `makefile.unix` after the Linux patches). Point `addnode` at `altaria.proxy.rlwy.net:45218` if that peer is still up. Keep checkpoints on. Keep the Railway island.
4. Never load foreign wallets or foreign block databases onto a BIO node. Wrong magic / wrong genesis will not become BioCoin by renaming files.
5. Website work stays at https://biocoin.blackithart.com — independent of this C++ tree.
6. Never commit wallets or keys.

## RPC reminder

RPC on the Docker image is bound to localhost (`rpcallowip=127.0.0.1`). Use `railway ssh` / `docker exec`, not a public RPC port.

```
BioCoind -datadir=/data getinfo
BioCoind -datadir=/data getpeerinfo
BioCoind -datadir=/data getconnectioncount
```
