function s:SourceConfiguration()
  execute 'source ' . stdpath('config') .  '/' . g:init
  echom 'sourced configuration'
endfunction

noremap <silent> <plug>(source-configuration) :<C-U>call <SID>SourceConfiguration()<CR>

