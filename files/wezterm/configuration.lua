local wezterm = require 'wezterm'
local module = {}

-- ###########################
-- ##     CONFIGURATION     ##
-- ###########################

function module.apply_to_config(config)
   -- ###################
   -- # COMMAND PALETTE #
   -- ###################

   config.command_palette_bg_color = "teal"
   config.command_palette_fg_color = "aquamarine"
   config.command_palette_font_size = 20.0

   -- config.ui_key_cap_rendering = "UnixLong" -- Super, Meta, Ctrl, Shift
   -- config.ui_key_cap_rendering = "Emacs" -- Super, M, C, S

   -- ##########
   -- # CURSOR #
   -- ##########

   -- Styles: Steady or Blinking + Type (Block / Underline / Bar)
   -- config.default_cursor_style = 'SteadyUnderline'
   config.default_cursor_style = 'SteadyBar'

   -- Linear, Ease, EaseIn, EaseInOut, EaseOut, Constant
   -- cursor_blink_ease_in = "EaseIn"
   -- config.cursor_blink_rate = 1000 -- needs Blinking style

   -- config.cursor_thickness = "400%"
   
   -- #######
   -- # TAB #
   -- #######

   -- config.tab_max_width = 12
   -- config.enable_tab_bar = false
   -- config.show_tabs_in_tab_bar = false
   config.hide_tab_bar_if_only_one_tab = true
   -- config.show_tab_index_in_tab_bar = false
   -- tab_and_split_indices_are_zero_based = true
   -- config.show_new_tab_button_in_tab_bar = false
   config.switch_to_last_active_tab_when_closing_tab = true

   -- ########
   -- # MISC #
   -- ########

   config.check_for_updates = false
   config.window_close_confirmation = 'NeverPrompt'
   -- config.quit_when_all_windows_are_closed = false

   -- config.default_gui_startup_args = { 'ssh', 'some-host' }
   -- config.default_prog = { 'top' }
   -- config.launch_menu = { { args = { 'top' }, }, }

   -- fix font rendering issue from nixos 24.11
   config.front_end = "WebGpu"
   config.enable_wayland = false
   
   -- #########
   -- # DEBUG #
   -- #########

   -- wezterm.log_error('Config Dir ' .. wezterm.config_dir)
   -- wezterm.log_info('Config file ' .. wezterm.config_file)

   -- Opens a URL specifically in firefox
   -- wezterm.open_with('http://example.com', 'firefox')
end

return module
