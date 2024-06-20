#! /usr/bin/env bash

#   "
output="   |    |   "

# xprop displays info about the current desktop
# cut retrieves the third word which contains the desktop id
# the id is updated to match the position in the output string
curr_ws="$(xprop -root -notype _NET_CURRENT_DESKTOP | cut -d ' ' -f 3)"

# wmctrl -l lists all windows and their workspaces
# we retrieve the workspace id with cut
# tr removes unwanted line breaks and id duplicates (including current workspace which may is distinguished from busy workspaces with at least one window open)
busy_ws=$(wmctrl -l | cut -d ' ' -f 3 | tr -d '\n' | tr -s '0-9' | tr -d $curr_ws)

# we replace  (circle) in the output by  (full circle)
# this represents used workspaces
for (( i=0; i<${#busy_ws}; i++ )); do
    # 0 1 2 |  3  4  5 |  6  7  8
    # 1 3 5 |  9 11 13 | 17 18 19
    id_ws="${busy_ws:$i:1}"
    id_real=$(( (id_ws / 3)*8 + (id_ws % 3)*2 + 1))
    output=$(sed s/.//"$id_real" <<< "$output")
done

# current workspace must be replaced by  (dot-circle-o) or  (paw faicon)
curr_ws=$(( (curr_ws / 3)*8 + (curr_ws % 3)*2 + 1))
# output=$(sed s/.//"$curr_ws" <<< "$output")
output=$(sed s/.//"$curr_ws" <<< "$output")
echo "$output"
