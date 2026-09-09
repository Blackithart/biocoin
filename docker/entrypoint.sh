#!/bin/sh
set -eu

DATADIR="${BIOCOIN_DATADIR:-/data}"
P2P_PORT="${BIOCOIN_P2P_PORT:-24885}"
RPC_PORT="${BIOCOIN_RPC_PORT:-24889}"
RPC_USER="${BIOCOIN_RPC_USER:-biocoin}"
CONF="${DATADIR}/BioCoin.conf"

mkdir -p "${DATADIR}"

if [ -z "${BIOCOIN_RPC_PASSWORD:-}" ]; then
    if [ -f "${CONF}" ]; then
        BIOCOIN_RPC_PASSWORD="$(sed -n 's/^rpcpassword=//p' "${CONF}" | head -n1)"
    fi
    if [ -z "${BIOCOIN_RPC_PASSWORD:-}" ]; then
        BIOCOIN_RPC_PASSWORD="$(openssl rand -hex 16)"
    fi
fi

# Always rewrite the runtime bits we care about; keep extra user lines if present.
{
    echo "rpcuser=${RPC_USER}"
    echo "rpcpassword=${BIOCOIN_RPC_PASSWORD}"
    echo "rpcport=${RPC_PORT}"
    echo "rpcallowip=127.0.0.1"
    echo "port=${P2P_PORT}"
    echo "daemon=0"
    echo "server=1"
    echo "listen=1"
    echo "dns=1"
    echo "dnsseed=1"
    echo "noirc=1"
    echo "printtoconsole=1"
    if [ -n "${BIOCOIN_EXTERNAL_IP:-}" ]; then
        echo "externalip=${BIOCOIN_EXTERNAL_IP}"
    fi
} > "${CONF}"

WALLET="${DATADIR}/wallet.dat"
RESTORE="${DATADIR}/wallet.dat.restore"
EXTRA_ARGS="${BIOCOIN_EXTRA_ARGS:-}"

# One-shot restore: copy a replacement wallet onto the volume, then restart.
# The incoming file is renamed so this does not re-run on later restarts.
if [ -f "${RESTORE}" ]; then
    if [ -f "${WALLET}" ]; then
        mv "${WALLET}" "${WALLET}.bak-$(date +%s)"
    fi
    mv "${RESTORE}" "${WALLET}"
    chmod 600 "${WALLET}" || true
    EXTRA_ARGS="-rescan"
fi

# shellcheck disable=SC2086
exec BioCoind \
    -datadir="${DATADIR}" \
    -printtoconsole \
    -daemon=0 \
    -server=1 \
    -listen=1 \
    -port="${P2P_PORT}" \
    ${EXTRA_ARGS} \
    "$@"
