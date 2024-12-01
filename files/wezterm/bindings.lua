local wezterm = require 'wezterm'
local act = wezterm.action
local module = {}

-- find more actions in KeyAssignment section of docs
-- get all bindings with wezterm show-keys command in terminal

-- #####################
-- ##     BINDINGS    ##
-- #####################

-- return index of active tab
function active_pane_index_for_tab(panes)
   for _, pane in ipairs(panes) do
      if pane.is_active then
	 return pane.index
      end
   end
end


function prev_pane(win, pane)
   -- wezterm.log_info('Pane', pane:get_title(), '(total', win:active_tab():panes_with_info(), ")")
   curr_pane_index = active_pane_index_for_tab(win:active_tab():panes_with_info())

   if curr_pane_index > 0 then
      win:perform_action(wezterm.action.ActivatePaneByIndex(curr_pane_index - 1), pane)
   else
      nb_panes = #win:active_tab():panes_with_info()

      if nb_panes > 1 then
	 win:perform_action(wezterm.action.ActivatePaneByIndex(nb_panes - 1), pane)
      end
   end
   
   -- wezterm.log_info('now in pane', pane:pane_id())
end

function next_pane(win, pane)
   curr_pane_index = active_pane_index_for_tab(win:active_tab():panes_with_info())
   nb_panes = #win:active_tab():panes_with_info()

   -- wezterm.log_info('curr index', curr_pane_index, "nb panes", nb_panes)
   
   if curr_pane_index + 1 < nb_panes then
      win:perform_action(wezterm.action.ActivatePaneByIndex(curr_pane_index + 1), pane)
   else
      win:perform_action(wezterm.action.ActivatePaneByIndex(0), pane)
   end
   
   -- wezterm.log_info('now in pane', pane:pane_id())
end


function new_tiled_pane(win, pane)
   curr_pane_index = active_pane_index_for_tab(win:active_tab():panes_with_info())
   nb_panes = #win:active_tab():panes_with_info()

   -- wezterm.log_info('curr index', curr_pane_index, "nb panes", nb_panes)

   -- go to last pane to add new at the end of the stack
   if curr_pane_index ~= nb_panes - 1 then
      win:perform_action(wezterm.action.ActivatePaneByIndex(nb_panes - 1), pane)
   end
   
   if nb_panes == 1 then
      win:perform_action(wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }, pane)
   else
      win:perform_action(wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' }, pane)
   end
end


-- if in master, go to last. Otherwise, go to master pane
function switch_master_stack(win, pane)
   curr_pane_index = active_pane_index_for_tab(win:active_tab():panes_with_info())
   nb_panes = #win:active_tab():panes_with_info()

   wezterm.log_info('curr index', curr_pane_index, "nb panes", nb_panes)
   
   if curr_pane_index == 0 then
      win:perform_action(wezterm.action.ActivatePaneByIndex(nb_panes - 1), pane)
   else
      win:perform_action(wezterm.action.ActivatePaneByIndex(0), pane)
   end
end

-- get a list of all the bindings with this command:
-- grep -P '  { key' ~/.nix.d/files/wezterm/bindings.lua | awk '{$1=$1};1'
function module.apply_to_config(config)
   -- ##########
   -- # LEADER #
   -- ##########
   
   -- timeout_milliseconds defaults to 1000 and can be omitted. leader is C-<space>
   config.leader = { key = 'Space', mods = 'CTRL'} -- , timeout_milliseconds = 1000 }

   config.keys = {
      { key = 'g', mods = 'ALT', action = wezterm.action_callback(switch_master_stack) },
      -- #########
      -- # MODES #
      -- #########

      { key = 'q', mods = 'LEADER', action = act.QuickSelect },
      { key = 'c', mods = 'LEADER', action = act.ActivateCopyMode },
      { key = 's', mods = 'LEADER', action = act.Search 'CurrentSelectionOrEmptyString' },
      { key = 'f', mods = 'LEADER', action = act.ToggleFullScreen },

      -- ########
      -- # MENU #
      -- ########

      -- OPTIONS: TABS | LAUNCH_MENU_ITEMS | (Multiplexing) DOMAINS
      -- | (Items from) KEY_ASSIGNMENTS | WORKSPACES | COMMANDS
      { key = 'w',  mods = 'LEADER|CTRL', action = act.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' }, },
      { key = 't', mods = 'LEADER|CTRL',  action = act.ShowTabNavigator },
      { key = 'p', mods = 'LEADER', action = act.ActivateCommandPalette },
      { key = 'd', mods = 'LEADER', action = act.ShowDebugOverlay },

      -- #######
      -- # TAB #
      -- #######

      { key = 't', mods = 'LEADER', action = act.SpawnTab 'CurrentPaneDomain' },
      { key = 'u', mods = 'LEADER', action = act.ActivateTabRelative(1) },
      { key = 'l', mods = 'LEADER', action = act.ActivateTabRelative(-1) },
      
      -- { key = '', mods = 'LEADER', action = act.SpawnCommandInNewTab { args = { 'top' }, }, },
      -- { key = '', mods = 'LEADER', action = act.CloseCurrentTab{ confirm = false } }, -- use C-d
      -- { key = '', mods = 'LEADER', action = act.ActivateLastTab, }, -- does not work if no previous active tab
      
      -- ########
      -- # PANE #
      -- ########

      -- xmonad style
      { key = 'n', mods = 'LEADER', action = wezterm.action_callback(prev_pane) },
      { key = 'e', mods = 'LEADER', action = wezterm.action_callback(next_pane) },

      { key = 'i', mods = 'LEADER', action = wezterm.action_callback(new_tiled_pane) },
      { key = 'v',  mods = 'LEADER', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
      { key = 'h', mods = 'LEADER', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
      
      { key = 'z',  mods = "LEADER", action = act.TogglePaneZoomState },
      { key = 'r', mods = 'LEADER', action = act.RotatePanes 'Clockwise' },
      { key = 'a', mods = 'LEADER', action = act.RotatePanes 'CounterClockwise' },

      -- MODES: SwapWithActive, MoveToNewTab, MoveToNewWindow, SwapWithActiveKeepFocus
      { key = 'o', mods = 'LEADER', action = act.PaneSelect { alphabet = 'arstgmneio' }, },      
      { key = 'o', mods = 'LEADER|CTRL', action = act.PaneSelect { alphabet = 'arstgmneio', mode = 'SwapWithActive' }, },
      -- { key = 'g', mods = 'ALT', action = act.PaneSelect({ show_pane_ids = true, }), }, -- does not work?
      
      -- i3 style
      -- { key = 'm', mods = 'LEADER', action = act.ActivatePaneDirection 'Left' },
      -- { key = 'n', mods = 'LEADER', action = act.ActivatePaneDirection 'Up' },
      -- { key = 'e', mods = 'LEADER', action = act.ActivatePaneDirection 'Down' },
      -- { key = 'i', mods = 'LEADER', action = act.ActivatePaneDirection 'Right' },
      -- { key = 'h', mods = 'LEADER', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
      -- { key = 'v',  mods = 'LEADER', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },

      -- { key = '', mods = 'LEADER', action = act.AdjustPaneSize{ 'Left', 1 } },
      -- { key = '', mods = 'LEADER', action = act.CloseCurrentPane { confirm = false } }, -- use C-d

      -- #############
      -- # WORKSPACE #
      -- #############
      
      -- { key = 'w', mods = 'LEADER', action = act.SpawnWindow },
      -- { key = 'k', mods = 'LEADER', action = act.SwitchWorkspaceRelative(-1) },
      -- { key = 'h', mods = 'LEADER', action = act.SwitchWorkspaceRelative(1) },
   }
end

return module

-- ########
-- # MISC #
-- ########

-- create tab with input name
-- {
-- 	 key = 'R',
-- 	 mods = 'CTRL|SHIFT',
-- 	 action = act.PromptInputLine {
-- 	    description = 'Enter new name for tab',
-- 	    action = wezterm.action_callback(function(window, _, line)
-- 		  -- line will be `nil` if they hit escape without entering anything
-- 		  -- An empty string if they just hit enter
-- 		  -- Or the actual line of text they wrote
-- 		  if line then
-- 		     window:active_tab():set_title(line)
-- 		  end
-- 	    end),
-- 	 },
-- },

-- local mux = wezterm.mux
-- {
-- 	 key = 'o',
-- 	 mods = 'ALT',
-- 	 action = wezterm.action_callback(function()
-- 	       -- don't use in top scope => infinite reload loop
-- 	       mux.spawn_window {
-- 		  args = { 'top' },
-- 	       }
-- 	 end),
-- },

--    }
-- end

-- log values and show debug overlay
-- action = wezterm.action_callback(function(win, pane)
--       wezterm.log_info '\nHello from callback!'
--       wezterm.log_info(
-- 	 'WindowID:',
-- 	 win:window_id(),
-- 	 'PaneID:',
-- 	 pane:pane_id(),
-- 	 'and',
-- 	 pane:pane_id() - 1
--       )
--       win:perform_action(wezterm.action.ShowDebugOverlay, pane)
-- end)

-- ##########################
-- ##     APPLY TO KEYS    ##
-- ##########################

-- function apply_to_keys(config_keys, new_keys)
--    for _, key in pairs(new_keys) do
--       table.insert(config_keys, key)
--    end
-- end

   -- apply_to_keys(config.keys, replace_defaults)
   -- for _, defaults in pairs(disable_defaults) do
   --    table.insert(config.keys, defaults)

   -- action = act.DisableDefaultAssignment,
