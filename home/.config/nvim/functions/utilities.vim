function! NodenvGetGlobalExecutable(executable)
  return split(system('NODENV_VERSION=$(nodenv global) nodenv which ' . a:executable), '\n')[0]
endfunction

function! RbenvGetGlobalExecutable(executable)
  return split(system('RBENV_VERSION=$(rbenv global) rbenv which ' . a:executable), '\n')[0]
endfunction

function! PyenvGetGlobalExecutable(executable)
  return split(system('PYENV_VERSION=$(pyenv global) pyenv which ' . a:executable), '\n')[0]
endfunction
