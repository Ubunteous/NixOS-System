local wezterm = require 'wezterm'
local module = {}

-- ####################
-- ##     EVENTS     ##
-- ####################

function module.apply_to_config(config)
   -- show when 'Leader' is active
   wezterm.on('update-right-status', function(window, pane)
		 local msg = ''
		 if window:leader_is_active() then
		    msg = 'LEADER'
		 else
		    -- WORSKSPACE
		    msg = 'Workspace: ' .. window:active_workspace()

		    -- KEY TABLE
		    -- local name = window:active_key_table()
		    -- if name then
		    --    name = 'TABLE: ' .. name
		    -- end
		    -- window:set_right_status(name or '')
		    
		    -- PANE
		    -- msg = 'Pane: ' .. window:active_pane():get_title()

		    -- TAB
		    -- window:active_tab():set_title("AAA") -- title='' by default
		    -- msg = 'Tab' .. window:active_tab():get_title())
		 end
		 
		 window:set_right_status(msg .. '    ')

   end)
end

return module
