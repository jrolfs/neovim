lua <<EOF
function _G.FlushLuaCache()
  -- Need to do this, otherwise we seem to have a zomby
  -- instance of Lualine continuing to update the status
  require('lualine').hide()

  for name,_ in pairs(package.loaded) do
    -- Dumping the cache for `bit` breaks `nvim-colorizer`... we should
    -- probably be much more discerning about what we clear out here
    if name ~= 'bit' then
      package.loaded[name] = nil
    end
  end
end
EOF

function s:SourceConfiguration()
  lua FlushLuaCache()

  execute 'source ' . stdpath('config') .  '/' . g:init

  lua vim.notify('sourced configuration')
endfunction

noremap <silent> <plug>(configuration-source) :<C-U>call <SID>SourceConfiguration()<CR>

noremap <plug>(configuration-show-highlights) :<C-U>source $VIMRUNTIME/syntax/hitest.vim<CR>
