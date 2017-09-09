"
" Syntax

augroup syntax
  autocmd! BufRead,BufNewFile .babelrc,.jshintrc,.eslintrc set filetype=json
  autocmd! BufRead,BufNewFile *.boot set filetype=clojure
  autocmd! BufRead,BufNewFile *.hst set syntax=sh
  autocmd! BufRead,BufNewFile Dockerfile.* set syntax=dockerfile
  autocmd! FileType gitcommit set filetype=markdown.pandoc
augroup END

augroup ALESignHighlightGroup
   autocmd! VimEnter,ColorScheme * call UpdateHightlights()
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
