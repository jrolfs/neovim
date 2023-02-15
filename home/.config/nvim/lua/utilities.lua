local M = {}

M.merge = function(table1, table2)
  for k, v in pairs(table2) do
    if type(v) == 'table' then
      table1[k] = M.merge(table1[k], table2[k])
    else
      table1[k] = v
    end
  end

  return table1
end

-- Keymap helper
--
-- @usage
-- map('n', '<leader>hp', qa.preview_hunk)
--
M.map = function(mode, binding, command, options)
  options = options or {}

  vim.keymap.set(mode, binding, command, options)
end

-- Buffer-specific keymap helper
--
-- @usage
-- local map = map_buffer(buffer)
-- map('n', '<leader>hp', qa.preview_hunk)
--
M.map_buffer = function(buffer)
  return function(mode, binding, command, options)
    options.buffer = buffer

    M.map(mode, binding, command, options)
  end
end

-- Keymap helper for vscode-neovim mappings
--
-- @usage
-- map_vs('n', '<leader>re', 'eslint.restart')
--
M.map_vs = function(mode, binding, command, options)
  local call

  options = options or {}

  if options.blocking or options.blocking == nil then
    call = ":<C-u>call VSCodeCall('" .. command .. "')<cr>"
  else
    call = ":<C-u>call VSCodeNotify('" .. command .. "')<cr>"
  end

  options.blocking = nil

  vim.keymap.set(mode, binding, call, options)
end


return M
