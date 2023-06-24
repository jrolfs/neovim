local config = require('plugins.lsp.nvim-lspconfig')

require('lazy-lsp').setup {
  excluded_servers = {
    'denols', -- TypeScript: if I ever start using Deno, I'll need to figure out how to load this selectively
    'rls', -- Rust: no longer supported (prefer `rust-analyzer`
    'rust_analyzer', -- Letting 'rust-tools.nvim' manage this
    'sqls' -- Deprecated (prefer `sqlls`)
  },
  default_config = {
    on_attach = config.on_attach
  },
  configs = {
    ltex = {
      filetypes = {
        "bib",
        -- "gitcommit", -- Spelling goes nuts on the diff
        "markdown",
        "org",
        "plaintex",
        "rst",
        "rnoweb",
        "tex",
      }
    },
  },
}
