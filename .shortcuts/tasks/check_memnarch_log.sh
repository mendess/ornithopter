#!/bin/bash

log=$(ssh mirrodin cat memnarch_critical_error.log)

if [ "$log" ]; then
    termux-notification \
        --title "Memnarch encountered an error" \
        --priority high \
        --led-color ff0000 \
        --led-on 2000 \
        --led-off 1000 \
        --vibrate 500,1000,200 \
        --sound \
        --content "$log"
fi
