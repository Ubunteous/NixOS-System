#!/usr/bin/env bash

# Options
shutdown=''
reboot=''
lock=''
suspend=''
# logout=''
logout=''
leave=''

# Pass variables to rofi dmenu
run_rofi() {
    echo -e "$reboot\n$shutdown\n$lock\n$suspend\n$logout\n$leave" \
	| rofi \
	      -dmenu \
	      -scroll-method 0 \
	      -selected-row 1 \
	      -mesg "Goodbye ${USER}!" \
	      -theme $HOME/.config/rofi/powermenu.rasi
    # -p "Uptime: $uptime" \
			    }


# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
	systemctl poweroff
	;;
    $reboot)
	systemctl reboot
	;;
    $lock)
	brightnessctl -s set 5 && i3lock -ueni ~/Pictures/gem_full.png; brightnessctl -r
	;;
    $suspend)
	amixer set Master mute
	systemctl suspend
	;;
    $logout)
	pkill -U $USER
	;;
esac
