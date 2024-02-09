from libqtile import hook
from libqtile.lazy import lazy
from libqtile.config import Group

import subprocess

##########
# GROUPS #
##########

keybindings = [
    "ampersand",
    "eacute",
    "quotedbl",
    "apostrophe",
    "parenleft",
    "minus",
    "egrave",
    "underscore",
    "ccedilla",
    # "agrave", # 0
]

groups = [Group(group) for group in keybindings]

##############
# DECORATORS #
##############


@hook.subscribe.startup_once
def autostart():
    subprocess.run(["sh", f"{command}", "autoStart"])


@lazy.window.function
def window_to_next_group(window):
    """Move the current window to the next workspace"""
    index = window.qtile.groups.index(window.group)
    # index = (index + 1) % len(window.qtile.groups)
    index = (index + 1) % 9
    window.cmd_togroup(window.qtile.groups[index].name)


@lazy.window.function
def window_to_prev_group(window):
    """Move the current window to the prev workspace"""
    index = window.qtile.groups.index(window.group)
    index = (index + 8) % 9
    window.cmd_togroup(window.qtile.groups[index].name)


@lazy.layout.function
def swap_main(layout):
    """Swap current window to main pane unless it is the master.
    In which case it swaps it with something else"""
    windows = layout.clients
    # verify if current window is master
    if windows.current_client == windows[0]:
        # swap master with last in stack
        layout.swap(windows[0], windows[-1])
    else:
        layout.swap_left()

    layout.group.focus(windows[0])


@lazy.screen.function
def next_trio(screen):
    """Go to the next trio of workspaces"""
    n = screen.group._get_group(+3)
    screen.set_group(n)


@lazy.screen.function
def prev_trio(screen):
    """Go to the previous trio of workspaces"""
    n = screen.group._get_group(-3)
    screen.set_group(n)


@lazy.screen.function
def next_within_trio(screen):
    """Move the current window to the next workspace within the current trio"""
    i = int(screen.group._get_group(0).name)

    if (i - 1) // 3 == i // 3:
        n = screen.group._get_group(1)
    else:
        n = screen.group._get_group(-2)

    screen.set_group(n)


@lazy.screen.function
def prev_within_trio(screen):
    """Move the current window to the previous workspace within the current trio"""
    ws = screen.group
    i = int(ws._get_group(0).name)

    if (i - 2) // 3 == (i - 1) // 3:
        n = screen.group._get_group(-1)
    else:
        n = screen.group._get_group(2)

    screen.set_group(n)


@lazy.window.function
def kill_unless_emacs(window):
    """Kill the window. Spare emacs which should not be closed accidentally"""
    # subprocess.run(["dunstify", f"{window.info()['wm_class'][0]}"])

    if window.info()["wm_class"][0] != "emacs":
        window.kill()
