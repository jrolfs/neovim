local M = {}

-- Kitty's `active_border_color` (kitty/themes/current.conf), so a float framed
-- this way reads like one of kitty's own panes. Hardcoded because that value is
-- the gruvbox-material medium background while the editor runs soft, leaving no
-- highlight group in the active colorscheme that carries it.
local kitty_border_color = "#282828"

-- Every position is a full block, which sidesteps corner geometry entirely. A
-- partial-cell edge has no corner glyph that meets it exactly: nothing in the
-- Block Elements, Legacy Computing or Powerline ranges has a diagonal
-- terminating at the half line, and kitty rasterizes quadrants and half blocks
-- from separate code paths that can disagree by a pixel.
M.characters = {
  top = "█",
  right = "█",
  bottom = "█",
  left = "█",
  top_left = "█",
  top_right = "█",
  bottom_right = "█",
  bottom_left = "█",
}

--- Border spec for `nvim_open_win`, which takes characters clockwise from the
--- top-left corner and pairs each with its own highlight group.
M.native = function(highlight)
  local c = M.characters

  return {
    { c.top_left, highlight },
    { c.top, highlight },
    { c.top_right, highlight },
    { c.right, highlight },
    { c.bottom_right, highlight },
    { c.bottom, highlight },
    { c.bottom_left, highlight },
    { c.left, highlight },
  }
end

--- Border spec for plenary's popup.nvim, which Telescope draws its borders
--- with. It takes edges before corners and applies one highlight group to the
--- whole border window rather than one per character.
M.popup = function()
  local c = M.characters

  return {
    c.top, c.right, c.bottom, c.left,
    c.top_left, c.top_right, c.bottom_right, c.bottom_left,
  }
end

local apply_highlights = function()
  for _, group in ipairs({ "OilFloatBorder", "TelescopeBorder" }) do
    vim.api.nvim_set_hl(0, group, { fg = kitty_border_color, bg = "NONE" })
  end

  -- Telescope's windows default to `Normal`, which gruvbox-material leaves
  -- transparent, so the border would enclose nothing.
  vim.api.nvim_set_hl(0, "TelescopeNormal", { link = "NormalFloat" })

  local float = vim.api.nvim_get_hl(0, { name = "NormalFloat" })
  if not float.bg then return end

  -- Titles keep the float's own colours rather than the border's, so they read
  -- as a label inset into the ring instead of disappearing into it.
  local background = string.format("#%06x", float.bg)
  local foreground = float.fg and string.format("#%06x", float.fg) or "#ffffff"

  for _, group in ipairs({ "OilFloatTitle", "TelescopeTitle" }) do
    vim.api.nvim_set_hl(0, group, { fg = foreground, bg = background })
  end
end

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("FloatBorder", { clear = true }),
  callback = apply_highlights,
})

apply_highlights()

return M
