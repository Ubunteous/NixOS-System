from libqtile import layout
from libqtile.lazy import lazy
from libqtile.config import EzKey as Key
from libqtile import hook

# reload with: qtile cmd-obj -o cmd -f reload_config

import subprocess
from pathlib import Path
from decorators import (
    autostart,
    window_to_prev_group,
    window_to_next_group,
    groups,
    keybindings,
    rotslaves_up,
    rotslaves_down,
    swap_main,
    smart_change_layout,
    next_trio,
    prev_trio,
    next_within_trio,
    prev_within_trio,
    kill_unless_emacs,
)

command = Path(__file__).parent.absolute() / "commands.sh"
mod = "mod4"

############
# BINDINGS #
############

keys = [
    #########
    # SPAWN #
    #########
    Key("M-y", lazy.spawn("rofi -show drun")),
    Key("M-e", lazy.spawn("nemo")),
    Key("M-S-<Return>", lazy.spawn("wezterm")), # f"{command} randTerm"
    Key("M-S-l", lazy.spawn(f"{command} lock")),
    Key("M-<dollar>", lazy.spawn(f"{command.parent.parent}/rofi/powermenu.sh")),
    ###########
    # LAYOUTS #
    ###########
    Key("M-<space>", smart_change_layout),
    # Key("M-<space>", lazy.next_layout()),
    # Key("M-<space>", lazy.window.toggle_fullscreen()),
    Key("M-C-m", lazy.layout.maximize()),
    Key("M-n", lazy.layout.reset()),
    ###########
    # MONITOR #
    ###########
    Key("M-S-s", lazy.spawn("xrandr --output eDP-1 --auto")),
    Key("M-C-S-s", lazy.spawn(f"{command} hdmi")),
    ###########
    # WINDOWS #
    ###########
    Key("M-<Return>", swap_main),
    Key("M-x", kill_unless_emacs),
    Key("M-f", lazy.window.toggle_floating()),
    Key("M-u", lazy.layout.shuffle_up()),
    Key("M-r", rotslaves_down),
    Key("M-C-r", rotslaves_up),
    #############
    # WORKSPACE #
    #############
    Key("M-<up>", next_trio),
    Key("M-<down>", prev_trio),
    Key("M-C-<left>", window_to_prev_group, lazy.screen.prev_group()),
    Key("M-C-<right>", window_to_next_group, lazy.screen.next_group()),
    Key("M-<Left>", prev_within_trio),
    Key("M-<Right>", next_within_trio),
    Key("M-m", prev_within_trio),
    Key("M-i", next_within_trio),
    ############
    # FUNCTION #
    ############
    Key("<XF86AudioMute>", lazy.spawn(f"{command} audioMute")),
    Key("<XF86AudioLowerVolume>", lazy.spawn(f"{command} audioDown")),
    Key("<XF86AudioRaiseVolume>", lazy.spawn(f"{command} audioUp")),
    Key("<XF86MonBrightnessDown>", lazy.spawn(f"{command} brightDown")),
    Key("<XF86MonBrightnessUp>", lazy.spawn(f"{command} brightUp")),
    Key("<Print>", lazy.spawn("flameshot screen")),
    Key("M-<Print>", lazy.spawn("flameshot gui")),
    ########
    # MISC #
    ########
    Key("M-C-p", lazy.spawn(f"{command} toggleBar")),
    Key(
        "M-<less>",
        lazy.spawn("xkbset bell sticky -twokey -latchlock feedback led stickybeep"),
    ),
    Key("M-q", lazy.reload_config()),
]

##########
# GROUPS #
##########

for index, group in enumerate(keybindings):
    keys.append(Key(f"M-<{group}>", lazy.group[f"{index+1}"].toscreen()))
