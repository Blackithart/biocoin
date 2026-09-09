# BioCoin revival notes (2026)

Status of the 2026 attempt to bring BioCoin peers and tooling back, so the next person does not repeat the same dead ends. This file is a record, not a roadmap with hidden data.

Nodes were built and two Railway peers talk to each other. The chain stops at height **115366**. Checkpoints require **170000**. The original operator has no more blk files, peers, or backups. Continuation needs authentic blocks past that height or a live external BIO peer.

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

Observed `getinfo` on 2026-09-09 via `railway ssh`:

- `biocoin-peer`: `blocks` 115366, `moneysupply` 818600206.73485589, `connections` 3, `testnet` false.
- `biocoin-peer-2`: `blocks` 115365 (still catching the first node).
- `getpeerinfo` on the first node showed only the second Railway node (public TCP and private overlay), user agent `/BioCoin:1.0.1.2/`. No external historical peer.

The two nodes can replicate **what they already have**. They cannot invent blocks after 115366.

### Wallet

A local wallet can be used with the node. Wallets and keys must never be committed.

### Website (not this git repo)

The old public site was recovered and deployed separately.

- Public URL: https://biocoin.blackithart.com
- That project is independent of this C++ tree.

Do not copy the site sources into https://github.com/Blackithart/biocoin.

## Hard stop from the original operator

Artem Kalinin / Blackithart stated there is nothing more to give: no remaining `blk*.dat`, no extra peers to introduce, no backups. Treat that as a fact. Future work does not wait on the original team.

## How to continue

1. Obtain authentic BioCoin block files covering **at least past 115366**, preferably **past checkpoint 170000**. `bootstrap.dat` is useful if it is BIO magic `b4 f9 e1 a5` and actually contains that range.
2. Find any remaining live P2P peer (exchanges, old VPS, archived nodes) that still speaks BIO on port 24885 with that magic. `addnode=<host>:24885` or the Railway TCP proxy port if that is how the peer is published.
3. Run the Docker/Railway node from this repo (or `makefile.unix` after the Linux patches). Point `addnode` at `altaria.proxy.rlwy.net:45218` if that peer is still up. Keep checkpoints on.
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
