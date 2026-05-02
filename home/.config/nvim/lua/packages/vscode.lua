local common = require('packages.common')

vim.pack.add(vim.list_extend(vim.deepcopy(common), {
  'https://github.com/editorconfig/editorconfig-vim',
}))
