lua <<EOF
function _G.FlushLuaCache()
  if not vim.g.vscode then
    -- Need to do this, otherwise we seem to have a zomby
    -- instance of Lualine continuing to update the status
    require('lualine').hide()
  end

  for name,_ in pairs(package.loaded) do
    -- Dumping the cache for `bit` breaks `nvim-colorizer`... we should
    -- probably be much more discerning about what we clear out here
    if name ~= 'bit' then
      package.loaded[name] = nil
    end
  end
end

function _G.StopLanguageServers()
  -- Get the list of active LSP clients
  local clients = vim.lsp.get_active_clients()

  -- Iterate through the clients and send shutdown and exit requests
  for _, client in ipairs(clients) do
      client.stop()
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
