local home = vim.api.nvim_get_var('lua_home')

--- Plugin Configuration
--
-- This probably won't contain a ton of actual plugin configuration as we only load
-- a small subset of plugins for use in Code. Rather, the idea here is to start
-- mirroring the key bindings I use for Neovim plugins to the analogous functionality
-- in Code preserving the same directory structure as the Neovim plugins so it's easy
-- to see what's mirrored.
--
require('relative-source').source { home .. '/code/*/*.lua' }
