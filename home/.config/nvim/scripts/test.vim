function! ToggleTestStrategies()
  let l:directory = expand('%:p')
  let l:mocha = 'test#javascript#mocha#options'

  if (l:directory =~? 'search-result-node')
    let g:{l:mocha} = '--compilers js:babel-core/register'
  elseif (l:directory =~? 'redemption-proxy')
    let g:{l:mocha} = '-r ts-node/register -r src/declarations.ts'
  else
    if exists('g:' . l:mocha)
      unlet g:{l:mocha}
    endif
  endif
endfunction

augroup vimtest
  autocmd! TabEnter,TabNew,TabNewEntered * call ToggleTestStrategies()
  autocmd! BufRead,BufNewFile *.js call ToggleTestStrategies()
augroup END

let g:test#javascript#mocha#file_pattern = '\vtests?/.*\.(ts|js|jsx|coffee)$'
