function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
    set number
  else
    set relativenumber
  endif
endfunction

function! TabooTabTitle(tabnumber)
  let l:icon = WebDevIconsGetFileTypeSymbol()

  echom "asdf"

  return l:icon . ' %P%m'
endfunction
