local common = require('packages.common')

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    if ev.data.spec.name == 'nvim-treesitter' then
      if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
      vim.cmd('TSUpdate')
    end
  end
})

vim.pack.add(vim.list_extend(vim.deepcopy(common), {
  -- Interface
  'https://github.com/editorconfig/editorconfig-vim',
  { src = 'https://github.com/gruvbox-material/vim', name = 'gruvbox-material' },
  { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' },
  'https://github.com/chrisbra/Recover.vim',
  'https://github.com/jeffkreeftmeijer/vim-numbertoggle',
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/nvim-lualine/lualine.nvim',
  'https://github.com/qpkorr/vim-bufkill',
  'https://github.com/sjl/gundo.vim',
  'https://github.com/szw/vim-maximizer',
  'https://github.com/xolox/vim-misc',
  'https://github.com/xolox/vim-session',
  'https://github.com/rafcamlet/nvim-luapad',

  -- Search
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-telescope/telescope.nvim',

  -- LSP + Completion
  'https://github.com/hrsh7th/nvim-cmp',
  'https://github.com/hrsh7th/cmp-buffer',
  'https://github.com/hrsh7th/cmp-cmdline',
  'https://github.com/hrsh7th/cmp-nvim-lsp',
  'https://github.com/hrsh7th/cmp-path',
  'https://github.com/dundalek/lazy-lsp.nvim',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/L3MON4D3/LuaSnip',
  'https://github.com/saadparwaiz1/cmp_luasnip',
  'https://github.com/folke/trouble.nvim',
  'https://github.com/stevearc/conform.nvim',

  -- Terminal / REPL
  'https://github.com/mattn/webapi-vim',
  'https://github.com/mattn/gist-vim',

  -- Tools
  'https://github.com/mrcjkb/rustaceanvim',
  'https://github.com/tpope/vim-rhubarb',
  'https://github.com/tpope/vim-fugitive',
  'https://github.com/sindrets/diffview.nvim',

  -- Files
  'https://github.com/lambdalisue/suda.vim',
  'https://github.com/stevearc/oil.nvim',

  -- Motion
  'https://github.com/chamindra/marvim',
  'https://github.com/tpope/vim-commentary',
  'https://github.com/tpope/vim-repeat',
  'https://github.com/tpope/vim-sleuth',
  'https://github.com/tpope/vim-unimpaired',
  'https://github.com/nvimtools/hydra.nvim',
  'https://github.com/smoka7/multicursors.nvim',

  -- Syntax
  'https://github.com/LnL7/vim-nix',
  'https://github.com/direnv/direnv.vim',
  'https://github.com/fladson/vim-kitty',
  'https://github.com/folke/lazydev.nvim',
  'https://github.com/heavenshell/vim-jsdoc',
  'https://github.com/jparise/vim-graphql',
  'https://github.com/catgoose/nvim-colorizer.lua',
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/sheerun/vim-polyglot',
  'https://github.com/tridactyl/vim-tridactyl',
  'https://github.com/vim-pandoc/vim-pandoc',
  'https://github.com/vim-pandoc/vim-pandoc-syntax',

  -- Icons
  'https://github.com/nvim-tree/nvim-web-devicons',
}))
