"
" Local Helpers

function! s:SplitLines(string)
  return split(a:string, '\n')
endfunction

function! s:FirstLine(string)
  return s:SplitLines(a:string)[0]
endfunction

function! s:EnvWhich(env, executable)
  return a:env .  'env which ' . a:executable
endfunction


"
" Env Executable Getters

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

function! NodeClosestExecutable(executable)
  return system('cd ' . getcwd() . ' && npm-which ' . a:executable)
endfunction

function! UpdateNeoformatBinaries()
  let g:prettier_eslint_bin = NodeClosestExecutable('prettier-eslint')
  let g:prettier_bin = NodeClosestExecutable('prettier')

  let g:neoformat_enabled_javascript = ['prettiereslint']
  let g:neoformat_javascript_prettiereslint = {
        \ 'exe': g:prettier_eslint_bin,
        \ 'args': ['--stdin'],
        \ 'stdin': 1
        \ }

  let g:neoformat_enabled_typescript = ['prettier']
  let g:neoformat_typescript_prettier = {
        \ 'exe': g:prettier_bin,
        \ 'args': [
        \   '--stdin',
        \   '--parser typescript',
        \   '--print-width 100',
        \   '--tab-width 4',
        \   '--no-bracket-spacing'
        \ ],
        \ 'stdin': 1
        \ }
endfunction

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
