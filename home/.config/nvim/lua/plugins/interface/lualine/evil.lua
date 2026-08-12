local utilities = require('utilities')

-- Catppuccin
local catppuccin = require('catppuccin.palettes').get_palette()

-- Gruvbox Material
local configuration = vim.fn['gruvbox_material#get_configuration']()
local gruvbox = vim.fn['gruvbox_material#get_palette'](configuration.background,
  configuration.foreground, configuration.colors_override)

-- stylua: ignore
local catppuccin_colors = {
  bg       = catppuccin.surface1,
  fg       = catppuccin.text,
  fg2      = catppuccin.overlay0,
  fg3      = catppuccin.overlay1,
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

-- stylua: ignore
local gruvbox_colors = {
  bg       = gruvbox.bg1[1],
  fg       = gruvbox.fg1[1],
  fg2      = gruvbox.fg0[1],
  yellow   = gruvbox.yellow[1],
  cyan     = gruvbox.aqua[1],
  darkblue = gruvbox.blue[1],
  green    = gruvbox.green[1],
  orange   = gruvbox.orange[1],
  violet   = gruvbox.purple[1],
  magenta  = gruvbox.red[1],
  blue     = gruvbox.blue[1],
  red      = gruvbox.red[1],
}

local colors = vim.g.colorscheme == 'gruvbox-material' and gruvbox_colors or
    catppuccin_colors

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_at = function(width)
    return function()
      return vim.fn.winwidth(0) > width
    end
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

local formatters = {
  truncate_at = function(length, width)
    return function(data)
      local truncate = width == nil or vim.fn.winwidth(0) <= width
      return (truncate and data:sub(0, length) .. '…' or data)
    end
  end,
}

local function color_for_mode()
  local color = {
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

  return color[vim.fn.mode()]
end

-- Flatten a list of { value = x, modes = { ... } } groups into a
-- mode -> value lookup — the Lua analogue of a JS Map keyed by arrays.
local function index_by_mode(groups)
  local lookup = {}
  for _, group in ipairs(groups) do
    for _, mode in ipairs(group.modes) do
      lookup[mode] = group.value
    end
  end
  return lookup
end

-- One Nerd Font codepoint per group, shared across related Vim modes.
-- '\22' = <C-v> (visual block); '\19' = <C-s> (select block).
local icon_by_mode = index_by_mode {
  { value = 0xf11c,  modes = { 'n' } },                   -- normal
  { value = 0xf0d74, modes = { 'i', 'ic' } },             -- insert (pencil)
  { value = 0xf0486, modes = { 'v' } },                   -- visual (eye)
  { value = 0xf0fda, modes = { 'V', } },                  -- visual (eye)
  { value = 0xf0a6c, modes = { '\22' } },                 -- visual (eye)
  { value = 0xf245,  modes = { 's', 'S', '\19' } },       -- select (pointer)
  { value = 0xf0871, modes = { 'c', 'cv', 'ce' } },       -- command (terminal)
  { value = 0xf06d4, modes = { 'R', 'Rv' } },             -- replace (refresh)
  { value = 0xf059,  modes = { 'r', 'rm', 'r?', 'no' } }, -- prompt / operator-pending
  { value = 0xf140b, modes = { '!' } },                   -- shell (bolt)
  { value = 0xea85,  modes = { 't' } },                   -- terminal
}

local function icon_for_mode()
  local codepoint = icon_by_mode[vim.fn.mode()]
  return codepoint and vim.fn.nr2char(codepoint) or ''
end

local function filename(overrides)
  local defaults = {
    'filename',
    icons_enabled = true,
    cond = conditions.buffer_not_empty,
    color = { fg = colors.fg, bg = 'none', gui = 'none' },
    fmt = function(data)
      return data:gsub('%[%+%]', ''):gsub('%[%-%]', 'ﱮ')
    end
  }

  return (overrides and utilities.merge(defaults, overrides) or defaults)
end

local config = {
  options = {
    component_separators = '',
    section_separators = '',
    theme = {
      normal = {
        a = { fg = colors.fg, bg = colors.bg },
        b = { fg = colors.fg, bg = colors.bg },
        c = { fg = colors.fg, bg = colors.bg },
      },
      inactive = { c = { fg = catppuccin.overlay0, bg = 'none' } },
    },
  },
  sections = {
    lualine_a = {
      {
        function()
          return icon_for_mode()
        end,
        color = function()
          return { fg = colors.bg, bg = color_for_mode() }
        end,
        padding = { right = 1, left = 1 },
        separator = { right = '' }
      }
    },
    lualine_b = {
      -- Filename
      filename()
    },
    lualine_c = {
      {
        function()
          return ''
        end,
        code = conditions.buffer_not_empty,
        color = { fg = colors.bg, bg = 'none' },
        padding = { left = 0 },
      },

      -- Location
      'location',

      -- Progress
      {
        'progress',
        cond = conditions.hide_at(80),
        color = { fg = colors.fg2, gui = 'none' },
      },

      -- Diagnostics
      {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        symbols = { error = ' ', warn = ' ', info = ' ' },
        diagnostics_color = {
          color_error = { fg = colors.red },
          color_warn = { fg = colors.yellow },
          color_info = { fg = colors.cyan },
        },
      },

      -- Spacer
      function()
        return '%='
      end,

      -- Language Server
      {
        function()
          local msg = '· ⋯ ·'
          local clients = vim.lsp.get_clients({ bufnr = 0 })

          if #clients == 0 then
            return msg
          end

          local names = {}
          for _, client in ipairs(clients) do
            table.insert(names, client.name)
          end

          return '󰴽 ' .. table.concat(names, ' • ')
        end,
        color = { fg = '#ffffff', gui = 'none' },
      }
    },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {
      -- Filename
      filename({
        path = 1,
        color = { fg = catppuccin.overlay1, bg = 'none', gui = 'none' },
        shorting_target = 80,
      })
    },
    lualine_x = {},
  },
}

local function insert_x(component)
  table.insert(config.sections.lualine_x, component)
end

insert_x {
  'filetype',
  icons_enabled = true,
  color = { fg = catppuccin.subtext0, gui = 'none' },
}

insert_x {
  'o:encoding', -- option component same as &encoding in viml
  cond = conditions.hide_at(100),
  icons_enabled = true,
  color = { fg = catppuccin.overlay1, gui = 'none' },
}

insert_x {
  'fileformat',
  fmt = string.upper,
  icons_enabled = true, -- I think icons are cool but Eviline doesn't have them. sigh
  color = { fg = catppuccin.subtext0, gui = 'bold' },
}

insert_x {
  'branch',
  icon = '',
  color = { fg = colors.darkblue, gui = 'bold' },
  fmt = formatters.truncate_at(8, 120)
}

insert_x {
  'diff',
  symbols = { added = ' ', modified = ' ', removed = ' ' },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  cond = conditions.hide_at(80),
}

return config
