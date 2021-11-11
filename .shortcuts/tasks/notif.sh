#!/bin/bash

ssh mirrodin scraping/all.sh | grep -v -e 'Sem Stock' -e 'Esgotado' | grep -Po 'http.*' |
    while read -r link; do
        termux-notification --action "pkill mpv ; termux-open $link" -t poggers -c "$(basename "$link")"
        echo "$link"
        ssh tolaria firefox "$link" &
        if [ ! "$i" ]; then
            {
                ssh mirrodin automation/welcome_home.sh &
                termux-volume music 100
                mpv 'https://www.youtube.com/watch?v=sAXZbfLzJUg' 'https://www.youtube.com/watch?v=sAXZbfLzJUg' 'https://www.youtube.com/watch?v=sAXZbfLzJUg' 'https://www.youtube.com/watch?v=sAXZbfLzJUg' 'https://www.youtube.com/watch?v=sAXZbfLzJUg' 'https://www.youtube.com/watch?v=sAXZbfLzJUg' 'https://www.youtube.com/watch?v=sAXZbfLzJUg' 'https://www.youtube.com/watch?v=sAXZbfLzJUg' 'https://www.youtube.com/watch?v=sAXZbfLzJUg' 'https://www.youtube.com/watch?v=sAXZbfLzJUg' &
            } &
        fi
        i=1
    done
