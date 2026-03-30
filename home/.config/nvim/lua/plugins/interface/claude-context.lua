-- Send visual selection context to Claude Code
-- If kitty remote control is available, sends directly to a Claude Code pane
-- in the same kitty tab. Otherwise, copies to the system clipboard.
--
-- Two modes:
--   <leader>cr  Send file reference (path:lines) — Claude reads the file itself
--   <leader>cc  Send full code content with file:line header

local map = require('utilities').map

local function location_string(filepath, start_line, end_line)
  if start_line == end_line then
    return filepath .. ':' .. start_line
  end
  return filepath .. ':' .. start_line .. '-' .. end_line
end

local function find_claude_window_in_tab()
  local ok, result = pcall(vim.fn.system, 'kitty @ ls')
  if not ok or vim.v.shell_error ~= 0 then
    return nil
  end

  local decode_ok, data = pcall(vim.fn.json_decode, result)
  if not decode_ok or not data then
    return nil
  end

  local my_window_id = tonumber(vim.env.KITTY_WINDOW_ID)
  if not my_window_id then
    return nil
  end

  -- Find the tab containing this neovim instance, then look for claude in the same tab
  for _, os_win in ipairs(data) do
    for _, tab in ipairs(os_win.tabs or {}) do
      local tab_has_me = false
      local claude_window_id = nil

      for _, win in ipairs(tab.windows or {}) do
        if win.id == my_window_id then
          tab_has_me = true
        end

        local fg = win.foreground_processes or {}
        for _, proc in ipairs(fg) do
          local cmdline = proc.cmdline or {}
          for _, arg in ipairs(cmdline) do
            if arg:match('claude$') or arg:match('claude%-code$') then
              claude_window_id = win.id
              break
            end
          end
          if claude_window_id then break end
        end
      end

      if tab_has_me and claude_window_id then
        return claude_window_id
      end
    end
  end

  return nil
end

local function send_to_kitty_window(window_id, text)
  vim.fn.system(
    string.format('kitty @ send-text --match id:%d --stdin', window_id),
    text
  )
  return vim.v.shell_error == 0
end

local function focus_kitty_window(window_id)
  vim.fn.system(string.format('kitty @ focus-window --match id:%d', window_id))
end

local function send_or_copy(text, label, opts)
  opts = opts or {}
  local auto_focus = opts.focus ~= false -- default true

  local claude_window = find_claude_window_in_tab()
  if claude_window and send_to_kitty_window(claude_window, text) then
    vim.notify(label .. ' sent to Claude Code', vim.log.levels.INFO)
    if auto_focus then
      focus_kitty_window(claude_window)
    end
  else
    vim.fn.setreg('+', text)
    vim.notify(label .. ' copied to clipboard', vim.log.levels.INFO)
  end
end

local function resolve_filepath(mode)
  local absolute = vim.fn.expand('%:p')
  if mode == 'absolute' then
    return absolute
  end
  local git_root = vim.fn.systemlist('git -C ' ..
  vim.fn.shellescape(vim.fn.expand('%:p:h')) .. ' rev-parse --show-toplevel')[1]
  if vim.v.shell_error == 0 and git_root then
    return absolute:sub(#git_root + 2) -- strip root + trailing slash
  end
  return absolute
end

local function send_reference(opts)
  local filepath = resolve_filepath(opts.path)
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  local location = location_string(filepath, start_line, end_line)

  send_or_copy(location, location, { focus = opts.focus })
end

local function send_context(opts)
  local filepath = resolve_filepath(opts.path)
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  local lines = vim.fn.getline(start_line, end_line)
  local location = location_string(filepath, start_line, end_line)
  local text = location .. '\n' .. table.concat(lines, '\n')

  send_or_copy(text, location, { focus = opts.focus })
end

local options = { 'relative', 'absolute', 'nofocus' }

local function parse_args(args)
  local tokens = vim.split(args, '%s+', { trimempty = true })
  local opts = { path = 'relative', focus = true }
  for _, token in ipairs(tokens) do
    if token == 'absolute' then
      opts.path = 'absolute'
    elseif token == 'relative' then
      opts.path = 'relative'
    elseif token == 'nofocus' then
      opts.focus = false
    end
  end
  return opts
end

vim.api.nvim_create_user_command('ClaudeContext', function(cmd)
  send_context(parse_args(cmd.args))
end, { range = true, nargs = '*', complete = function() return options end })

vim.api.nvim_create_user_command('ClaudeReference', function(cmd)
  send_reference(parse_args(cmd.args))
end, { range = true, nargs = '*', complete = function() return options end })

map('v', '<leader>cc', ':ClaudeContext<CR>',
  { silent = true, desc = 'Send code context to Claude Code' })
map('v', '<leader>cr', ':ClaudeReference<CR>',
  { silent = true, desc = 'Send file reference to Claude Code' })
