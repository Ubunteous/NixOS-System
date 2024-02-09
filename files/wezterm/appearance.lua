local wezterm = require 'wezterm'
local module = {}

-- ########################
-- ##     APPEARANCE     ##
-- ########################

function module.apply_to_config(config)
   -- ###########
   -- # COLOURS #
   -- ###########
   
   -- config.color_scheme = 'Monokai (dark) (terminal.sexy)'
   config.color_scheme = 'Monokai Remastered' -- current
   -- config.color_scheme = 'AdventureTime'
   
   config.colors = {
      background = '#272822',
      cursor_bg = 'turquoise',
      foreground = 'turquoise',
      
      -- selected text
      selection_fg = 'turquoise',
      selection_bg = '#223842',

      -- split between panes
      -- split = '#444444',
      
      tab_bar = {
	 background = '#272822',
	 inactive_tab_edge = '#272822',

	 -- The active tab is the one that has focus in the window
	 active_tab = {
	    bg_color = '#272822',
	    fg_color = 'lightsalmon',
	    -- fg_color = 'darkturquoise',

	    -- label intensity: "Half", "Normal" or "Bold" 
	    -- intensity = 'Bold',
	 },

	 inactive_tab = {
	    bg_color = '#272822',
	    fg_color = '#909090',
	 },

	 inactive_tab_hover = {
	    bg_color = '#272822',
	    fg_color = '#909090',
	 },

	 new_tab = {
	    bg_color = '#272822',
	    fg_color = '#808080',
	 },

	 new_tab_hover = {
	    bg_color = '#4b3062',
	    fg_color = '#909090',
	 },
      },
   }
   
   -- set your own colour theme
   -- config.color_scheme_dirs = { './colors' }
   -- config.color_scheme = 'mytheme'

   -- #########
   -- # FRAME #
   -- #########
   
   config.window_frame = {
      -- font = wezterm.font { family = 'Roboto', weight = 'Bold' },
      font_size = 14.0,
      active_titlebar_bg = '#272822',
      inactive_titlebar_bg = '#272822',
   }

   -- ########
   -- # FONT #
   -- ########

   -- automatic ligatures
   config.font = wezterm.font('Fira Code')
   config.font_size = 24.0

   -- do not change window size on a tiling window manager
   config.adjust_window_size_when_changing_font_size = false
end

return module
