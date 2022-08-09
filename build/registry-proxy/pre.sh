#!/usr/bin/env bash

set -exuo pipefail

update-ca-certificates
if [ "$${AUTH_REGISTRIES}" = "::" ]; then
    unset "$${AUTH_REGISTRIES}"
fi

gomplate -f /etc/gomplate/nginx.conf.gotmpl -o /etc/nginx/nginx.conf
exec /entrypoint.sh
