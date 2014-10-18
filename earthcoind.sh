#!/bin/sh
exec /sbin/setuser root \
  /usr/local/bin/earthcoind -datadir=/var/lib/earthcoin -printtoconsole
