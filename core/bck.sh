#!/bin/bash

cd ~/storage || exit

shopt -s extglob
rsync -av --exclude=*thumb* $(realpath !(shared)) tolaria:.hdd/phone/
