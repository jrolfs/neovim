local utilities = require('utilities')
local catppuccin = require('catppuccin.palettes').get_palette()

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
  hide_at = function(width)
    return function ()
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

local function filename(overrides)
    local defaults = {
      'filename',
      icons_enabled = true,
      cond = conditions.buffer_not_empty,
      color = { fg = catppuccin.subtext0, bg = 'none', gui = 'none' },
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
          return ''
        end,
        color = function()
          return { fg = catppuccin.surface1, bg = color_for_mode() }
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
        color = { fg = colors.fg, gui = 'none' },
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
          local msg = 'ﮤ'
          local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
          local clients = vim.lsp.get_active_clients()

          if next(clients) == nil then
            return msg
          end

          local clients_formatted = ''

          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              clients_formatted = (
                  string.len(clients_formatted) == 0
                      and client.name
                      or clients_formatted .. ', ' .. client.name
                  )
            end
          end

          return (
              string.len(clients_formatted) > 0
                  and 'ﮣ ' .. clients_formatted
                  or msg
              )
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
