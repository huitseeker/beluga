#!/bin/bash -eux

set -a

curl https://sh.rustup.rs -sSf | bash -s -- -y -q --profile minimal --no-modify-path
export PATH=$HOME/.cargo/bin:$PATH
. $HOME/.cargo/env

if [ ! "$*" = "" ]; then
    /bin/bash -c "$*"
fi
