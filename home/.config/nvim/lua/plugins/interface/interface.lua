vim.opt.fillchars:append({ vert = ' ', eob = ' ' })

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    local configuration = vim.fn['gruvbox_material#get_configuration']()
    local palette = vim.fn['gruvbox_material#get_palette'](configuration.background, configuration.foreground, configuration.colors_override)
    local bg = palette.bg1[1]
    vim.api.nvim_set_hl(0, 'WinSeparator', { fg = bg, bg = bg })

    local function blend(hex1, hex2, t)
      local r1, g1, b1 = hex1:match('#(%x%x)(%x%x)(%x%x)')
      local r2, g2, b2 = hex2:match('#(%x%x)(%x%x)(%x%x)')
      local function mix(a, b) return math.floor(tonumber(a, 16) * (1 - t) + tonumber(b, 16) * t) end
      return string.format('#%02x%02x%02x', mix(r1, r2), mix(g1, g2), mix(b1, b2))
    end

    vim.api.nvim_set_hl(0, 'CursorLine', { bg = blend(palette.bg0[1], palette.bg1[1], 0.3) })
  end,
})
