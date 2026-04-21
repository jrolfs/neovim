local map = require('utilities').map

map('n', '<leader>gd', function()
  if next(require('diffview.lib').views) == nil then
    vim.cmd('DiffviewOpen')
  else
    vim.cmd('DiffviewClose')
  end
end)

-- Override diff highlights to better match gruvbox-material palette
vim.api.nvim_create_autocmd('ColorScheme', {
  group = vim.api.nvim_create_augroup('DiffviewHighlights', { clear = true }),
  callback = function()
    -- Line backgrounds for added/deleted/changed regions
    vim.api.nvim_set_hl(0, 'DiffAdd', { bg = '#2e352c' })
    vim.api.nvim_set_hl(0, 'DiffDelete', { bg = '#4c3432' })
    vim.api.nvim_set_hl(0, 'DiffChange', { bg = '#33312b' })

    -- Inline changed text — muted yellow instead of bright blue
    vim.api.nvim_set_hl(0, 'DiffText', { bg = '#5a4a32' })

    -- Diffview: deleted content shown in left panel — muted red bg
    vim.api.nvim_set_hl(0, 'DiffviewDiffAddAsDelete', { bg = '#4c3432' })

    -- Diffview: filler/padding lines (the dashed lines)
    vim.api.nvim_set_hl(0, 'DiffviewDiffDelete', { bg = '#3a2a2a', fg = '#5c4040' })
  end,
})
