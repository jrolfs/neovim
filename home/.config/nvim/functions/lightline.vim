function! LightLineModified()
  return &filetype =~# 'help' ? '' : &modified ? "\uF0A3" : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &filetype !~? 'help' && &readonly ? "\uE0A2" : ''
endfunction

function! LightLineFilename()
  let l:fname = expand('%')

  return l:fname ==# '__Tagbar__' ? g:lightline.fname :
        \ l:fname =~# '__Gundo' ? '' :
        \ &filetype ==# 'vimfiler' ? vimfiler#get_status_string() :
        \ &filetype ==# 'unite' ? unite#get_status_string() :
        \ ('' !=# LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ ('' !=# l:fname ? l:fname : '[No Name]') .
        \ ('' !=# LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo' && &filetype !~? 'vimfiler' && exists('*fugitive#head')
      let l:mark = "\uE0A0 "
      let l:branch = fugitive#head()
      return l:branch !=# '' ? l:mark.branch : ''
    endif
  catch
  endtry
  return ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? (WebDevIconsGetFileFormatSymbol() . &fileformat) : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? (WebDevIconsGetFileTypeSymbol() . ' ') : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (&fileencoding !=# '' ? &fileencoding : &encoding) : ''
endfunction

function! LightLineMode()
  let l:fname = expand('%:t')

  return l:fname ==# '__Tagbar__' ? 'Tagbar' :
        \ l:fname ==# '__Gundo__' ? 'Gundo' :
        \ l:fname ==# '__Gundo_Preview__' ? 'Gundo Preview' :
        \ &filetype ==# 'unite' ? 'Unite' :
        \ &filetype ==# 'vimfiler' ? 'VimFiler' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction
