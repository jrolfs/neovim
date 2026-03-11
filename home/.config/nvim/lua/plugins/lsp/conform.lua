require('conform').setup({
  formatters_by_ft = {
    javascript = { 'oxfmt' },
    javascriptreact = { 'oxfmt' },
    typescript = { 'oxfmt' },
    typescriptreact = { 'oxfmt' },
  },
  formatters = {
    oxfmt = {
      command = require('conform.util').from_node_modules('oxfmt'),
      args = { '--stdin-filepath', '$FILENAME' },
      stdin = true,
    },
  },
})
