local config = require('plugins.lsp.nvim-lspconfig')

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  callback = function(args)
    local fname = vim.api.nvim_buf_get_name(args.buf)
    local dir = vim.fs.dirname(fname)

    local rc = vim.fs.find('.oxlintrc.json', { path = dir, upward = true })[1]
    if not rc then
      return
    end

    local root = vim.fs.dirname(rc)

    local bin = vim.fs.find('node_modules/.bin/oxlint', { path = root, upward = true })[1]
    if not bin and vim.fn.executable('oxlint') == 1 then
      bin = 'oxlint'
    end
    if not bin then
      return
    end

    vim.lsp.start({
      name = 'oxlint',
      cmd = { bin, '--lsp' },
      root_dir = root,
      on_attach = config.on_attach,
    })
  end,
})
