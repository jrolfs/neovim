scriptencoding utf-8

"
" Disable autocompletion for terryma/vim-multiple-cursors

function! Multiple_cursors_before()
    let b:deoplete_disable_auto_complete = 1
endfunction

function! Multiple_cursors_after()
    let b:deoplete_disable_auto_complete = 0
endfunction
