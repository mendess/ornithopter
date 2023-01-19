#!/bin/bash

self=$(realpath "$0")

cd ~/ornithopter || exit

git pull --rebase || exit

rsync -av --exclude=core --exclude=.git . ~/

ln -sfv "$self" ~/.local/bin
