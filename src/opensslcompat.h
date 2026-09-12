// Copyright (c) 2009-2012 The Bitcoin developers
// Distributed under the MIT/X11 software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.
#ifndef BITCOIN_OPENSSL_COMPAT_H
#define BITCOIN_OPENSSL_COMPAT_H

#include <openssl/opensslv.h>
#include <openssl/crypto.h>
#include <openssl/evp.h>
#include <openssl/ecdsa.h>
#include <openssl/bn.h>

#if OPENSSL_VERSION_NUMBER < 0x10100000L

inline EVP_CIPHER_CTX *EVP_CIPHER_CTX_new(void)
{
    EVP_CIPHER_CTX *ctx = new EVP_CIPHER_CTX();
    EVP_CIPHER_CTX_init(ctx);
    return ctx;
}

inline void EVP_CIPHER_CTX_free(EVP_CIPHER_CTX *ctx)
{
    if (ctx) {
        EVP_CIPHER_CTX_cleanup(ctx);
        delete ctx;
    }
}

inline void ECDSA_SIG_get0(const ECDSA_SIG *sig, const BIGNUM **pr, const BIGNUM **ps)
{
    if (pr != NULL)
        *pr = sig->r;
    if (ps != NULL)
        *ps = sig->s;
}

inline int ECDSA_SIG_set0(ECDSA_SIG *sig, BIGNUM *r, BIGNUM *s)
{
    if (r == NULL || s == NULL)
        return 0;
    BN_clear_free(sig->r);
    BN_clear_free(sig->s);
    sig->r = r;
    sig->s = s;
    return 1;
}

#endif

#if OPENSSL_VERSION_NUMBER >= 0x10100000L
#define OPENSSL_VERSION_STRING OpenSSL_version(OPENSSL_VERSION)
#else
#define OPENSSL_VERSION_STRING SSLeay_version(SSLEAY_VERSION)
#endif

#endif
