#!/bin/bash

CERTBOT_ARGS=()

function parse_eab_credentials()
{
    PYTHONIOENCODING=utf8
    WISEKEY_EAB_KID=$(echo $1 | python -c "import sys, json; print(json.load(sys.stdin)['eab_kid'])")
    WISEKEY_EAB_HMAC_KEY=$(echo $1 | python -c "import sys, json; print(json.load(sys.stdin)['eab_hmac_key'])")
    CERTBOT_ARGS+=(--eab-kid "$WISEKEY_EAB_KID" --eab-hmac-key "$WISEKEY_EAB_HMAC_KEY" --server "https://acme.certifyid.com/directory?type=dv")
}

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --wisekey-api-key=*)
            WISEKEY_API_KEY="${1:18}"
        ;;
        --wisekey-api-key|-z)
           WISEKEY_API_KEY="${2}"
           shift
        ;;
        --wisekey-email=*)
            WISEKEY_EMAIL="${1:16}"
        ;;
        --email|--wisekey-email|-m)
           WISEKEY_EMAIL="${2}"
           CERTBOT_ARGS+=(-m "${2}")
           shift
        ;;
        *) CERTBOT_ARGS+=("$1") ;;
    esac
    shift
done

set -- "${CERTBOT_ARGS[@]}"

if [[ -n $WISEKEY_API_KEY ]]; then
    parse_eab_credentials $(curl -s -X POST "https://api.zerossl.com/acme/eab-credentials?access_key=$ZEROSSL_API_KEY")
elif [[ -n $WISEKEY_EMAIL ]]; then
    parse_eab_credentials $(curl -s https://api.zerossl.com/acme/eab-credentials-email --data "email=$ZEROSSL_EMAIL")
fi

echo ${CERTBOT_ARGS[@]}
certbot ${CERTBOT_ARGS[@]}
