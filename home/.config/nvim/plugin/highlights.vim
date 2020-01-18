" vint: -ProhibitAutocmdWithNoGroup
scriptencoding utf-8

function s:SetChooseWinHighlights() abort
  execute 'highlight! link ChooseWinLabel Cursor'
  execute 'highlight! link ChooseWinLabelCurrent QuickFixLine'
  execute 'highlight! link ChooseWinLand QuickFixLine'
endfunction

autocmd ColorScheme call <SID>s:SetChooseWinHighlights()
