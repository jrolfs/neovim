local config = require('plugins.lsp.nvim-lspconfig')

require('lazy-lsp').setup {
  excluded_servers = {
    'denols',        -- TypeScript: if I ever start using Deno, I'll need to figure out how to load this selectively
    'rls',           -- Rust: no longer supported (prefer `rust-analyzer`
    'rust_analyzer', -- Letting 'rust-tools.nvim' manage this
    'sqls',          -- Deprecated (prefer `sqlls`)
    -- Getting errors for these after latest nvim plugin update
    'dolmenls',
    'gdscript',
    'jqls',
    -- Getting errors for these after latest nvim plugin update (part 2)
    'jdtls',
    -- Prefer Ruby LSP + standardrb
    'solargraph'
  },
  default_config = {
    on_attach = config.on_attach
  },
  configs = {
    lua_ls = {
      on_attach = function(client)
          -- Opt out of semantic token highlighting.
          client.server_capabilities.semanticTokensProvider = nil
      end
    },
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
