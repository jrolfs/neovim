scriptencoding utf-8

function! ToggleTestStrategies()
  let l:directory = expand('%:p')
  let l:mocha_options = 'test#javascript#mocha#options'
  let l:mocha_bin = 'test#javascript#mocha#executable'

  if (l:directory =~? 'search-result-node')
    let g:{l:mocha_options} = '--compilers js:babel-core/register'
  elseif (l:directory =~? 'wtf-service' || l:directory =~? 'loyalty-site')
    let g:{l:mocha_options} = '-r ts-node/register'
  " elseif (l:directory =~? 'booking-flow')
  "   let g:{l:mocha_options} = '--webpack-config webpack/webpack.test.js'
  "   let g:{l:mocha_bin} = './node_modules/.bin/mocha-webpack'
  else
    if exists('g:' . l:mocha_options)
      unlet g:{l:mocha_options}
    endif

    if exists('g:' . l:mocha_bin)
      unlet g:{l:mocha_bin}
    endif
  endif
endfunction

let g:test#javascript#mocha#file_pattern = '\vtests?/.*\.(ts|js|jsx|coffee)$'
