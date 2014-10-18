#!/usr/bin/env bash

set -e

# create the data folder in case we didn't mount one
mkdir -p /var/lib/earthcoin

# copy the config file to earthcoin's data directory in case it's missing
cp -n /var/tmp/earthcoin.conf /var/lib/earthcoin/earthcoin.conf

# remove the blueprint to avoid confusion
rm /var/tmp/earthcoin.conf
