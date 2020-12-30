" Pane navigation
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <C-h> <C-w>h

" Quickfix
nnoremap <leader>qq :ccl<cr>

" Search
noremap <silent> <leader>/ :noh<cr>

" Navigation
nnoremap ]q :cnext<cr>zz
nnoremap [q :cprev<cr>zz

nnoremap ]l :lnext<cr>zz
nnoremap [l :lprev<cr>zz

nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

noremap ]w :tabnext<cr>
noremap [w :tabprevious<cr>

" Source configuration
nmap <leader>C <plug>(configuration-source)

" Show highlights
nmap <leader>H <plug>(configuration-show-highlights)

" EasyAlign
xmap ga <plug>(EasyAlign)
nmap ga <plug>(EasyAlign)

