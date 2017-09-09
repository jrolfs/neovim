function! UpdateFlowBin() abort
  let l:local_flow = finddir('node_modules', '.;') . '/.bin/flow'

  if matchstr(l:local_flow, "^\/\\w") ==# ''
    let l:local_flow = getcwd() . '/' . l:local_flow
  endif

  if executable(l:local_flow)
    let g:autocomplete_flow#flowbin = l:local_flow
  else
    let g:autocomplete_flow#flowbin = 'flow'
  endif
endfunction
