lua <<EOF
function _G.FlushLuaCache()
  if not vim.g.vscode then
    -- Need to do this, otherwise we seem to have a zomby
    -- instance of Lualine continuing to update the status
    require('lualine').hide()
  end

  for name,_ in pairs(package.loaded) do
    if name:match('^plugins%.')
      or name:match('^code%.')
      or name:match('^packages%.')
      or name:match('^interface%.')
      or name == 'utilities'
      or name == 'relative-source'
      -- Entry-point modules, otherwise `lua require('init')` at the end of
      -- init.vim returns the cached module and never re-sources lua/plugins/*.
      or name == 'init'
      or name == 'init-vscode'
      or name == 'init-kitty'
    then
      package.loaded[name] = nil
    end
  end
end

function _G.ReloadStatusline()
  if vim.g.vscode then
    return
  end

  package.loaded['plugins.interface.lualine.evil'] = nil
  require('lualine').setup(require('plugins.interface.lualine.evil'))
  vim.notify('reloaded statusline')
end

function _G.StopLanguageServers()
  -- Get the list of active LSP clients
  local clients = vim.lsp.get_clients()

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

noremap <silent> <plug>(configuration-reload-statusline) :<C-U>lua ReloadStatusline()<CR>

noremap <plug>(configuration-show-highlights) :<C-U>source $VIMRUNTIME/syntax/hitest.vim<CR>
