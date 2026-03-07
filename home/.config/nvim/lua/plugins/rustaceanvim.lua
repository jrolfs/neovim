local config = require('plugins.lsp.nvim-lspconfig')
local cmp = require('cmp_nvim_lsp')

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_capabilities = cmp.default_capabilities(capabilities)

vim.g.rustaceanvim = {
  server = {
    on_attach = config.on_attach,
    cmd = { 'nix-shell', '-p', 'rust-analyzer', '--run', 'rust-analyzer' },
    capabilities = cmp_capabilities,
  },
}
