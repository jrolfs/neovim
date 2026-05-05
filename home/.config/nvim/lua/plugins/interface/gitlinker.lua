require('gitlinker').setup()

local map = vim.keymap.set

map({ 'n', 'v' }, '<leader>gy', '<cmd>GitLink<cr>', { desc = 'Copy git permalink' })
map({ 'n', 'v' }, '<leader>gY', '<cmd>GitLink!<cr>', { desc = 'Open git permalink in browser' })
map({ 'n', 'v' }, '<leader>gb', '<cmd>GitLink blame<cr>', { desc = 'Copy git blame link' })
map({ 'n', 'v' }, '<leader>gB', '<cmd>GitLink! blame<cr>', { desc = 'Open git blame in browser' })
