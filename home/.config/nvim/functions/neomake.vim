function! NeomakePostInstall(info)
  " Node
  execute '!npm install -g
    \ jsonlint
    \ sass-lint
    \ coffeelint
    \ markdownlint-cli'

  " Python
  !pip install vim-vint
endfunction
