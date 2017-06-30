function! SetALEHighlights() abort
  let l:term = len($TERM) > 0
  let l:bg = GetHighlightProperty('SignColumn', 'bg')

  let l:bg_assign = (l:term ? 'ctermbg=' : 'guibg=') . l:bg

  for [l:group, l:fg] in items({
        \ 'ALEErrorSign': GetHighlightProperty('Error', 'bg'),
        \ 'ALEWarningSign': GetHighlightProperty('Todo', 'fg'),
        \ })

    let l:fg_assign = (l:term ? 'ctermfg=' : 'guifg=') . l:fg

    execute 'highlight ' . l:group . 'Default ' . l:fg_assign . ' ' . l:bg_assign
    execute 'highlight link ' . l:group . ' ' . l:group . 'Default'
  endfor
endfunction
