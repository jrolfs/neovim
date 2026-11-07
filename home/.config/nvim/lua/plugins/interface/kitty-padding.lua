if vim.env.TERM ~= 'xterm-kitty' then
  return
end

-- Sent in-band through the TUI, the same route kitty-tabs.zsh uses for tab
-- titles, so nothing is spawned on the way out. `state:self` pins it to
-- Neovim's own pane, because set-spacing's documented default is the focused
-- one.
local function set_padding(padding)
  local settings = {}
  for _, side in ipairs({ 'top', 'right', 'bottom', 'left' }) do
    settings['padding-' .. side] = padding
  end

  vim.api.nvim_ui_send(('\27P@kitty-cmd%s\27\\'):format(vim.json.encode({
    cmd = 'set-spacing',
    version = { 0, 14, 2 },
    no_response = true,
    payload = { match_window = 'state:self', settings = settings },
  })))
end

local group = vim.api.nvim_create_augroup('kitty-padding', {})

vim.api.nvim_create_autocmd({ 'UIEnter', 'VimResume' }, {
  group = group,
  callback = function() set_padding(0) end,
})

-- vim.NIL encodes as null, which kitty takes as "back to window_padding_width".
vim.api.nvim_create_autocmd({ 'VimLeavePre', 'VimSuspend' }, {
  group = group,
  callback = function() set_padding(vim.NIL) end,
})
