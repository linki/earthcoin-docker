# EarthCoin Docker Container

Runs an EarthCoin node on Mainnet inside a docker container.
A second container is used to persist the data between docker runs.

Use it like so:

    $ docker build -t linki/earthcoin .
    $ docker run -v /var/earthcoin-data --name earthcoin-data busybox true
    $ docker run -d -p 15677:15677 --volumes-from earthcoin-data linki/earthcoin

Purpose of this container is to run a node that supports the network,
so there's no wallet and you cannot connect via rpc.
The separate data container is intended as cache for the blockchain
in case the container exits, not for backup.

You can also use `fig up`.

Have a look inside the container with:

    $ docker run -ti --rm --volumes-from earthcoin-data linki/earthcoin /bin/bash

or alternatively:

    $ fig run --rm earthcoin /bin/bash
