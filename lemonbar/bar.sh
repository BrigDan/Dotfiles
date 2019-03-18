#!/usr/bin/env dash
# we don't need bash for this script, save performances by using dash / sh

# Import the colors
. "${HOME}/.cache/wal/colors.sh"

a='%{F#FFF}'
n='%{F#EEEEEE}'

battery() {
    cur=$(cat /sys/class/power_supply/BAT0/capacity)
    chargingstate=$(cat /sys/class/power_supply/BAT0/status)
    if [ "$cur" -eq 100 ]; then
        icon=""
    elif [ "$cur" -gt 75 ]; then
        icon=""
    elif [ "$cur" -gt 15 ]; then
        icon=""
    else
        icon=""
        # fi
    fi

    echo " ${icon}| ${cur}% "
}

workspaces() {
    cur=$(bspc wm -g | grep -o '[OFU][1-5]' | tail -c2)
    case "$cur" in
        1) echo "  I  ";;
        2) echo "  II  ";;
        3) echo "  III  ";;
        4) echo "  VI  ";;
        5) echo "  V  ";;

    esac
}

volume() {
    cur=$(amixer sget Master | grep -o -m1 '[0-9]*%')
    if amixer sget Master | grep -q off; then
        icon=;cur=muted
    else
        case "$cur" in
            0%) icon="";;
            *) icon="";; 
        esac
    fi
    echo " ${icon}| ${cur} "
}

currentsong(){
    cur=$(ncmpcpp --current-song | cut -c 7-300)
    icon=
    echo " ${icon}| ${cur} "
}

clock() {
        date +'%H:%M' # we don't need an useless echo to output a variable here
}

while echo "%{l}%{F#EEEEEE}%{B#525252}$(workspaces)%{r}%{F#EEEEEE}%{B#525252}$(volume)%{F-}%{B-}%{c}%{F#EEEEEE}%{B#525252} $(clock) %{F-}%{B-}"; do # i'd recomment puting your output here to allow your bar to die properly
    sleep .2s # i'd also recommend puting a smaller sleep time to make the bar more responsive (which is nice for workspaces for example)
done |\
    lemonbar \
    -g  1920x22 \
    -B  '#1b1b1b' \
    -F  $color8 \
    -f 'cherry'-9 \
    -f '-Wuncon-Siji-Medium-R-Normal--10-100-75-75-C-80-ISO10646-1'
