let g:gui_oni = exists('g:gui_oni') && g:gui_oni
let g:gui_vimr = has('gui_vimr')

let g:gui = g:gui_oni || g:gui_vimr
