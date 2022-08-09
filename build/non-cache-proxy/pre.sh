#!/usr/bin/env bash

set -exuo pipefail

gomplate -f /etc/gomplate/tinyproxy.conf.gotmpl -o /etc/tinyproxy/tinyproxy.conf
exec tinyproxy -d
