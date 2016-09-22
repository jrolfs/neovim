function! s:SplitLines(string)
  return split(a:string, '\n')
endfunction

function! s:FirstLine(string)
  return s:SplitLines(a:string)[0]
endfunction

function! EnvGetGlobalExecutable(env, executable)
  if !exists('g:' . a:env . 'env_global')
    let g:{a:env}env_global = s:FirstLine(system(a:env . 'env global'))
  end

  let l:executable = substitute(a:executable, '-', '_', 'g')

  if !exists('g:' . a:env . 'env_globals_' . l:executable)
    let g:{a:env}env_globals_{l:executable} = s:FirstLine(system(
      \   toupper(a:env) . 'ENV_VERSION=' . g:{a:env}env_global .
      \   ' ' . a:env .  'env which ' . a:executable
      \ ))
  endif

  return g:{a:env}env_globals_{l:executable}
endfunction

function! NodenvGetGlobalExecutable(executable)
  return EnvGetGlobalExecutable('nod', a:executable)
endfunction

function! RbenvGetGlobalExecutable(executable)
  return EnvGetGlobalExecutable('rb', a:executable)
endfunction

function! PyenvGetGlobalExecutable(executable, ...)
  return EnvGetGlobalExecutable('py', a:executable)
endfunction
