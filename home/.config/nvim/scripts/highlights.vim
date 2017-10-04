function! s:isGui() abort
  return g:gui || has('termguicolors')
endfunction

function! s:AssignBg(value) abort
  return (s:isGui() ? 'guibg=' : 'ctermbg=') . a:value
endfunction

function! s:AssignFg(value) abort
  return (s:isGui() ? 'guifg=' : 'ctermfg=') . a:value
endfunction

function! s:SetALEHighlights() abort
  let l:gui = s:isGui()
  let l:bg = GetHighlightProperty('SignColumn', 'bg')

  let l:assign_bg = s:AssignBg(l:bg)

  " TODO: make the highlights that the sign colors are derived from configurable
  for [l:group, l:fg] in items({
        \ 'ALEErrorSign': GetHighlightProperty('Error', 'bg'),
        \ 'ALEWarningSign': GetHighlightProperty('Todo', 'fg'),
        \ })

    let l:assign_fg = s:AssignFg(l:fg)

    execute 'highlight ' . l:group . 'Default ' . l:assign_fg . ' ' . l:assign_bg
    execute 'highlight link ' . l:group . ' ' . l:group . 'Default'
  endfor
endfunction

function! s:SetChooseWinHighlights() abort
  execute 'highlight! link ChooseWinLabel airline_tabsel'
  execute 'highlight! link ChooseWinLabelCurrent airline_tabmod'
  execute 'highlight! link ChooseWinLand airline_tabmod'
endfunction

function! SetOniSignHighlight() abort
  let l:fg = GetHighlightProperty('SignColumn', 'fg')
  let l:bg = GetHighlightProperty('Normal', 'bg')

  execute 'highlight! SignColumn ' . s:AssignFg(l:fg) . ' ' . s:AssignBg(l:bg)
  execute 'highlight! LineNr ' . s:AssignFg(l:fg) . ' ' . s:AssignBg(l:bg)
  execute 'highlight! VertSplit ' . s:AssignFg(l:bg) . ' ' . s:AssignBg(l:bg)
endfunction

function! UpdateHighlights() abort
  call s:SetALEHighlights()
  call s:SetChooseWinHighlights()
endfunction
