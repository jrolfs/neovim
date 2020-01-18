" vint: -ProhibitAutocmdWithNoGroup
" vim: set ft=vim:
scriptencoding utf-8

function s:terminal_insert()
  if &buftype ==# 'terminal'
    :CocDisable
    :startinsert
  else
    :CocEnable
  endif
endfunction

autocmd BufEnter * call s:terminal_insert()
