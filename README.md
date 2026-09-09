# BioCoin (BIO)

This repository is the **BioCoin node and wallet source**: the `BioCoind` daemon and the `BioCoin-qt` graphical wallet. It is not a website and not a block database.

BioCoin is a NovaCoin/Peercoin-style proof-of-stake coin.

| | |
| --- | --- |
| Ticker | BIO |
| P2P port | `24885` |
| RPC port | `24889` |
| Network magic | `b4 f9 e1 a5` |
| Protocol | `90000` |
| Config | `~/.BioCoin/BioCoin.conf` (directory name is case-sensitive) |

**Revival (2026), short status.** The daemon builds on current Linux (OpenSSL 3 / Boost). Two Railway peer nodes talk to each other on an island tip at height **115366**, hash `0553d020c4e03f4c54adbeeff37d48551c175e4eb273c202e077f1902714ef60` (moneysupply about **818.6M BIO**, 2026-09-09). Hardened checkpoints in `src/checkpoints.cpp` go to block **170000** (August 2018). A deep peer/search pass found **no** live external BIO peer and **no** downloadable `blk` / `bootstrap` past 115366. DNS seeds are empty; all `pnSeed[]` IPs are dead on `:24885`; `n001`–`n013.biocoin.pro` are NXDOMAIN. Wayback Machine explorer JSON shows the chain once continued well past 115366 (through checkpoint 170000 and up to ~260k by 2019) — historical proof only, not a block download source. The Blackithart GitHub account has no chain data (releases are Qt wallets only). The original operator has **no more** `blk` files, peers, or backups. YoBit still lists BIO markets publicly; outreach received no reply. Continuation needs authentic blocks past 115366 (ideally past 170000) or a live peer. Do not strip checkpoints; keep the Railway island.

Marketing site (not this repo, not the blockchain): https://biocoin.blackithart.com

Details: [`doc/revival-2026.md`](doc/revival-2026.md). How to run a node: [`doc/BioCoin_Node_Setup.txt`](doc/BioCoin_Node_Setup.txt).

## Revival, 2026

What was done:

1. The source was brought up to build on current Linux (OpenSSL 3, Boost). A Docker image and Railway config were added. That work lives in separate PRs on this repository (Linux/Docker and peer-node deploy) and may not yet be on `master`.
2. Two public peer nodes were brought up in the Railway project `biocoin-peer` (production):
   - `biocoin-peer` — `altaria.proxy.rlwy.net:45218`
   - `biocoin-peer-2` — `altaria.proxy.rlwy.net:22792` (`BIOCOIN_ADDNODE=altaria.proxy.rlwy.net:45218`)
   The nodes see each other over P2P.
3. A local wallet can be used with the node. Wallets and keys **must never be committed**.
4. The old public site was restored separately at **https://biocoin.blackithart.com**. That is a different project, not the BioCoin C++ tree.
5. Some on-exchange activity related to BIO was noticed on YoBit. The revival effort tried to contact YoBit; there was no response. Treat this as a possible remaining external venue or peer lead that did not pan out for now — not as proof the chain is alive, and not as an accusation.

What was not recovered: **the chain after height 115366.** Checkpoints in the code require block **170000**. Without historical `blk*.dat` / `bootstrap.dat` (ideally past checkpoint 170000) or a live external peer with the same magic, a full-history sync is not possible.

The original operator confirmed there is **no more data** — no remaining blk files, extra peers, or backups. Do not wait on the original team for the missing chain.

## Current status

Working:

- `BioCoind` builds on current Linux (after OpenSSL 3 / Boost patches; see related PRs).
- Docker image and Railway peer-node deploy.
- Two Railway nodes, connected to each other, shared height **115366**, tip hash `0553d020c4e03f4c54adbeeff37d48551c175e4eb273c202e077f1902714ef60`.
- Site https://biocoin.blackithart.com (separate from this repository).

Not present:

- Historical chain **after 115366** (through checkpoint 170000 and beyond) as downloadable `blk` / `bootstrap`.
- An external peer network. Observed connections are between the two Railway nodes only.
- Full sync from empty genesis: `GetTotalBlocksEstimate()` uses the last hardened checkpoint (**170000**). **Do not disable checkpoints.**

Search findings (2026-09-09), short:

- No live external BIO peer; no downloadable chain past 115366.
- All DNS seeds empty; all `pnSeed[]` dead on `:24885`; `n001`–`n013.biocoin.pro` NXDOMAIN.
- YoBit BIO markets still public; no node/height/deposit-node info; prior outreach silent.
- Wayback archived `block-explorer.biocoin.bio` JSON shows past heights well above 115366 (e.g. 116391, 144499, 169896, **170701**, ~259550–260725 by Mar 2019). Not a download source; checkpoint hashes were not archived for verification.
- Blackithart GitHub public repos scanned; only `biocoin` / `biocoin_nbv` relevant; no chain dumps; releases are Qt wallets only.
- Shodan/Censys unavailable without API.

Last RPC figures (2026-09-09, `getinfo` over SSH on Railway): node `biocoin-peer` — `blocks: 115366`, tip hash above, tip time **2018-03-29**, `moneysupply ≈ 818600206 BIO`, `connections: 3–4` (all to the second Railway node). The second node was at 115365. Checkpoints through **112342** match the live tip; **130000+** are missing. If RPC is unavailable, treat **115366 as last observed**.

## How to continue

1. Obtain **authentic** BioCoin `blk*.dat` and/or `bootstrap.dat` that cover height **after 115366**, preferably **after checkpoint 170000**. Do not load foreign block databases or foreign wallets.
2. Look for a live P2P peer that speaks magic **`b4 f9 e1 a5`** on port **24885**. Human outreach leads that remain open: YoBit (no reply so far), Telegram `@biocoinchat_ru` / `@biocoinchat`, former operators.
3. Run a node from this repository (Docker or `makefile.unix`). Example peer: `addnode=altaria.proxy.rlwy.net:45218`. **Do not disable checkpoints** to “skip” 170000. Keep the Railway island online.
4. The website is independent: https://biocoin.blackithart.com — it is not in this git tree.
5. A local wallet can be used with the node. **Never commit** wallets, keys, or private backups.

More detail: [`doc/revival-2026.md`](doc/revival-2026.md).

## Build and run

The commands below match the files in the tree. Do not invent other ports or magic.

### Linux daemon

See also `doc/build-unix.txt`. Short version (Ubuntu/Debian):

```
sudo apt-get install build-essential libssl-dev libdb++-dev libboost-all-dev
cd src
make -f makefile.unix
strip BioCoind
```

Ubuntu 22.04/24.04 ship OpenSSL 3 and Boost 1.74+. On `master` without the compatibility patches, an OpenSSL 3 build typically fails. Patches and Docker are in the Linux-build / Railway-node PRs on this repository.

Qt wallet: `doc/readme-qt.rst`. QR codes are optional: `libqrencode-dev` and `qmake USE_QRCODE=1`.

### Node config

`~/.BioCoin/BioCoin.conf`:

```
daemon=1
server=1
listen=1
rpcuser=(username)
rpcpassword=(strong password)
port=24885
rpcport=24889
addnode=altaria.proxy.rlwy.net:45218
```

Then `BioCoind`. To join the live peer by hand: `BioCoind addnode altaria.proxy.rlwy.net:45218 add`.

An empty node **will not** catch checkpoint 170000 until there are blocks after 115366.

### Docker and Railway

`Dockerfile`, `docker/entrypoint.sh`, and `railway.toml` land with the Linux/Docker PRs (they may not be on current `master`). When they are in the tree:

```
docker build -t biocoin-peer .
docker run --rm -p 24885:24885 \
  -v biocoin-data:/data \
  -e BIOCOIN_ADDNODE=altaria.proxy.rlwy.net:45218 \
  biocoin-peer
```

Entrypoint variables: `BIOCOIN_DATADIR` (default `/data`), `BIOCOIN_P2P_PORT` (`24885`), `BIOCOIN_RPC_PORT` (`24889`), `BIOCOIN_RPC_USER`, `BIOCOIN_RPC_PASSWORD`, `BIOCOIN_ADDNODE`, `BIOCOIN_EXTERNAL_IP`, `BIOCOIN_EXTRA_ARGS`. RPC in the image listens on `127.0.0.1`.

`railway.toml`: builder `DOCKERFILE`, `dockerfilePath = "Dockerfile"`, restart `ON_FAILURE` (5 retries). Railway project: `biocoin-peer`.

A local wallet can be used with the node. Do not load a foreign wallet into `/data`, and do not commit a volume that contains keys.

## Website (separate project)

https://biocoin.blackithart.com is a separate public site. It is not the blockchain. Do not put the site sources in **this** repository.

## License

MIT/X11, see `COPYING`. Historical base is Bitcoin / PPCoin / NovaCoin.
