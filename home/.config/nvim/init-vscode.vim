scriptencoding utf-8

runtime settings/globals.vim

let g:init = 'init-vscode.vim'


""
" @section Plugins, plugins

call plug#begin(stdpath('data') . '/plugged-vscode')

let g:backup_directory = 'backups-vscode'

runtime settings/common.vim
runtime mappings/common.vim

""
" @section Plugins, interface
Plug 'editorconfig/editorconfig-vim'

""
" @section Plugins, motion
Plug 'AndrewRadev/splitjoin.vim'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-surround'
Plug 'wellle/targets.vim'

""
" @section Plugins, search
Plug 'tpope/vim-abolish'

call plug#end()

"
" @section Mappings, mappings

" xmap gc  <plug>VSCodeCommentary
" nmap gc  <plug>VSCodeCommentary
" omap gc  <plug>VSCodeCommentary
" nmap gcc <plug>VSCodeCommentaryLine

noremap [w :<C-u>call VSCodeCall('workbench.action.previousEditor')<cr>
noremap ]w :<C-u>call VSCodeCall('workbench.action.nextEditor')<cr>

noremap [d :<C-u>call VSCodeCall('editor.action.marker.prev')<cr>
noremap ]d :<C-u>call VSCodeCall('editor.action.marker.next')<cr>

noremap [c :<C-u>call VSCodeCall('workbench.action.editor.previousChange')<cr>
noremap ]c :<C-u>call VSCodeCall('workbench.action.editor.nextChange')<cr>

noremap <c-w>H :<C-u>call VSCodeCall('workbench.action.moveActiveEditorGroupLeft')<cr>
noremap <c-w>J :<C-u>call VSCodeCall('workbench.action.moveActiveEditorGroupDown')<cr>
noremap <c-w>K :<C-u>call VSCodeCall('workbench.action.moveActiveEditorGroupUp')<cr>
noremap <c-w>L :<C-u>call VSCodeCall('workbench.action.moveActiveEditorGroupRight')<cr>

noremap <leader>af :<C-u>call VSCodeCall('editor.action.formatDocument')<cr>
noremap <leader>ef :<C-u>call VSCodeCall('eslint.executeAutofix')<cr>
noremap <leader>of :<C-u>call VSCodeCall('oxc.applyAllFixesFile')<cr>

noremap <leader>re :<C-u>call VSCodeCall('eslint.restart')<cr>
noremap <leader>rt :<C-u>call VSCodeCall('typescript.restartTsServer')<cr>
noremap <leader>ro :<C-u>call VSCodeCall('oxc.restartServer')<cr>

noremap <leader>z :<C-u>call VSCodeCall('workbench.action.maximizeEditor')<cr>
noremap <leader>= :<C-u>call VSCodeCall('workbench.action.evenEditorWidths')<cr>

nnoremap gqq gqq
vnoremap gq gq

set nu rnu

autocmd InsertEnter * set nu nornu
autocmd InsertLeave * set nu rnu

" Attempt at hacking for supporting persistent undo in vscode-neovim. This isn't working yet with either the `autocmd`
" or a manual call to `VSCodeWriteUndoFile` per the mapping in the GitHub example
" See: https://github.com/vscode-neovim/vscode-neovim/issues/474#issuecomment-2537746208

augroup vim_undodir_tree
  autocmd!
  autocmd BufEnter * call s:ReadUndoFile()
  autocmd BufWritePost * call s:WriteUndoFile()
augroup END

function! VSCodeWriteUndoFile()
  call s:WriteUndoFile()
endfunction

function! s:GetUndoFile(filepath)
  let undofile = undofile(a:filepath)
  let undofile = substitute(undofile, '%', '/', 'g')
  let undofile = substitute(undofile, '//', '/', 'g')
  return undofile
endfunction

function! s:WriteUndoFile()
  let undofile = s:GetUndoFile(expand('%:p'))
  let undodir = fnamemodify(undofile, ":h")
  if !isdirectory(undodir)
    call mkdir(undodir, "p")
  endif

  execute 'wundo ' . fnameescape(undofile)
endfunction

function! s:ReadUndoFile()
  let undofile = s:GetUndoFile(expand('%:p'))
  if filereadable(undofile)
    execute 'silent! rundo ' . fnameescape(undofile)
  endif
endfunction

lua require('init-vscode')
