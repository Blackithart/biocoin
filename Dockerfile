# BioCoind peer node for Railway / any Docker host.
FROM ubuntu:24.04 AS build
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        ca-certificates \
        libboost-filesystem-dev \
        libboost-program-options-dev \
        libboost-system-dev \
        libboost-thread-dev \
        libdb++-dev \
        libssl-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src
COPY share /src/share
COPY src /src/src

WORKDIR /src/src
RUN mkdir -p obj \
        crypto/scrypt/generic/obj \
        crypto/scrypt/asm/obj \
        crypto/scrypt/intrin/obj \
        crypto/sha2/asm/obj \
    && make -f makefile.unix -j"$(nproc)" \
    && strip BioCoind

FROM ubuntu:24.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates \
        libboost-filesystem1.83.0 \
        libboost-program-options1.83.0 \
        libboost-system1.83.0 \
        libboost-thread1.83.0 \
        libdb5.3++t64 \
        libssl3 \
        openssl \
    && rm -rf /var/lib/apt/lists/*

COPY --from=build /src/src/BioCoind /usr/local/bin/BioCoind
COPY docker/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 24885 24889
WORKDIR /data
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
