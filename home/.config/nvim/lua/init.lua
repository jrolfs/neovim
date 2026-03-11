local home = vim.api.nvim_get_var('lua_home')

vim.g.colorscheme = "gruvbox-material"

--- Lazydev configures lua_ls with Neovim's runtime types,
--  replacing the deprecated neodev.nvim.
--
--  @see https://github.com/folke/lazydev.nvim
--
require("lazydev").setup({
  library = {
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  },
})

--- Plugin Configuration
--
require('relative-source').source { home .. '/plugins/*/*.lua' }

vim.cmd.colorscheme(vim.g.colorscheme)

vim.api.nvim_create_autocmd("FileType", {
  pattern = {"javascript", "typescript"},
  callback = function()
    vim.opt_local.textwidth = 80
    vim.opt_local.formatoptions:append("croqlt")
    vim.opt_local.comments = "sO:* -,mO:*  ,exO:*/,s1:/*,mb:*,ex:*/,://"
  end,
})
