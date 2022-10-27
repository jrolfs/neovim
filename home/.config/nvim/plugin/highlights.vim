" vint: -ProhibitAutocmdWithNoGroup
scriptencoding utf-8

function s:highlights()

  "
  " vim-choosewin

  highlight! link ChooseWinLabel Cursor
  highlight! link ChooseWinLabelCurrent QuickFixLine
  highlight! link ChooseWinLand QuickFixLine

  "
  " Transparent Background

  highlight! Normal      ctermbg=none guibg=none
  highlight! LineNr      ctermbg=none guibg=none
  highlight! SignColumn  ctermbg=none guibg=none
  highlight! EndOfBuffer ctermbg=none guibg=none

  highlight! RedSign     ctermbg=none guibg=none
  highlight! OrangeSign  ctermbg=none guibg=none
  highlight! YellowSign  ctermbg=none guibg=none
  highlight! GreenSign   ctermbg=none guibg=none
  highlight! AquaSign    ctermbg=none guibg=none
  highlight! BlueSign    ctermbg=none guibg=none

endfunction

" autocmd ColorScheme,VimEnter * call s:highlights()
