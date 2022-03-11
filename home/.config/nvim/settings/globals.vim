if empty($XDG_DATA_HOME)
  let g:xdg_data_home = $HOME . '/.local/share/'
else
  let g:xdg_data_home = $XDG_DATA_HOME
endif
