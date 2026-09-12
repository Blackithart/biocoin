# BioCoin (BIO)

This repository is the **BioCoin node and wallet source**: the `BioCoind` daemon and the `BioCoin-qt` graphical wallet. It is not a website and not a block database.

BioCoin is a NovaCoin/Peercoin-style proof-of-stake coin launched around the 2017 LavkaLavka / eco-loyalty ICO.

| | |
| --- | --- |
| Ticker | BIO |
| P2P port | `24885` |
| RPC port | `24889` |
| Network magic | `b4 f9 e1 a5` |
| Protocol | `90000` |
| Config | `~/.BioCoin/BioCoin.conf` (directory name is case-sensitive) |

Marketing site (not this repo, not the blockchain): https://biocoin.blackithart.com

**If any of this is useful to you, write to [info@blackithart.com](mailto:info@blackithart.com).**

## Current affairs (2026-09-12)

This is where things stand. Nothing further will be built from this side.

- Two Railway peers still speak BioCoin `1.0.1.2` (magic `b4 f9 e1 a5`, protocol `90000`):
  - `altaria.proxy.rlwy.net:45218`
  - `altaria.proxy.rlwy.net:22792`
- Both advertise height **115366**, tip hash `0553d020c4e03f4c54adbeeff37d48551c175e4eb273c202e077f1902714ef60`. Last observed tip time is **2018-03-29**. Moneysupply last seen on RPC was about **818.6M BIO**.
- There is **no** external peer network. The two Railway nodes only see each other. DNS seeds are empty. Hardcoded `pnSeed[]` IPs are dead on `:24885`. `n001`–`n013.biocoin.pro` are NXDOMAIN.
- Hardened checkpoints in `src/checkpoints.cpp` go to block **170000** (August 2018). The live island stops at **115366**. There is no downloadable `blk*.dat` / `bootstrap.dat` past that height. Wayback Machine explorer JSON shows the chain once continued through checkpoint 170000 and up to ~260k by 2019. That is historical proof only, not a download source.
- The original operator has **no more** `blk` files, peers, or backups. Blackithart GitHub releases are Qt wallets only.
- YoBit still lists `bio_*` markets. Last `bio_btc` trade seen was 2026-01-04. Volume on a 2026-09-12 check was **0**. Price sits at the 1-satoshi floor. Outreach got no reply.
- The ticker **BIO** on large venues is now a different project (Bio Protocol / DeSci). It is not this coin.
- Linux/OpenSSL 3/Boost patches, Docker, and Railway peer files are on `master`. A one-shot `wallet.dat.restore` path exists in the Docker entrypoint. Wallets and keys must never be committed.
- Site https://biocoin.blackithart.com is a separate Laravel project (Railway `biocoin-web`). A `/ru` and `/en` redirect loop was fixed on 2026-09-12 (`/` still 302s to `/ru`, then serves the 2017 landing).
- The 2017 site promised a global loyalty platform, card, mobile wallet, ICO factory, ERP, and internal exchange. This repository is only a Peercoin-style daemon. The 2018 TalkBank Visa cobrand (RUB spend, BIO as a loyalty-point commodity for compensation) is not in this tree and is not running.

Technical revival notes: [`doc/revival-2026.md`](doc/revival-2026.md). How to run a node: [`doc/BioCoin_Node_Setup.txt`](doc/BioCoin_Node_Setup.txt).

## We cannot take this further

**We cannot do anything more here. We do not have the capabilities.**

There are no remaining chain files after 115366, no live historical peer, no merchant network, no card program, no licensed bank stack, and no mandate or resources to rebuild the 2017 product (loyalty SaaS, cobrand cards, a new L1/L2 token, Mastercard/Visa worldwide, an exchange, or an ICO platform).

This repository stays as a public record of the node source and of the 2026 revival attempt. The Railway island may stay up as an archive. It is not a path to “finish” BioCoin.

If someone else has authentic blocks past 115366, a live peer with this magic, or a reason to reuse the idea, they can do that work themselves.

**Contact:** [info@blackithart.com](mailto:info@blackithart.com)

## Reflections (English)

These notes record a 2026 review of the site, this repo, the 2018 TalkBank card, and whether the 2017 promises should be rebuilt on another blockchain. They are not a roadmap and not an offer.

### The site and this repo are not the same product

| Layer | What it actually is |
| --- | --- |
| This repo | Peercoin/Novacoin-style PoS: send, receive, stake. No smart contracts, no loyalty, no cards. |
| Site | 2017 ICO landing plus a Laravel CRM (invoices, legal-entity forms, partner signup). Loyalty lived in a **database**, not on-chain. |
| Network now | Two-node island at 115366. No external P2P. |

The landing page sold: BIO instead of shop points, a card usable worldwide, the SAVL wallet, integration with other loyalty systems, ERP, a token factory on Ethereum/Waves, an internal exchange, thousands of companies by end of 2018, and a flywheel where businesses buy BIO on exchanges so the price rises.

This tree never implemented those products. It is a coin daemon.

### TalkBank (2018)

In May–June 2018 BioCoin / LavkaLavka shipped a **Visa cobrand with TalkBank**, not the “Mastercard” line on the marketing page.

How it worked in public statements: pay **rubles** on Visa anywhere the card was accepted. BIO was **not** spent at the till. The legal wrapper presented BIO as a commodity / a right to a loyalty point. Holders could compensate ruble spend, sell BIO in the TalkBank chatbot, and receive BIO cashback at loyalty partners. The card was sold for about 3,000 RUB with free servicing. TalkBank spoke of ~1,000 preorders and up to ~7,000 cards by year end.

TalkBank was the rail: KYC, issuance, Visa, messenger bot. LavkaLavka was the shops and the BIO↔RUB rate. The Laravel site was forms and invoices. **The daemon in this repo was decorative for that product.** The card could exist even if the P2P network was weak, as long as the bank and the till worked.

TalkBank still exists in 2026 as Russian BaaS (cobrand cards, loyalty, virtual/plastic cards). The 2018 “legal crypto compensation card” does not map cleanly onto later Russian digital-asset rules. “Pay worldwide” from a Russian Visa issuer is also not the 2018 story anymore. The BioCoin cobrand is not a live product.

### Another blockchain

Moving “everything the site promised” onto Base, Solana, TON, or similar is technically easier than reviving this L1 (wallets, cheap transactions, contracts). It does **not** restore old BIO, because there is no complete chain for an honest snapshot. A new token would be a **new project**, with a **new ticker** (BIO is taken).

It also does not replace a bank. Cards, identification, and ruble settlement still need a TalkBank-class vendor. The 2017 flywheel (“shops buy BIO, price goes up”) is a broken ICO model and reads like a public securities pitch.

A full rebuild of Mastercard/Visa worldwide, an exchange, an iOS wallet, and ERP is a licensed company, not a weekend port of this repository.

### LLM council (2026-09-12)

Independent notes from Claude Opus, GPT, Gemini, and Muse, then a chairman synthesis:

- **Consensus:** do not port the 2017 roadmap to another chain; do not revive this L1; money, if any, is merchant SaaS, point float, interchange, breakage — not a token price; kill the ICO factory / internal exchange / ERP; the CRM/invoice code is the only salvageable site piece.
- **Harder than the first draft:** the token should not sit on the roadmap for a Russia-based product. The 2018 card worked *because* BIO was not at the till. A hybrid “Russian BaaS + tradable token” inherits both regulators. TalkBank is a **replaceable vendor**, not a strategy. The ~1,000 card preorders were packaging, not proven demand. The real 2017 asset was the LavkaLavka merchant network, which is not here in that form.
- **Council next step, if anyone else tries:** a paid pilot with 5–10 real shops on **fiat / ruble points**, no card and no token. If shops will not pay for that, nothing downstream matters.

### Bottom line

Another chain gives tools, not revenue. TalkBank packaged the only consumer-facing piece in 2018; it did not make the ICO true. This side **cannot** implement the promised platform, restore the missing chain, or stand up a bank/card/token business.

Record stays public. Work from this side stops here.

**[info@blackithart.com](mailto:info@blackithart.com)**

## Revival work that was done (2026)

1. The source builds on current Linux (OpenSSL 3, Boost). Docker and Railway config are in this tree (`Dockerfile`, `docker/entrypoint.sh`, `railway.toml`).
2. Two public peer nodes in Railway project `biocoin-peer` (production), addresses above. They see each other over P2P.
3. A local wallet can be used with the node. Wallets and keys **must never be committed**.
4. The old public site was restored separately at **https://biocoin.blackithart.com**.
5. YoBit was contacted; there was no response.

What was not recovered: **the chain after height 115366.**

## If someone else continues

1. Obtain **authentic** BioCoin `blk*.dat` and/or `bootstrap.dat` after **115366**, preferably after checkpoint **170000**. Do not load foreign block databases or foreign wallets.
2. Find a live P2P peer with magic **`b4 f9 e1 a5`** on port **24885**. Old leads: YoBit (silent), Telegram `@biocoinchat_ru` / `@biocoinchat`, former operators.
3. Run a node from this repository. Example: `addnode=altaria.proxy.rlwy.net:45218`. **Do not disable checkpoints.**
4. The website is independent of this git tree.
5. **Never commit** wallets, keys, or private backups.

This side will not do that work. Mail [info@blackithart.com](mailto:info@blackithart.com) if you intend to.

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

Ubuntu 22.04/24.04 ship OpenSSL 3 and Boost 1.74+. Compatibility patches for those libraries are on `master`.

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
