function! s:SplitLines(string)
  return split(a:string, '\n')
endfunction

function! s:FirstLine(string)
  return s:SplitLines(a:string)[0]
endfunction

function! s:EnvWhich(env, executable)
  return a:env .  'env which ' . a:executable
endfunction

function! EnvGetExecutable(env, executable)
  return s:FirstLine(system(s:EnvWhich(a:env, a:executable)))
endfunction

function! EnvGetGlobalExecutable(env, executable)
  if !exists('g:' . a:env . 'env_global_version')
    let g:{a:env}env_global_version = s:FirstLine(system(a:env . 'env global'))
  end

  let l:executable = substitute(a:executable, '-', '_', 'g')
  let l:global_version = toupper(a:env) . 'ENV_VERSION=' . g:{a:env}env_global_version

  if !exists('g:' . a:env . 'env_globals_' . l:executable)
    let g:{a:env}env_globals_{l:executable} = s:FirstLine(system(l:global_version . ' ' . s:EnvWhich(a:env, a:executable)))
  endif

  return g:{a:env}env_globals_{l:executable}
endfunction

"
" Env Executable Getters

function! NodenvGetExecutable(executable)
  return EnvGetExecutable('nod', a:executable)
endfunction

function! RbenvGetExecutable(executable)
  return EnvGetExecutable('rb', a:executable)
endfunction

function! PyenvGetExecutable(executable, ...)
  return EnvGetExecutable('py', a:executable)
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

"
" Other

function! GetHighlightProperty(group, property) abort
     let l:reverse = synIDattr(synIDtrans(hlID(a:group)), 'reverse')
     let l:property = a:property

     if l:reverse
         if l:property ==# 'fg'
             let l:property = 'bg'
         elseif l:property ==# 'bg'
             let l:property = 'fg'
         elseif l:property ==# 'fg#'
             let l:property = 'bg#'
         elseif l:property ==# 'bg#'
             let l:property = 'fg#'
         endif
     endif

     let l:value = synIDattr(synIDtrans(hlID(a:group)), l:property)

     if l:value == -1
         let l:value = 'NONE'
     endif

     return l:value
 endfunction
