local treesitter = require('nvim-treesitter')

treesitter.setup()

-- The `main` branch dropped `ensure_installed` and `auto_install`, and it no
-- longer enables highlighting: parsers install on demand and
-- `vim.treesitter.start()` has to run per buffer.
vim.api.nvim_create_autocmd('FileType', {
  callback = function(event)
    local language = vim.treesitter.language.get_lang(event.match)

    if not language or not vim.tbl_contains(treesitter.get_available(), language) then return end

    if vim.tbl_contains(treesitter.get_installed(), language) then
      vim.treesitter.start(event.buf, language)
      return
    end

    treesitter.install(language):await(function()
      if vim.api.nvim_buf_is_valid(event.buf) then vim.treesitter.start(event.buf, language) end
    end)
  end,
})
