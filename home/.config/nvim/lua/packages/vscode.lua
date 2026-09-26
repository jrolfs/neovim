local common = require('packages.common')

-- Same reasoning as packages/terminal.lua, and the extension host has even
-- less to show a prompt with.
vim.pack.add(vim.list_extend(vim.deepcopy(common), {
  'https://github.com/editorconfig/editorconfig-vim',
}), { confirm = false })
