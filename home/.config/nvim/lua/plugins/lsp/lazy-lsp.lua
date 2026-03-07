local config = require('plugins.lsp.nvim-lspconfig')

require('lazy-lsp').setup {
  use_vim_lsp_config = true,
  excluded_servers = {
    'denols',        -- TypeScript: if I ever start using Deno, I'll need to figure out how to load this selectively
    'rls',           -- Rust: no longer supported (prefer `rust-analyzer`
    'rust_analyzer', -- Letting 'rustaceanvim' manage this
    'sqls',          -- Deprecated (prefer `sqlls`)
    -- Getting errors for these after latest nvim plugin update
    'dolmenls',
    'gdscript',
    'jqls',
    -- Getting errors for these after latest nvim plugin update (part 2)
    'jdtls',
    -- Prefer Ruby LSP + standardrb
    'solargraph',
    -- Not yet in lspconfig
    'ty',
    'quick_lint_js',
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
    tailwindcss = {
      root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local root = vim.fs.dirname(vim.fs.find({
          'tailwind.config.js',
          'tailwind.config.cjs',
          'tailwind.config.mjs',
          'tailwind.config.ts',
          'postcss.config.js',
          'postcss.config.cjs',
          'postcss.config.mjs',
          'postcss.config.ts',
        }, { path = fname, upward = true })[1])
        if root then
          on_dir(root)
        end
      end,
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
