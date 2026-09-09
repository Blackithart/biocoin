# BioCoin wallet source

This repository is the **BioCoin wallet** source tree: the `BioCoin-qt` graphical wallet and the `BioCoind` daemon.

RPC port: `24889`  
Network port: `24885`

## Build the daemon (Linux)

See `doc/build-unix.txt`. Short version on current Ubuntu/Debian:

```
sudo apt-get install build-essential libssl-dev libdb++-dev libboost-all-dev
cd src
make -f makefile.unix
```

## Build the Qt wallet

See `doc/readme-qt.rst` and `doc/building novacoind and novacoinqt under Linux.txt`.

QR codes are optional. Install `libqrencode-dev` and pass `USE_QRCODE=1` to `qmake` if you want them:

```
qmake USE_QRCODE=1
make
```

## Run a node

See `doc/BioCoin_Node_Setup.txt`.

```
git clone https://github.com/Blackithart/biocoin
cd biocoin/src
make -f makefile.unix
strip BioCoind
```

Config is `~/.BioCoin/BioCoin.conf` (case sensitive):

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

Then run `BioCoind`. Join the live peer with `addnode altaria.proxy.rlwy.net:45218 add`.
