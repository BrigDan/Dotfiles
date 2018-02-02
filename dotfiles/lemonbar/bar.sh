#!/usr/bin/env dash
# we don't need bash for this script, save performances by using dash / sh

a='%{F#F7A5BB}'
n='%{F-}'

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
        1) echo " ${a}${n}";;
        2) echo " ${a}${n}";;
        3) echo " ${a}${n}";;
        4) echo " ${a}${n}";;
        5) echo " ${a}${n}";;

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

while echo "%{l}$(workspaces)%{r}%{F#FFFFFF}%{B#F08398}$(currentsong)%{F#FFFFFF}%{B#F68EB6}$(volume)%{F#FFFFFF}%{B#d16ead}$(battery)%{F-}%{B-}%{c}%{F#FFFFFF}%{B#DEA9DD} $(clock) %{F-}%{B-}"; do # i'd recomment puting your output here to allow your bar to die properly
    sleep .2s # i'd also recommend puting a smaller sleep time to make the bar more responsive (which is nice for workspaces for example)
done |\
    lemonbar \
    -B '#373b41' \
    -F '#FFFFFF' \
    -f 'ProFont'-11 \
    -f 'WunconSiji'

