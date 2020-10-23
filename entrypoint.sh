#!/bin/sh -l
set -eux

# hack, move home to $HOME(/github/home)
ln -s /root/.cargo $HOME/.cargo
ln -s /root/.rustup $HOME/.rustup

# go to the repo root
cd $GITHUB_WORKSPACE
export CARGO_TARGET_DIR=$GITHUB_WORKSPACE/target
sh -c "$*"
