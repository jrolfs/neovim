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
