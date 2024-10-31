from libqtile import hook
from libqtile.lazy import lazy
from libqtile.config import Group, Match

# ~/.local/share/qtile/qtile.log
from libqtile.log_utils import logger
from libqtile.utils import send_notification
from libqtile.config import Group, ScratchPad, DropDown, Key

import subprocess
from pathlib import Path
# from time import sleep
# from re import compile as rcompile

command = Path(__file__).parent.absolute() / "commands.sh"

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

#########
# TESTS #
#########

# groups = [
#     Group("a", matches=[Match(wm_class=rcompile(r"^(Emacs)$"))]),
#     Group("b", matches=[Match(wm_class=rcompile(r"^(firefox)$"))]),
#     Group("c"),
# ]

# groups = [Group(str(i), label=group, matches=[Match(wm_class='firefox')]) for i, group in enumerate(keybindings)]
    
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
    window.togroup(window.qtile.groups[index].name)


@lazy.window.function
def window_to_prev_group(window):
    """Move the current window to the prev workspace"""
    index = window.qtile.groups.index(window.group)
    index = (index + 8) % 9
    window.togroup(window.qtile.groups[index].name)

    
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
    if window.info()["wm_class"][0] != "emacs":
        window.kill()

        
@lazy.function
def smart_change_layout(qtile):
    """Change to max or figure out whether monadTall or matrix is more appropriate"""
    if qtile.current_group.layout.name != "max":
        qtile.current_group.setlayout("max")
        return

    nb_windows = len(qtile.current_group.windows)
    
    if nb_windows > 3:
        qtile.current_group.setlayout("spiral")
    else:
        qtile.current_group.setlayout("monadtall")


################
#  ROTSLAVES   #
################

def get_last_group(group, curr_group):
    # get a group between 6-8 relative to current group
    return group._get_group(9 - curr_group - (curr_group+2)%3)

def get_current_window(group):
    # also returns its index
    current_window = group.current_window
    
    for i, window in enumerate(group.windows):
        if window.name == current_window.name:            
            return current_window, i

def exchange_window_to_last_ws(group, window):
    # send current window to last relative workspace and get another one in exchange

    group_name = group.name
    curr_group = int(group_name)
    last_group = get_last_group(group, curr_group)

    if len(last_group.windows) > 0:
        window.togroup(last_group.name)
        last_group.windows[-2].togroup(group_name)
        return True
    else:
        return False


def rotslaves(layout, window_to_exchange):
    # rotate slave and swap with windows from last workspace if needed
    group = layout.group
    windows = group.windows
    nb_windows = len(windows)

    if nb_windows < 3:
        # no rotation possible
        return

    _, cwidx = get_current_window(group)    

    exchange_occurred = exchange_window_to_last_ws(group, windows[window_to_exchange])

    if not exchange_occurred:
        layout.swap(windows[1], windows[2])
    
    if exchange_occurred and window_to_exchange == 2:
        # update windows as swapping them does not change the list
        windows[1], windows[2] = windows[2], windows[1]
        layout.swap(windows[1], windows[2])

    # maintain_focus on selected window
    group.focus_by_index(cwidx)

@lazy.layout.function
def rotslaves_up(layout):
    rotslaves(layout, window_to_exchange=1)

@lazy.layout.function
def rotslaves_down(layout):
    rotslaves(layout, window_to_exchange=2)

##########################
# SMART SWAP WITH MASTER #
##########################

@lazy.layout.function
def swap_main(layout):
    """Swap current window to main pane unless it is the master.
            In which case it swaps it with something else"""
    windows = layout.clients
    global last_focus_index
    
    target = -1 # by default, swap master with last in stack
    
    # verify if current window is master
    if windows.current_client == windows[0]:
        if 'last_focus_index' in globals():
            # use last_focus_index if known
            target = min(last_focus_index, 2)
    else:
        # swap curr window if master not selected
        _, target = get_current_window(layout.group)
        last_focus_index = target if target != 0 else -1
        
    layout.swap(windows[0], windows[target])
    layout.group.focus(windows[0])
    
#################################
#   AUTO SEND/RECEIVE TO LAST   #
#################################

@hook.subscribe.group_window_add
def Show_3_windows_max(group, window):
    # send window in excess away to the last workspace trio
    limit = 3
    nb_windows = len(group.windows) + 1
    layout = group.current_layout
    curr_group = int(group.name)

    if curr_group > 6:
        return
    
    last_group = group._get_group(9 - curr_group - (curr_group+2)%3)
    
    if nb_windows > limit and layout == 0:
        group.windows[1].togroup(last_group.name, switch_group=False)

        
# @hook.subscribe.group_window_remove
# def Show_3_windows_max(group, window):
#     limit = 3
#     nb_windows = len(group.windows) # + 1
#     send_notification("qtile", f"Nb windows: {nb_windows}")

#     if len(last_group.windows) > 0 and nb_windows < limit:
#         # send_notification("qile", "Retrieve")
#         last_group.windows[-1].togroup(group.name, switch_group=False)
#         # missing a rotslave

