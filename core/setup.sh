#!/bin/bash
pkgs=(
    bat
    bc
    coreutils
    curl
    exa
    ffmpeg
    file
    fzf
    gawk
    git
    grep
    imagemagick
    inetutils
    jq
    less
    man
    mpv
    neovim
    net-tools
    nmap
    perl
    python
    ripgrep
    rsync
    socat
    tar
    termux-api
    termux-auth
    termux-tools
    tmux
    ttf-dejavu
    unzip
    wget
    zip
)
pkg up
pkg install -y "${pkgs[@]}"
echo "===== YOUTUBE DL ====="
curl -s -L https://yt-dl.org/downloads/latest/youtube-dl -o /data/data/com.termux/files/usr/bin/youtube-dl
chmod a+rx /data/data/com.termux/files/usr/bin/youtube-dl
youtube-dl --version
echo "=====  STORAGE  ====="
termux-setup-storage
mkdir ~/media/
cp ~/storage/music/ ~/media/music
