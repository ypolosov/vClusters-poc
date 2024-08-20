#!/usr/bin/env bash
set -e

echo "Activating feature 'XDG utils'"

apt-get update && export DEBIAN_FRONTEND=noninteractive &&
    apt-get -y install --no-install-recommends \
        gpg \
        coreutils \
        xdg-utils
