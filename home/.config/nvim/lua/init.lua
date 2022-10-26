-- Catppuccin {{{

local colors = require("catppuccin.palettes").get_palette()

colors.none = "NONE"

require("catppuccin").setup {
  custom_highlights = {
    Comment = { fg = colors.overlay1 },
    LineNr = { fg = colors.overlay1 },
    CursorLine = { bg = colors.none },
    CursorLineNr = { fg = colors.lavender },
    DiagnosticVirtualTextError = { bg = colors.none },
    DiagnosticVirtualTextWarn = { bg = colors.none },
    DiagnosticVirtualTextInfo = { bg = colors.none },
    DiagnosticVirtualTextHint = { bg = colors.none },
  }
}

vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = function()
    vim.cmd("Catppuccin " .. (vim.v.option_new == "light" and "latte" or "frappe"))
  end,
})

--- }}}

-- Lazy LSP {{{

require('lazy-lsp').setup {
  excluded_servers = {},
  default_config = {},
  configs = {},
}

--- }}}

-- Lualine {{{

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict

  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed
    }
  end
end

require('lualine').setup {
  theme = "gruvbox-material",
  sections = {
    lualine_b = { {'diff', source = diff_source}, },
  }
}

--- }}}

--- {{{ Treesitter

require 'nvim-treesitter.configs'.setup {
  ensure_installed = "all",

  sync_install = false,
  auto_install = true,

  highlight = { enable = true },
}

--- }}}
