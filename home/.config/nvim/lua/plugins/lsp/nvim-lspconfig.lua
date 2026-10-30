vim.diagnostic.config({
  severity_sort = true,
  virtual_text = {
    prefix = '●',
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "\xef\x81\xaa ",
      [vim.diagnostic.severity.WARN] = "\xef\x81\xb1 ",
      [vim.diagnostic.severity.HINT] = "\xef\xa0\xb4 ",
      [vim.diagnostic.severity.INFO] = "\xef\x81\x9a ",
    },
  },
})

local options = { noremap = true, silent = true }

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, options)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, options)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, options)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, options)

-- Keys are `client.name`, which for lazy-lsp servers is the lspconfig config
-- name, and for manually started servers is whatever `vim.lsp.start` was given
local client_display = {
  lua_ls = '󰢱 ',
  tsgo = '󰛦 ',
  ts_ls = '󰛦 ',
  oxlint = '󰀱 ',
  eslint = '󰀱 ',
  ['rust-analyzer'] = ' ',
  jsonls = ' ',
  gopls = ' ',
  nil_ls = ' ',
  nixd = ' ',
  tailwindcss = ' ',
  ruby_lsp = '󰴭',
  standardrb = ' ',
  ltex = '󰾹 ',
}

--- Restart every LSP client attached to the current buffer
local restart_buffer_clients = function()
  local names = vim.iter(vim.lsp.get_clients({ bufnr = 0 }))
    :map(function(client) return client.name end)
    :totable()

  if #names == 0 then
    vim.notify("No LSP clients attached to this buffer", vim.log.levels.WARN)
    return
  end

  vim.cmd('lsp restart')
  vim.notify("Restarting " .. table.concat(names, ", "))
end

vim.keymap.set('n', '<leader>R', restart_buffer_clients,
  { noremap = true, silent = true, desc = "Restart LSP clients for buffer" })

--- This belongs here because `on_attach` is a native LSP thing,
--  but we export it because `lazy-lsp` makes it easier to apply
--  to every language server instead of having to manually do so
local on_attach = function(_, bufnr)
  -- Clear formatexpr so gq uses built-in formatting
  vim.bo[bufnr].formatexpr = ""

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workleader_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)

  -- Format buffer (conform with LSP fallback)
  vim.keymap.set('n', 'gF', function()
    require('conform').format({ async = true, lsp_fallback = true })
  end, { buffer = bufnr, desc = "Format buffer" })

  -- Format current line
  vim.keymap.set('n', 'gff', function()
    local line = vim.api.nvim_win_get_cursor(0)[1]
    require('conform').format({
      async = true,
      lsp_fallback = true,
      range = {
        start = { line, 0 },
        ["end"] = { line, 0 },
      },
    })
  end, { buffer = bufnr, desc = "Format line" })

  -- Format buffer (alternative binding)
  vim.keymap.set('n', '<leader>af', function()
    require('conform').format({ async = true, lsp_fallback = true })
  end, bufopts)
end

return { on_attach = on_attach }
