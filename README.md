# BioCoin (BIO)

This repository is the **BioCoin node and wallet source**: the `BioCoind` daemon and the `BioCoin-qt` graphical wallet. BioCoin is a NovaCoin/Peercoin-style proof-of-stake coin.

| | |
| --- | --- |
| Ticker | BIO |
| P2P port | `24885` |
| RPC port | `24889` |
| Network magic | `b4 f9 e1 a5` |
| Protocol | `90000` |

**Revival (2026), short status.** The daemon was made to build on current Linux (OpenSSL 3 / Boost) and two Railway peer nodes were brought online. They talk to each other. The chain they share stops at last observed height **115366** (moneysupply about **818.6M BIO**, 2026-09-09). Hardened checkpoints in `src/checkpoints.cpp` go to block **170000** (August 2018). A genesis-only node cannot pass that checkpoint. The original operator (Artem Kalinin / Blackithart) has **no further chain data, wallets, backups, or peers to supply**. Continuation needs authentic `blk*.dat` / `bootstrap.dat` past 115366 (ideally past 170000) and/or an external live BIO peer.

Marketing site (not this repo, not the blockchain): https://biocoin.blackithart.com

Details: [`doc/revival-2026.md`](doc/revival-2026.md). How to run a node: [`doc/BioCoin_Node_Setup.txt`](doc/BioCoin_Node_Setup.txt).

---

# BioCoin — исходники ноды и кошелька

Это публичный репозиторий **ноды и кошелька BioCoin**: демон `BioCoind` и графический кошелёк `BioCoin-qt`. Это не сайт, не ICO-кабинет и не база блоков.

BioCoin — монета на proof-of-stake в линии NovaCoin / Peercoin.

- Тикер: **BIO**
- P2P: **24885**
- RPC: **24889**
- Magic: **`b4 f9 e1 a5`**
- Конфиг: `~/.BioCoin/BioCoin.conf` (регистр имени каталога важен)

## Попытка возрождения, 2026

Что сделано:

1. Исходники приведены к сборке на современном Linux (OpenSSL 3, Boost). Добавлены Docker-образ и конфиг Railway. Эта работа живёт в отдельных PR к этому репозиторию (Linux/Docker и запуск peer-ноды), её ещё может не быть в `master`.
2. Подняты две публичные peer-ноды в Railway-проекте `biocoin-peer` (production):
   - `biocoin-peer` — `altaria.proxy.rlwy.net:45218`
   - `biocoin-peer-2` — `altaria.proxy.rlwy.net:22792` (`BIOCOIN_ADDNODE=altaria.proxy.rlwy.net:45218`)
   Ноды видят друг друга по P2P.
3. На ноду восстанавливался кошелёк из старого `dumpwallet`. Файлы кошелька и ключи **в этот репозиторий не входят и не должны попадать**.
4. Старый маркетинговый/лояльный сайт (Laravel 5.2, 2018) восстановлен отдельно и выложен на **https://biocoin.blackithart.com**. Это другой проект, не C++-дерево BioCoin.

Чего не получилось: **цепочка после высоты 115366 так и не найдена.** Чекпоинты в коде требуют блок **170000**. Без исторических `blk*.dat` / `bootstrap.dat` (лучше — за чекпоинт 170000) или живого внешнего пира с той же magic-подписью синхронизация полной истории невозможна.

Оператор исходной сети подтвердил: **больше данных нет** — ни оставшихся blk-файлов, ни дополнительных пиров, ни кошельков или бэкапов. Ждать недостающую цепочку от первоначальной команды не нужно.

## Текущее состояние

Работает:

- Сборка `BioCoind` на современном Linux (после патчей OpenSSL 3 / Boost; см. связанные PR).
- Docker-образ и деплой peer-ноды на Railway.
- Две ноды на Railway, связь между ними, общая высота около **115366**.
- Сайт https://biocoin.blackithart.com — страницы `/`, `/ru`, `/en`, `/fr`, `/blog`, `/faq`, `/loyalty`, `/media`. Маршруты ICO / send-coins / admin отключены.

Не работает / отсутствует:

- Историческая цепочка **после 115366** (до чекпоинта 170000 и далее).
- Сеть внешних пиров. Наблюдаемые соединения — между двумя нашими Railway-нодами.
- Полный синк с пустого genesis-состояния: `GetTotalBlocksEstimate()` смотрит на последний hardened checkpoint (**170000**). Чекпоинты **не отключать**.

Последние RPC-цифры (2026-09-09, `getinfo` по SSH на Railway): нода `biocoin-peer` — `blocks: 115366`, `moneysupply ≈ 818600206 BIO`, `connections: 3` (все на вторую нашу ноду). Вторая нода в тот момент была на 115365. Если RPC недоступен, считать **115366 last observed**.

## Как продолжить

Конкретные шаги для тех, у кого есть цепочка или живой пир:

1. Достать **аутентичные** BioCoin `blk*.dat` и/или `bootstrap.dat`, которые покрывают высоту **после 115366**, лучше **после чекпоинта 170000**. Не подкладывать чужие базы блоков и чужие `wallet.dat`.
2. Искать живой P2P-пир, который говорит magic **`b4 f9 e1 a5`** на порту **24885** (старые ноды, биржи, архивы). Подключать через `addnode`.
3. Поднять ноду из этого репозитория (Docker или `makefile.unix`). Пример пира: `addnode=altaria.proxy.rlwy.net:45218`. **Не отключать checkpoints** (`-cppolicy` / permissive) ради «обхода» 170000 — это сломает проверку известной истории.
4. Сайт независим: https://biocoin.blackithart.com — его нет в этом git-дереве и в него не нужно складывать ~66MB Laravel.
5. **Не коммитить** `wallet.dat`, `dumpwallet`, ключи, ICO JSON, приватные бэкапы.

Подробнее: [`doc/revival-2026.md`](doc/revival-2026.md).

## Сборка и запуск

Команды ниже совпадают с файлами в дереве. Не выдумывайте другие порты или magic.

### Демон на Linux

См. также `doc/build-unix.txt`. Кратко (Ubuntu/Debian):

```
sudo apt-get install build-essential libssl-dev libdb++-dev libboost-all-dev
cd src
make -f makefile.unix
strip BioCoind
```

На Ubuntu 22.04/24.04 стоят OpenSSL 3 и Boost 1.74+. В `master` без патчей совместимости сборка на OpenSSL 3, как правило, падает. Патчи и Docker — в PR Linux-сборки / Railway-ноды к этому репозиторию.

Qt-кошелёк: `doc/readme-qt.rst`. QR-коды опциональны: `libqrencode-dev` и `qmake USE_QRCODE=1`.

### Конфиг ноды

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

Затем `BioCoind`. Подключиться к живому пиру вручную: `BioCoind addnode altaria.proxy.rlwy.net:45218 add`.

Пустой узел **не** догонит чекпоинт 170000, пока нет блоков после 115366.

### Docker и Railway

Файлы `Dockerfile`, `docker/entrypoint.sh`, `railway.toml` появляются вместе с PR Linux/Docker (их может не быть в текущем `master`). Когда они в дереве:

```
docker build -t biocoin-peer .
docker run --rm -p 24885:24885 \
  -v biocoin-data:/data \
  -e BIOCOIN_ADDNODE=altaria.proxy.rlwy.net:45218 \
  biocoin-peer
```

Переменные entrypoint: `BIOCOIN_DATADIR` (по умолчанию `/data`), `BIOCOIN_P2P_PORT` (`24885`), `BIOCOIN_RPC_PORT` (`24889`), `BIOCOIN_RPC_USER`, `BIOCOIN_RPC_PASSWORD`, `BIOCOIN_ADDNODE`, `BIOCOIN_EXTERNAL_IP`, `BIOCOIN_EXTRA_ARGS`. RPC в образе слушает `127.0.0.1`.

`railway.toml`: builder `DOCKERFILE`, `dockerfilePath = "Dockerfile"`, restart `ON_FAILURE` (5 попыток). Проект Railway: `biocoin-peer`.

Не монтируйте в `/data` чужой `wallet.dat` и не коммитьте том с ключами.

## Сайт (отдельный проект)

https://biocoin.blackithart.com — восстановленный публичный сайт 2018 года. Блокчейном он не является. Исходники сайта в **этот** репозиторий класть не нужно.

## Лицензия

MIT/X11, см. `COPYING`. Историческая основа — Bitcoin / PPCoin / NovaCoin.
