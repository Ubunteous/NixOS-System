last_focus_index = -1


def swap_focus_main(_):
    """
    Swaps focused window to main area. If the current focus is main, then swap
    with the last swapped window (via this function). Focus remains on main.

    Behaves like quick Ctrl+Tab in VS Code.
    """

    layout = qtile.current_layout

    if layout.name == "monadtall":
        global last_focus_index
        current_index = layout.clients.current_index
        # 0 is main window
        if current_index == 0:
            if last_focus_index < 0:
                # nothing to swap with
                return
            # swap with last
            target_index = last_focus_index
        else:
            # swap subordinates with main
            target_index = current_index
            last_focus_index = current_index

        main_window = layout.clients[0]
        target_window = layout.clients[target_index]
        # swaps windows and keeps focus on main
        layout.cmd_swap(target_window, main_window)


def focus_main(_):
    layout = qtile.current_layout

    if layout.name == "monadtall":
        # aligned to right
        if layout.align == 1:
            layout.cmd_right()
            return

        layout.cmd_left()
