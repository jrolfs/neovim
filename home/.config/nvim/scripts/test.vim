function! ToggleTestStrategies()
  let l:directory = expand('%:p')
  let l:mocha = 'test#javascript#mocha#options'

  if (l:directory =~? 'search-result-node')
    let g:{l:mocha} = '--compilers js:babel-core/register'
  elseif (l:directory =~? 'wtf-service' || l:directory =~? 'loyalty-site')
    let g:{l:mocha} = '-r ts-node/register'
  else
    if exists('g:' . l:mocha)
      unlet g:{l:mocha}
    endif
  endif
endfunction

let g:test#javascript#mocha#file_pattern = '\vtests?/.*\.(ts|js|jsx|coffee)$'
