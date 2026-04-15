--- Custom filetype detection overrides.

vim.filetype.add({
  pattern = {
    -- Zed editor configuration (keymap.json, settings.json, etc.) uses
    -- JSON-with-comments. Treating it as `jsonc` lets `jsonls`, treesitter,
    -- and the syntax layer handle comments correctly.
    ['.*/zed/.*%.json'] = 'jsonc',
  },
})
