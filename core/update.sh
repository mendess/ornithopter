#!/bin/bash

cd ~/ornithopter || exit

git pull --rebase || exit

rsync -av --exclude=core --exclude=.git . ~/

./core/from-spells.sh

cp "$0" ~/.local/bin
