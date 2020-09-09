" vint: -ProhibitAutocmdWithNoGroup
" vim: set ft=vim:
scriptencoding utf-8

function s:terminal_insert()
  if &buftype ==# 'terminal'
    if exists(':CocDisable')
      :CocDisable
    endif

    :startinsert
  else
    if exists(':CocEnable')
      :CocEnable
    endif
  endif
endfunction

autocmd BufEnter * call s:terminal_insert()
