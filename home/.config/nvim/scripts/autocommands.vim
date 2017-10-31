"
" Syntax

augroup syntax
  autocmd! BufRead,BufNewFile .babelrc,.jshintrc,.eslintrc* setlocal filetype=json
  autocmd! BufRead,BufNewFile *.boot setlocal filetype=clojure
  autocmd! BufRead,BufNewFile *.hst setlocal syntax=sh
  autocmd! BufRead,BufNewFile Dockerfile.* setlocal syntax=dockerfile
augroup END

augroup ALESignHighlightGroup
   autocmd! VimEnter,ColorScheme * call UpdateHighlights()
augroup END

augroup vimtest
  autocmd! DirChanged * call ToggleTestStrategies()
augroup END

augroup FlowBin
  autocmd! DirChanged * call UpdateFlowBin()
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
