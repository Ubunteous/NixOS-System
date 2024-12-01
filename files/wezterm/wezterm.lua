local wezterm = require 'wezterm'
-- local config = wezterm.config_builder() -- clearer error messages
local config = {}
if wezterm.config_builder then
   config = wezterm.config_builder()
end

-- local events = require 'events'
local bindings = require 'bindings'
local appearance = require 'appearance'
-- local key_tables = require 'key_table'
local configuration = require 'configuration'

-- #####################
-- ##     IMPORTS     ##
-- #####################

-- events.apply_to_config(config)
appearance.apply_to_config(config)
configuration.apply_to_config(config)

bindings.apply_to_config(config)
-- key_tables.apply_to_config(config)

-- ###################
-- ##     TESTS     ##
-- ###################

-- config.color_scheme = 'AdventureTime'

--MUX
-- local mux = wezterm.mux
-- mux.spawn_window { args = { 'top' } } -- don't use in top scope

-- ####################
-- ##     RETURN     ##
-- ####################

return config
