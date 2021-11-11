#!/bin/bash

pkill jukebox
echo '{ "command": ["set_property", "pause", true] }' |
    socat - ~/.cache/mpvsocket_cache
