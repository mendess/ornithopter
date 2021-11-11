#!/bin/bash

exec &>~/lmao
set -x

# cat "$0" | grep -v termux-chroot | sed "s/$<>/${1:-100}/" | termux-chroot ; exit
echo $HOME

SOCKET="$HOME/.cache/mpvsocket_cache"
if pgrep mpv; then
    echo '{ "command": ["set_property", "pause", false] }' |
        socat - "$SOCKET"
else
    rm "$SOCKET"*
    mpv --input-ipc-server="$SOCKET" \
        --no-video \
        --loop-playlist \
        --quiet \
        --shuffle \
        --volume=${1:-100} \
        media/music/ &
fi
~/.config/m/update_panel.sh
pgrep jukebox ||
    ~/.local/share/cargo/bin/jukebox \
        --room phone \
        jukebox &
