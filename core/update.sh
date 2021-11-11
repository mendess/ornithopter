#!/bin/bash

cd ~/ornithopter || exit

rsync -av --exclude=core --exclude=.git . ~/

./core/from-spells.sh
