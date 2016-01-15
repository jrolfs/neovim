" Leader
let mapleader=","


"
" Plugins

call plug#begin('~/.vim/plugged')

" Sensible
Plug 'tpope/vim-sensible'

" Interface
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'bling/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'jeetsukumaran/vim-buffergator'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-rails'
Plug 'terryma/vim-multiple-cursors'
Plug 'godlygeek/tabular'
Plug 'Shougo/neocomplete.git'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'bkad/CamelCaseMotion'
Plug 'danro/rename.vim'

" Tags
Plug 'majutsushi/tagbar'
Plug 'lukaszkorecki/CoffeeTags'

" Syntax
Plug 'scrooloose/syntastic'

Plug 'pangloss/vim-javascript'
Plug 'kchmck/vim-coffee-script'
Plug 'vim-ruby/vim-ruby'
Plug 'AndrewRadev/vim-eco'
Plug 'elzr/vim-json'
Plug 'groenewege/vim-less'
Plug 'chase/vim-ansible-yaml'

call plug#end()


"
" Settings

" Colors
set t_Co=256
syntax on
set background=dark
colorscheme solarized
highlight clear SignColumn
highlight GitGutterAdd ctermfg=green

" Tab Size
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab

" Status Line
set laststatus=2

" Line Numbers
set number

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 0

" Ruler
set colorcolumn=120
set nowrap

" CoffeeScript
let g:coffee_lint_options = '-f ~/coffeelint.json'

"
" Bindings

" Buffers
set hidden
" close buffer
nmap <leader>d :bp<bar>sp<bar>bn<bar>bd<CR>
" close all buffers
nmap <leader>D :bufdo bd<CR>
" Switch between buffers
noremap <S-tab> :bp<CR>
noremap <tab> :bn<CR>

" Tabs
map <C-up> :tabn<cr>
map <C-down> :tabp<cr>
map <C-left> :tabr<cr>
map <C-right> :tabl<cr>

nnoremap <C-t> :tabnew<CR>

" Tab names as directories
function! GuiTabLabel()
  return substitute( expand( '%:p' ), '.\+\/\(.\+\)\/.\+', '\1', '' )
endfunction
set guitablabel=%{GuiTabLabel()}

" Pane navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Completion
let g:neocomplete#enable_at_startup = 1

" CtrlP
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_max_files=0
set wildignore+=*/.git/*,*.scssc,*/tmp/*

nnoremap <Leader>p :CtrlP<CR>

" Nerdtree
map <C-e> :NERDTreeToggle<CR>
nmap ≥ :NERDTreeFind<CR>

" CamelCaseMotion
map „ <Plug>CamelCaseMotion_w
map ı <Plug>CamelCaseMotion_b
map ´ <Plug>CamelCaseMotion_e

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1

map <F6> :SyntasticCheck<CR>
map <F7> :SyntasticToggleMode<CR>

" Tags
map <F8> :TagbarToggle<CR>
let g:CoffeeAutoTagIncludeVars=1

"
" Functions

" Multiple Cursors
let g:multi_cursor_exit_from_insert_mode = 0

function! Multiple_cursors_before()
  if exists(':NeoCompleteLock')==2
    exe 'NeoCompleteLock'
  endif
endfunction

function! Multiple_cursors_after()
  if exists(':NeoCompleteUnlock')==2
    exe 'NeoCompleteUnlock'
  endif
endfunction
