local config = require('plugins.lsp.nvim-lspconfig')

require('lazy-lsp').setup {
  excluded_servers = {
    'denols', -- TypeScript: if I ever start using Deno, I'll need to figure out how to load this selectively
    'rls', -- Rust: no longer supported (prefer `rust-analyzer`
  },
  default_config = {
    on_attach = config.on_attach
  },
  configs = {},
}
