scriptencoding utf-8

function! SyntaxItem()
  return synIDattr(synID(line('.'), col('.'), 1), 'name')
endfunction

let g:airline_show_highlight = 0

function! AirlineToggleShowHighlight()
  if g:airline_show_highlight == 0
    let g:airline_section_z = '%{SyntaxItem()}'
    let g:airline_show_highlight = 1
  else
    let g:airline_section_z = '%3p％%3v⮐ '
    let g:airline_show_highlight = 0
  endif

  :AirlineRefresh
endfunction
