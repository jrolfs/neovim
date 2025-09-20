local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  virtual_text = {
    prefix = '●',
  }
})

local options = { noremap = true, silent = true }

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, options)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, options)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, options)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, options)

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

  -- LSP formatting with different operators (Option 3)
  vim.keymap.set('n', 'gF', function()
    vim.lsp.buf.format({ async = true })
  end, { buffer = bufnr, desc = "LSP format buffer" })

  -- LSP format current line
  vim.keymap.set('n', 'gff', function()
    local line = vim.api.nvim_win_get_cursor(0)[1]
    vim.lsp.buf.format({
      async = true,
      range = {
        start = { line, 0 },
        ["end"] = { line, 0 }
      }
    })
  end, { buffer = bufnr, desc = "LSP format line" })

  -- Keep your existing format mapping as well if you want
  vim.keymap.set('n', '<leader>af', vim.lsp.buf.format, bufopts)
end

return { on_attach = on_attach }
