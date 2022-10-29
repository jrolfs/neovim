-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir

local catppuccin = require('catppuccin.palettes').get_palette()

-- Color table for highlights
-- stylua: ignore
local colors = {
  bg       = catppuccin.surface1,
  fg       = catppuccin.text,
  yellow   = catppuccin.yellow,
  cyan     = catppuccin.sky,
  darkblue = catppuccin.blue,
  green    = catppuccin.green,
  orange   = catppuccin.peach,
  violet   = catppuccin.mauve,
  magenta  = catppuccin.pink,
  blue     = catppuccin.sapphire,
  red      = catppuccin.red,
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Config
local config = {
  options = {
    -- Disable sections and component separators
    component_separators = '',
    section_separators = '',
    theme = {
      -- We are going to use lualine_c an lualine_x as left and
      -- right section. Both are highlighted by c theme .  So we
      -- are just setting default looks o statusline
      normal = { c = { fg = colors.fg, bg = colors.bg } },
      inactive = { c = { fg = catppuccin.overlay0, bg = 'none' } },
    },
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {
      {
        'filename',
        cond = conditions.buffer_not_empty,
        path = 1,
        shortening_target = 0,
        color = { fg = catppuccin.overlay1, bg = 'none', gui = 'none' },
      }
    },
    lualine_x = {},
  },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

-- ins_left {
--   function()
--     return ''
--   end,
--   color = { fg = colors.blue, bg = 'none' }, -- Sets highlighting of component
--   padding = { left = 0, right = 0 }, -- We don't need space before this
-- }

ins_left {
  -- mode component
  function()
    return ''
  end,
  color = function()
    -- auto change color according to neovims mode
    local mode_color = {
      n = colors.violet,
      i = colors.green,
      v = colors.blue,
      [''] = colors.blue,
      V = colors.blue,
      c = colors.magenta,
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      [''] = colors.orange,
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ['r?'] = colors.cyan,
      ['!'] = colors.red,
      t = colors.red,
    }
    return { fg = catppuccin.surface1, bg = mode_color[vim.fn.mode()] }
  end,
  padding = { right = 1, left = 1 },
  separator = { left = '', right = '' }
}

-- ins_left {
--   -- filesize component
--   'filesize',
--   cond = conditions.buffer_not_empty,
-- }

ins_left {
  'filename',
  cond = conditions.buffer_not_empty,
  color = { fg = catppuccin.subtext0, bg = 'none', gui = 'none' },
}

ins_left {
  'location',
  separator = { left = '' }
}

ins_left { 'progress', color = { fg = colors.fg, gui = 'none' } }

ins_left {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = { error = ' ', warn = ' ', info = ' ' },
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.yellow },
    color_info = { fg = colors.cyan },
  },
}

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left {
  function()
    return '%='
  end,
}

ins_left {
  -- Lsp server name .
  function()
    local msg = 'ﮤ'
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return 'ﮣ ' .. client.name
      end
    end
    return msg
  end,
  color = { fg = '#ffffff', gui = 'none' },
}

-- Add components to right sections
ins_right {
  'o:encoding', -- option component same as &encoding in viml
  fmt = string.upper, -- I'm not sure why it's upper case either ;)
  cond = conditions.hide_in_width,
  icons_enabled = true,
  color = { fg = catppuccin.overlay1, gui = 'none' },
}

ins_right {
  'fileformat',
  fmt = string.upper,
  icons_enabled = true, -- I think icons are cool but Eviline doesn't have them. sigh
  color = { fg = catppuccin.subtext0, gui = 'bold' },
}

ins_right {
  'branch',
  icon = '',
  color = { fg = colors.darkblue, gui = 'bold' },
}

ins_right {
  'diff',
  -- Is it me or the symbol for modified us really weird
  symbols = { added = ' ', modified = ' ', removed = ' ' },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  cond = conditions.hide_in_width,
}

ins_right {
  function()
    return ''
  end,
  color = { fg = colors.bg, bg = 'none' },
  padding = { left = 0 },
}

return config
