function! InstallNeomakeTools(info)
  execute '!npm install -g
    \ eslint
    \ jsonlint
    \ sass-lint
    \ coffeelint
    \ markdownlint-cli'
  !pip install vim-vint
endfunction
