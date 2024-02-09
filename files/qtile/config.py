from libqtile import layout
from libqtile.config import Screen, Match
from libqtile.utils import guess_terminal

# Test in Wayland
# Note: reloading the config with M-q puts eww above or below windows. Use M-C-p to fix this

# Don't kill emacs on M-x
# Layouts: Tall vs hide/all or full
# Test: restart hdmi screen, place firefox on ws 2 at startup
# Hooks: Picom even with single window, recognise float for gimp and dialog centered. Evince/pix always opaque

from bindings import keys

# reload with: qtile cmd-obj -o cmd -f reload_config

screens = [Screen()]  # remove later if widget is not back

mod = "mod4"
terminal = guess_terminal()

layouts = [
    layout.MonadTall(
        new_client_position="bottom",
        margin=5,
        single_border_width=0,
        single_margin=0,
        min_secondary_size=0,
        max_ratio=1,
        border_width=1,
        border_focus="#48d1cc",
    ),
    # layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
    # layout.Max(),
    # layout.Spiral(),
    # layout.Matrix(),
    # layout.RatioTile(),
    # layout.Slice(fallback="<libqtile.layout.max.Max object at 0x7f81ebc7c820>"), # find real fallback
]

# Hooks
# subscribe.group_window_add()
# subscribe.layout_change()
# subscribe.resume()

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = "floating_only"
floats_kept_above = False
cursor_warp = True

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# floating_layout = layout.Floating(
#     float_rules=[
#         # Run the utility of `xprop` to see the wm class and name of an X client.
#         *layout.Floating.default_float_rules,
#         Match(wm_class="confirmreset"),  # gitk
#         Match(wm_class="makebranch"),  # gitk
#         Match(wm_class="maketag"),  # gitk
#         Match(wm_class="ssh-askpass"),  # ssh-askpass
#         Match(title="branchdialog"),  # gitk
#         Match(title="pinentry"),  # GPG key password entry
#     ]
# )

# respect if app (like steam) auto-minimizes itself on focus loss
# auto_minimize = True

# For input devices configuration with Wayland backend
# wl_input_rules = None

# trick java UI toolkits
# wmname = "LG3D"
