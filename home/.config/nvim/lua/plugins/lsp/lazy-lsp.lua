local config = require('plugins.lsp.nvim-lspconfig')

require('lazy-lsp').setup {
  excluded_servers = { 'denols' },
  default_config = {
    on_attach = config.on_attach
  },
  configs = {},
}
