local home = vim.api.nvim_get_var('lua_home')

vim.g.colorscheme = "gruvbox-material"

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

vim.cmd.colorscheme(vim.g.colorscheme)

vim.api.nvim_create_autocmd("FileType", {
  pattern = {"javascript", "typescript"},
  callback = function()
    vim.opt_local.textwidth = 80
    vim.opt_local.formatoptions:append("croql")
    vim.opt_local.comments = "sO:* -,mO:*  ,exO:*/,s1:/*,mb:*,ex:*/,://"
  end,
})
