"
" Syntax

augroup syntax
  autocmd! BufRead,BufNewFile .babelrc,.jshintrc,.eslintrc set filetype=json
  autocmd! BufRead,BufNewFile *.boot set filetype=clojure
  autocmd! BufRead,BufNewFile *.hst set syntax=sh
  autocmd! BufRead,BufNewFile Dockerfile.* set syntax=dockerfile
augroup END

augroup ALESignHighlightGroup
   autocmd! VimEnter,ColorScheme * call SetALEHighlights()
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
  autocmd! BufEnter * if &buftype == 'terminal' | :startinsert | endif
augroup END
