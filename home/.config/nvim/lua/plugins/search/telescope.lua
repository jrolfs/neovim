local telescope = require("telescope")

local builtin = require('telescope.builtin')
local config = require("telescope.config")
local float = require("interface.float")

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(config.values.vimgrep_arguments) }

-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")
-- I don't want to search in the `.git` directory.
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!.git/*")

telescope.setup({
  defaults = {
    -- `hidden = true` is not supported in text grep commands.
    vimgrep_arguments = vimgrep_arguments,
    borderchars = float.popup(),
    layout_strategy = "flex",
    layout_config = {
      -- `flip_lines` defaults to `vertical.preview_cutoff`; below it, flex falls back
      -- to horizontal, which then drops the preview entirely under 120 columns.
      vertical = { preview_cutoff = 0, preview_height = 0.5 },
      horizontal = { preview_width = 0.55 },
    },
  },
  pickers = {
    find_files = {
      -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
      find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
    },
    project_files = function()
      local opts = {} -- define here if you want to define something
      local ok = pcall(require"telescope.builtin".git_files, opts)
      if not ok then require"telescope.builtin".find_files(opts) end
    end
  },
})

local project_files = function()
  local options = {}
  local ok = pcall(builtin.git_files, options)
  if not ok then builtin.find_files(options) end
end

--
-- Mappings
--

vim.keymap.set('n', '<C-p>', project_files, {})
vim.keymap.set('n', '<leader>fp', project_files, {})

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fv', builtin.git_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fr', builtin.registers, {})
vim.keymap.set('n', '<leader>fo', builtin.lsp_document_symbols, {})
