"
" Syntax

augroup syntax
  autocmd! BufRead,BufNewFile .babelrc,.jshintrc,.eslintrc set filetype=json
  autocmd! BufRead,BufNewFile *.boot set filetype=clojure
  autocmd! BufRead,BufNewFile *.hst set syntax=sh
  autocmd! BufRead,BufNewFile Dockerfile.* set syntax=dockerfile
augroup END


"
" Redraw

augroup lazyredraw
  autocmd! CursorMoved,CursorMovedI,InsertEnter *.rb,*.jade set lazyredraw
  autocmd! FocusLost * set nolazyredraw
augroup END


"
" Terminal

augroup terminal_insert
  autocmd BufEnter * if &buftype == 'terminal' | :startinsert | endif
augroup END

"
" Formatting

function! SetFormatProgramJavascript()
  let l:formatter = NodenvGetGlobalExecutable('prettier')

  if l:formatter !~# 'prettier'
    return
  endif

  let l:set_arguments = 'formatprg=' . l:formatter . '\ --stdin\ --single-quote'

  let l:tab_size = &l:tabstop
  let l:max_width = &l:colorcolumn

  if match(l:tab_size, '\d+')
    let l:set_arguments .= '\ --tab-width\ ' . l:tab_size
  endif

  if match(l:max_width, '\d+')
    let l:set_arguments .= '\ --print-width\ ' . l:max_width
  endif

  execute 'setlocal' l:set_arguments
endfunction

augroup formatting
  autocmd BufRead,BufNewFile *.js,*.jsx call SetFormatProgramJavascript()
augroup END
