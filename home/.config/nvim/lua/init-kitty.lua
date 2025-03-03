local home = vim.api.nvim_get_var('lua_home')

--- Plugin Configuration

require("plugins.lsp.nvim-cmp")

require('kitty-scrollback').setup()

-- Define the toggle functions
local function toggle_line_numbers()
  if vim.wo.number or vim.wo.relativenumber then
    vim.wo.number = false
    vim.wo.relativenumber = false
  else
    vim.wo.number = true
    vim.wo.relativenumber = true
  end
end

local function toggle_relative_numbers()
  if vim.wo.relativenumber then
    vim.wo.relativenumber = false
    vim.wo.number = true
  else
    vim.wo.relativenumber = true
    vim.wo.number = true
  end
end

-- Set the key mappings to call these functions
vim.keymap.set('n', '<leader>ln', toggle_line_numbers,
  { desc = "Toggle line numbers (off/on with relative)" })

vim.keymap.set('n', '<leader>lr', toggle_relative_numbers,
  { desc = "Toggle relative line numbers" })
