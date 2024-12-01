#! /usr/bin/env sh

if [ $(xrandr --query | grep -c 'HDMI-1 connected') -eq 1 ]; then
    xrandr --output HDMI-1 --brightness .3
    i3lock -ueni ~/Pictures/gem_full.png
    xrandr --output HDMI-1 --brightness 1
else
    brightnessctl -s set 5
    i3lock -ueni ~/Pictures/gem_full.png
    brightnessctl -r
fi

dunstify -t 750 "Welcome Back"
xkbset bell sticky -twokey -latchlock feedback led stickybeep
