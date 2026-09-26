local common = require('packages.common')

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    if ev.data.spec.name == 'nvim-treesitter' then
      if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
      vim.cmd('TSUpdate')
    end
  end
})

-- Not prompting matters more here than in packages/terminal.lua: this runs as
-- kitty's scrollback pager, so a confirmation prompt would appear over the
-- scrollback with no obvious way to read it as a question.
vim.pack.add(vim.list_extend(vim.deepcopy(common), {
  -- Interface
  { src = 'https://github.com/gruvbox-material/vim', name = 'gruvbox-material' },
  'https://github.com/jeffkreeftmeijer/vim-numbertoggle',
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/nvim-lualine/lualine.nvim',
  'https://github.com/qpkorr/vim-bufkill',
  'https://github.com/sjl/gundo.vim',
  'https://github.com/szw/vim-maximizer',

  -- Completion
  'https://github.com/hrsh7th/nvim-cmp',
  'https://github.com/hrsh7th/cmp-buffer',
  'https://github.com/hrsh7th/cmp-cmdline',
  'https://github.com/hrsh7th/cmp-nvim-lsp',
  'https://github.com/hrsh7th/cmp-path',

  -- Motion
  'https://github.com/chamindra/marvim',
  'https://github.com/tpope/vim-unimpaired',

  -- Syntax
  'https://github.com/nvim-treesitter/nvim-treesitter',

  -- Kitty
  'https://github.com/mikesmithgh/kitty-scrollback.nvim',
}), { confirm = false })
