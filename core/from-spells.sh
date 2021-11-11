#!/bin/bash

spells=(
    wmgr
)

for s in "${spells[@]}"; do
    echo "getting $s.spell"
    wget -N --quiet \
        "https://raw.githubusercontent.com/mendess/spell-book/master/spells/$s.spell" \
        -O ~/.local/bin/"$s"
    chmod +x ~/.local/bin/"$s"
done
