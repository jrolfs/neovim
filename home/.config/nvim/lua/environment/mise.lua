local output = vim.fn.system("mise env --json 2>/dev/null")
if vim.v.shell_error == 0 then
  for var, val in pairs(vim.json.decode(output)) do
    vim.env[var] = val
  end
end
