local config = require('plugins.lsp.nvim-lspconfig')

local function log(msg)
  vim.notify('[oxlint] ' .. msg, vim.log.levels.INFO)
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  callback = function(args)
    local fname = vim.api.nvim_buf_get_name(args.buf)
    local dir = vim.fs.dirname(fname)
    log('FileType fired for ' .. fname .. ' (dir: ' .. dir .. ')')

    local rc = vim.fs.find('.oxlintrc.json', { path = dir, upward = true })[1]
    if not rc then
      log('No .oxlintrc.json found from ' .. dir)
      return
    end
    log('Found rc: ' .. rc)

    local root = vim.fs.dirname(rc)

    local bin = vim.fs.find('node_modules/.bin/oxlint', { path = root, upward = true })[1]
    if not bin and vim.fn.executable('oxlint') == 1 then
      bin = 'oxlint'
    end
    if not bin then
      log('No oxlint binary found (checked node_modules from ' .. root .. ' and PATH)')
      return
    end
    log('Using binary: ' .. bin .. ', root: ' .. root)

    vim.lsp.start({
      name = 'oxlint',
      cmd = { bin, '--lsp' },
      root_dir = root,
      on_attach = config.on_attach,
    })
    log('vim.lsp.start() called')
  end,
})

log('autocmd registered')
