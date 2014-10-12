# EarthCoin Docker Container

Runs an EarthCoin node on Testnet inside a docker container.

Build it:

    $ docker build -t linki/earthcoin .

Use it like so:

    $ docker run -d -p 25677:25677 linki/earthcoin

A second container can be used to persist the data between docker runs (recommended).

    $ docker run -v /var/lib/earthcoin --name earthcoin-data busybox true
    $ docker run -d -p 25677:25677 --volumes-from earthcoin-data linki/earthcoin

Purpose of this container is to run a node that supports the network,
so there's no wallet and you cannot connect via rpc.
The separate data container is intended as cache for the blockchain
in case the container exits, not for backup.

You can also use `fig up` to run it.

Have a look inside the container with:

    $ docker run -ti --rm --volumes-from earthcoin-data linki/earthcoin /bin/bash

or alternatively:

    $ fig run --rm earthcoin /bin/bash
