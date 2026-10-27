-- opencode alongside the editor: ask about the code under the cursor or a
-- selection, send ranges into the prompt, and pick from opencode's prompts
-- and commands. It finds the running opencode service on its own.
--
-- Under <leader>o rather than the plugin's suggested keys: those take over
-- <C-a>/<C-x> (increment/decrement) and `go`.
--
--   <leader>oa  Ask about @this (cursor or selection)
--   <leader>os  Select a prompt or command
--   <leader>op  Send a range to the prompt (operator, e.g. <leader>opip)
--   <leader>ol  Send the current line

---@type opencode.Opts
vim.g.opencode_opts = {}

local opencode = function() return require('opencode') end

vim.keymap.set({ 'n', 'x' }, '<leader>oa', function() opencode().ask('@this: ') end,
  { desc = 'Ask opencode about this' })
vim.keymap.set({ 'n', 'x' }, '<leader>os', function() opencode().select() end,
  { desc = 'Select an opencode prompt or command' })
vim.keymap.set({ 'n', 'x' }, '<leader>op', function() return opencode().operator('@this') end,
  { desc = 'Send a range to opencode', expr = true })
vim.keymap.set('n', '<leader>ol', function() return opencode().operator('@this') .. '_' end,
  { desc = 'Send this line to opencode', expr = true })
