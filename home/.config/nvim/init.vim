scriptencoding utf-8

runtime settings/globals.vim
runtime settings/aliases.vim

let g:init = 'init.vim'


""
" @section Plugins, plugins

" Pandoc — must be set BEFORE vim.pack loads vim-pandoc below. `:packadd`
" re-runs the plugin's ftdetect against the command-line buffer immediately,
" so these globals are read at that point. Setting them later (after the
" require) misses files opened directly at launch (e.g. PR descriptions),
" leaving the folding module active and collapsing every section.
let g:pandoc#modules#disabled = ['chdir', 'folding']

let g:pandoc#syntax#codeblocks#embeds#langs = [
  \   'bash=sh',
  \   'javascript',
  \   'js=javascript',
  \   'json=javascript',
  \   'python',
  \   'ruby',
  \   'ts=typescript'
  \ ]

" Polyglot — must be set BEFORE vim.pack loads it below, for the same reason as
" the pandoc globals; it warns at VimEnter if the list arrives late. Polyglot
" sits second to last on the runtimepath, ahead only of $VIMRUNTIME, so the
" copies it bundles shadow both the plugins installed separately below and the
" files Neovim itself ships.
"
" graphql was the entry that was actually broken rather than merely redundant.
" Polyglot's after/syntax/javascript/graphql.vim calls graphql#has_syntax_group(),
" which only polyglot's own autoload defines, and jparise/vim-graphql wins the
" autoload lookup: every .js buffer threw E117. vim-graphql carries the whole
" set (syntax, indent, ftplugin, after/syntax, after/indent), so disabling the
" bundled copy loses no highlighting.
"
" nix and rust shadow rather than break. LnL7/vim-nix supplies nix's syntax,
" ftplugin and indent, rustaceanvim owns rust, and $VIMRUNTIME covers the rest.
"
" sensible is a trimmed vim-sensible that was quietly the last thing to set
" 'tabstop', 'shiftwidth' and 'shortmess'; those are spelled out in
" settings/common.vim now. autoindent is polyglot's own :Sleuth, which
" tpope/vim-sleuth deletes on sight anyway ("Charlatan :Sleuth implementation in
" vim-polyglot has been found and disabled").
"
" What stays enabled is the long tail, the filetypes with neither a $VIMRUNTIME
" syntax file nor a treesitter parser. The language packs are lazy, so leaving
" them costs nothing until such a file is opened.
let g:polyglot_disabled = [
  \   'autoindent',
  \   'graphql',
  \   'nix',
  \   'rust',
  \   'sensible'
  \ ]

lua require('packages.terminal')

runtime settings/interface.vim
runtime settings/common.vim

""
" @section Settings, settings

" Sleuth
let g:sleuth_automatic = 1

" Taboo
let g:taboo_tab_format = ' %m %I%P  '
let g:taboo_renamed_tab_format = '  %m%I%l  '
let g:taboo_modified_tab_flag = '✎'

let g:session_autoload = 'no'
let g:session_autosave = 'yes'
let g:session_autosave_periodic = 1
let g:session_autosave_silent = 1
let g:session_command_aliases = 1
let g:session_directory = stdpath('data') . 'sessions'

" Gundo
let g:gundo_prefer_python3 = 1

" Python
let g:python_host_prog = '/run/current-system/sw/bin/nvim-python'
let g:python3_host_prog = '/run/current-system/sw/bin/nvim-python3'

let g:JavaComplete_UsePython3 = 1
let g:JavaComplete_BaseDir = '~/.cache'

" Tags
let g:tagbar_autofocus = 1

" JSX
let g:jsx_ext_required = 0

" Multiple Cursors
let g:multi_cursor_exit_from_insert_mode = 0

" JSDoc
let g:jsdoc_allow_input_prompt = 1
let g:jsdoc_input_description = 1

" vim-test
let g:test#ruby#rspec#executable = '$(rbenv which zeus) rspec'
let g:test#strategy = 'neoterm'


"
" @section Mappings, mappings

" Omnifunc
inoremap <C-Space> <C-x><C-o>
imap <C-@> <C-Space>

" ALE
nmap <leader>al <plug>(ale_lint)
nmap <leader>af <plug>(ale_fix)
nmap <leader>ap <plug>(ale_previous)
nmap <leader>an <plug>(ale_next)
nmap <leader>agg :ALEGoToDefinition<CR>
nmap <leader>agt :ALEGoToDefinitionInTab<CR>
nmap <leader>ags :sp<CR>:ALEGoToDefinition<CR>
nmap <leader>agv :vs<CR>:ALEGoToDefinition<CR>
nmap <leader>ad :ALEDetail<CR>

" netrw
noremap <leader>ls :Oil --float<CR>
noremap <leader>lS :Oil<CR>

noremap <leader>ly :let @+ = expand("%")<CR>
noremap <leader>lcd :tcd %:p:h<CR>

" Gundo
nnoremap <silent> <leader>z :GundoToggle<CR>

" GitGutter
nnoremap <leader>GG :GitGutter<CR>

" Choosewin
map - <plug>(choosewin)

" Maximixer
nnoremap <C-w>z :MaximizerToggle<CR>

" Find/Replace
nnoremap <leader>rp :%s/"//g<Left><Left>

" Terminal
tnoremap <C-e> <C-\><C-n>
tmap <C-w> <C-e><C-w>

" Neoterm
nmap <silent> <leader>nt :Ttoggle<CR><ESC>
nmap <silent> <leader>nx :Tclose<CR>
nmap <silent> <leader>no :Topen<CR><ESC>
nmap <silent> <leader>nc :Tclear<CR>
nmap <silent> <leader>nk :Tkill<CR>

" Location list
nnoremap <leader>lo :lopen<CR>
nnoremap <leader>lc :lclose<CR>
nnoremap <leader>l, :ll<CR>
nnoremap <leader>ln :lnext<CR>
nnoremap <leader>lp :lprev<CR>

" JSDoc
nmap <leader>js <plug>(jsdoc)

" Tags
noremap <F8> :TagbarToggle<CR>

" vim-test
nnoremap <silent> <C-t>t :TestNearest<CR>
nnoremap <silent> <C-t>T :TestFile<CR>
nnoremap <silent> <C-t>a :TestSuite<CR>
nnoremap <silent> <C-t>l :TestLast<CR>
nnoremap <silent> <C-t>g :TestVisit<CR>

runtime mappings/common.vim

lua require('init')
