function! NeomakePostInstall(info)
  " Node
  execute '!npm install -g
    \ eslint
    \ jsonlint
    \ sass-lint
    \ coffeelint
    \ markdownlint-cli'

  " Python
  !pip install vim-vint
endfunction

function! NeomakeSetExecutableLocalEslint()
  let l:npm_bin = ''
  let l:eslint = 'eslint'

  if executable('npm')
    let l:npm_bin = split(system('npm bin'), '\n')[0]
  endif

  if strlen(l:npm_bin) && executable(l:npm_bin . '/eslint')
    let l:eslint = l:npm_bin . '/eslint'
  endif

  if executable(l:eslint)
    let b:neomake_javascript_eslint_exe = l:eslint
  else
    let b:neomake_javascript_eslint_exe = NodenvGetGlobalExecutable('eslint')
  endif
endfunction
