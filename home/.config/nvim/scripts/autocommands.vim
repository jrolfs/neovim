scriptencoding utf-8

"
" Syntax

augroup syntax
  autocmd! BufRead,BufNewFile .babelrc,.jshintrc,.eslintrc*,.nycrc setlocal filetype=json
  autocmd! BufRead,BufNewFile *.boot setlocal filetype=clojure
  autocmd! BufRead,BufNewFile *.hst setlocal syntax=sh
  autocmd! BufRead,BufNewFile Dockerfile.* setlocal syntax=dockerfile
augroup END

augroup vimtest
  autocmd! DirChanged * call ToggleTestStrategies()
augroup END


"
" Terminal

augroup terminal_insert
  autocmd! BufEnter * if &buftype == 'terminal' | :startinsert | endif
augroup END


"
" Goyo

function! s:goyo_enter()
  silent !tmux set status off
  silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  set noshowmode
  set noshowcmd
  set scrolloff=999
  Limelight
endfunction

function! s:goyo_leave()
  silent !tmux set status on
  silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  set showmode
  set showcmd
  set scrolloff=5
  Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
