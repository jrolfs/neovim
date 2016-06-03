function! GetColorFromHighlightGroup(group, color, env)
  return synIDattr(synIDtrans(hlID(a:group)), a:color, a:env)
endfunction

function! GetBackgroundColors(group)
  return
    \ ' ctermbg=' . GetColorFromHighlightGroup(a:group, 'bg', 'cterm') .
    \ ' guibg=' . GetColorFromHighlightGroup(a:group, 'bg', 'gui')
endfunction

function! GetFrontgroundColors(group)
  return
    \ ' ctermfg=' . GetColorFromHighlightGroup(a:group, 'fg', 'cterm') .
    \ ' guifg=' . GetColorFromHighlightGroup(a:group, 'fg', 'gui')
endfunction

function! NeoMakeDefaults()
  let l:sign_bg = GetBackgroundColors('SignColumn')
  let l:error_sign_fg = GetFrontgroundColors('ErrorMsg')
  let l:warning_sign_fg = GetFrontgroundColors('Todo')
  let l:information_sign_fg = GetFrontgroundColors('Question')
  let l:default_sign_fg = GetFrontgroundColors('ModeMsg')

  execute 'highlight NeomakeErrorDefault'         . l:error_sign_fg . l:sign_bg
  execute 'highlight NeomakeWarningDefault'       . l:warning_sign_fg . l:sign_bg
  execute 'highlight NeomakeInformationalDefault' . l:information_sign_fg . l:sign_bg
  execute 'highlight NeomakeMessageDefault'       . l:default_sign_fg . l:sign_bg
endfunction
