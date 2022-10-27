lua <<EOF
function _G.FlushLuaCache()
  for name,_ in pairs(package.loaded) do
    package.loaded[name] = nil
  end
end
EOF

function s:SourceConfiguration()
  lua FlushLuaCache()

  execute 'source ' . stdpath('config') .  '/' . g:init

  echom 'sourced configuration'
endfunction

noremap <silent> <plug>(configuration-source) :<C-U>call <SID>SourceConfiguration()<CR>

noremap <plug>(configuration-show-highlights) :<C-U>source $VIMRUNTIME/syntax/hitest.vim<CR>
