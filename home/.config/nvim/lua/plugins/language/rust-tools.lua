local config = require('plugins.lsp.nvim-lspconfig')
local rust_tools = require("rust-tools")
local cmp = require('cmp_nvim_lsp')

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_capabilities = cmp.default_capabilities(capabilities)

rust_tools.setup({
  server = {
    on_attach = config.on_attach,
    cmd = { 'nix-shell',  '-p', 'rust-analyzer', '--run', 'rust-analyzer' },
    capabilities = cmp_capabilities
  },
})
