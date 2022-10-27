local home = vim.api.nvim_get_var('lua_home')

--- Neodev sets up the Lua language server for Neovim plugin
--  development and configuration editing. This must be run
--  before the language servers are configured.
--
--  @see https://github.com/folke/neodev.nvim
--
require("neodev").setup({})

--- Plugin Configuration
--
require('relative-source').source { home .. '/plugins/*/*.lua' }
