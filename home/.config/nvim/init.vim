set nocompatible " be iMproved, required
filetype off " required

" Leader
let mapleader=","

set rtp+=~/.vim/Vundle.vim
call vundle#begin()

Plugin 'bling/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'scrooloose/nerdtree'
Bundle 'Shougo/neocomplete.git'
Plugin 'kien/ctrlp.vim'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'airblade/vim-gitgutter'
Plugin 'bkad/CamelCaseMotion'
Plugin 'danro/rename.vim'
Plugin 'tpope/vim-rails'
Plugin 'vim-scripts/EasyGrep'
Plugin 'rking/ag.vim'
Bundle 'jgdavey/tslime.vim'
Plugin 'scrooloose/syntastic'
Plugin 'xolox/vim-misc'
Plugin 'majutsushi/tagbar'
Bundle 'lukaszkorecki/CoffeeTags'
Plugin 'tpope/vim-commentary'
Plugin 'godlygeek/tabular'

Plugin 'chriskempson/base16-vim'
Plugin 'altercation/vim-colors-solarized'

Plugin 'pangloss/vim-javascript'
Plugin 'kchmck/vim-coffee-script'
Plugin 'vim-ruby/vim-ruby'
Plugin 'AndrewRadev/vim-eco'
Plugin 'elzr/vim-json'
Bundle 'groenewege/vim-less'
Bundle 'chase/vim-ansible-yaml'

call vundle#end()            " required
filetype plugin indent on    " required

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

" Backspace
set backspace=indent,eol,start

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

map <Leader>a :call Send_to_Tmux("zeus rspec ".expand("%")."\n")<CR>
map <Leader>s :call Send_to_Tmux("zeus rspec ".expand("%").":".line(".")."\n")<CR>

" EasyGrep
let g:EasyGrepFilesToExclude='tmp'
let g:EasyGrepRecursive=1
let g:EasyGrepCommand=1
let g:EasyGrepMode=2

map <F9> :GrepOptions<CR>

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
