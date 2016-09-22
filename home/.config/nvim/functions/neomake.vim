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

function! NeomakeSetExecutableEslint()
  let l:npm_bin = ''
  let l:eslint = 'eslint'

  if executable('npm')
    let l:npm_bin = split(system('npm bin'), '\n')[0]
  endif

  if strlen(l:npm_bin) && executable(l:npm_bin . '/eslint')
    let l:eslint = l:npm_bin . '/eslint'
  endif

  let g:neomake_javascript_eslint_exe = l:eslint
endfunction

function! NeomakeGetExecutableVint()
  if executable('vint')
    return 'vint'
  endif

  let l:pyenv_vint = split(system('pyenv which vint'), '\n')[0]

  if executable(l:pyenv_vint)
    return l:pyenv_vint
  else
    throw 'Could not find vint'
  endif
endfunction
