local map = require('utilities').map_vs


map('n', '[c', 'workbench.action.editor.previousChange')
map('n', ']c', 'workbench.action.editor.nextChange')

-- map({'n','v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
map({'n','v'}, '<leader>hr', 'git.revertSelectedRanges')
-- map('n',       '<leader>hS', gs.stage_buffer)
-- map('n',       '<leader>hu', gs.undo_stage_hunk)
-- map('n',       '<leader>hR', gs.reset_buffer)
map('n',       '<leader>hp', 'editor.action.dirtydiff.next')
-- map('n',       '<leader>hb', function() gs.blame_line{full=true} end)
-- map('n',       '<leader>tb', gs.toggle_current_line_blame)
-- map('n',       '<leader>hd', gs.diffthis)
-- map('n',       '<leader>hD', function() gs.diffthis('~') end)
-- map('n',       '<leader>td', gs.toggle_deleted)

