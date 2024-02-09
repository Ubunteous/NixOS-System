local wezterm = require 'wezterm'
local act = wezterm.action
local module = {}

-- key tables are used to create hydras (which can stack)
-- the one_shot option

-- #####################
-- ##    KEY-TABLE    ##
-- #####################

function module.apply_to_config(config)
   -- Show which key table is active in the status area
   wezterm.on('update-right-status', function(window, pane)
		 local name = window:active_key_table()
		 if name then
		    name = 'TABLE: ' .. name
		 end
		 window:set_right_status(name or '')
   end)

   config.keys = {   
      -- CTRL+SHIFT+Space, followed by 'r' will put us in resize-pane
      -- mode until we cancel that mode.
      {
	 key = 'r',
	 mods = 'LEADER',
	 action = act.ActivateKeyTable {
	    name = 'resize_pane',
	    one_shot = false,
	 },
      },

      -- CTRL+SHIFT+Space, followed by 'a' will put us in activate-pane
      -- mode until we press some other key or until 1 second (1000ms)
      -- of time elapses
      {
	 key = 'a',
	 mods = 'LEADER',
	 action = act.ActivateKeyTable {
	    name = 'activate_pane',
	    timeout_milliseconds = 1000,
	 },
      },
   }

   config.key_tables = {
      -- Defines the keys that are active in our resize-pane mode.
      -- Since we're likely to want to make multiple adjustments,
      -- we made the activation one_shot=false. We therefore need
      -- to define a key assignment for getting out of this mode.
      -- 'resize_pane' here corresponds to the name="resize_pane" in
      -- the key assignments above.
      resize_pane = {
	 { key = 'LeftArrow', action = act.AdjustPaneSize { 'Left', 1 } },
	 { key = 'h', action = act.AdjustPaneSize { 'Left', 1 } },

	 { key = 'RightArrow', action = act.AdjustPaneSize { 'Right', 1 } },
	 { key = 'l', action = act.AdjustPaneSize { 'Right', 1 } },

	 { key = 'UpArrow', action = act.AdjustPaneSize { 'Up', 1 } },
	 { key = 'k', action = act.AdjustPaneSize { 'Up', 1 } },

	 { key = 'DownArrow', action = act.AdjustPaneSize { 'Down', 1 } },
	 { key = 'j', action = act.AdjustPaneSize { 'Down', 1 } },

	 -- Cancel the mode by pressing escape
	 { key = 'Escape', action = 'PopKeyTable' },
      },

      -- Defines the keys that are active in our activate-pane mode.
      -- 'activate_pane' here corresponds to the name="activate_pane" in
      -- the key assignments above.
      activate_pane = {
	 { key = 'LeftArrow', action = act.ActivatePaneDirection 'Left' },
	 { key = 'h', action = act.ActivatePaneDirection 'Left' },

	 { key = 'RightArrow', action = act.ActivatePaneDirection 'Right' },
	 { key = 'l', action = act.ActivatePaneDirection 'Right' },

	 { key = 'UpArrow', action = act.ActivatePaneDirection 'Up' },
	 { key = 'k', action = act.ActivatePaneDirection 'Up' },

	 { key = 'DownArrow', action = act.ActivatePaneDirection 'Down' },
	 { key = 'j', action = act.ActivatePaneDirection 'Down' },
      },
   }
end

return module
