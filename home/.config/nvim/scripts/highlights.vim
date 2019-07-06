scriptencoding utf-8

function! s:SetChooseWinHighlights() abort
  execute 'highlight! link ChooseWinLabel airline_x'
  execute 'highlight! link ChooseWinLabelCurrent airline_y'
  execute 'highlight! link ChooseWinLand airline_y'
endfunction

function! SetOniSignHighlight() abort
  let l:fg = GetHighlightProperty('SignColumn', 'fg')
  let l:bg = GetHighlightProperty('Normal', 'bg')
endfunction

function! UpdateHighlights()
  call s:SetChooseWinHighlights()
endfunction
