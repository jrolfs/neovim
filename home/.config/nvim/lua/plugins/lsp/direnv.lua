--- Per-buffer direnv environments for language servers
--
--  One nvim usually spans a whole repo, and a subdirectory can carry its own
--  .envrc (the kitty kittens in ~/.config/system, for one). So the environment
--  follows the buffer's file rather than nvim's working directory, and a
--  language server inherits whichever environment was loaded when it started.
--
--  An .envrc can also limit which servers start for files beneath it by
--  exporting NVIM_LSP_SERVERS, a space-separated list of config names.
--
--  @see https://github.com/actionshrimp/direnv.nvim
--
local direnv = require('direnv-nvim')

direnv.setup({
  type = 'buffer',
  buffer_setup = {
    -- BufReadPre so the environment is in place before FileType starts the
    -- buffer's servers; BufEnter so it follows the focused buffer after that
    autocmd_event = { 'BufReadPre', 'BufEnter' },
    autocmd_pattern = '*',
  },
  -- Anything but 'status' or 'diff' is silent. The default 'status' notifies
  -- on every buffer switch.
  hook = { msg = 'none' },
})

-- direnv.nvim only runs `direnv export` where it finds an .envrc, so moving
-- from a buffer under one to a buffer under none would keep the old
-- environment. Exporting from the new directory is what unloads it.
--
-- The plugin fires its User events for its own group only, so this has to
-- join that group to hear them.
vim.api.nvim_create_autocmd('User', {
  pattern = { 'DirenvNotFound', 'DirenvBlocked' },
  group = 'direnv-nvim',
  callback = function()
    if vim.env.DIRENV_DIFF == nil then
      return
    end

    local name = vim.api.nvim_buf_get_name(0)
    if vim.fn.filereadable(name) == 1 then
      direnv.hook_(vim.fs.dirname(name))
    end
  end,
})

--- lazy-lsp decides once, at startup and before any .envrc has loaded, whether
--  a server runs from PATH or as `nix shell nixpkgs#<package> --command …`, so
--  a binary that only an environment provides would never be used. Undo the
--  wrapping when that binary is on PATH by the time the server starts.
local unwrap_nix_shell = function(cmd)
  if type(cmd) ~= 'table' or cmd[1] ~= 'nix' then
    return cmd
  end

  local command = vim.fn.index(cmd, '--command')
  if command < 0 then
    return cmd
  end

  local original = vim.list_slice(cmd, command + 2)
  return vim.fn.executable(original[1]) == 1 and original or cmd
end

local server_allowed = function(name)
  local servers = vim.env.NVIM_LSP_SERVERS
  return servers == nil or vim.list_contains(vim.split(servers, '%s+', { trimempty = true }), name)
end

-- Wrapped here rather than in lazy-lsp's configs because every server comes
-- through vim.lsp.start, including the ones oxlint.lua and rustaceanvim start
-- themselves, and lazy-lsp drops any server whose `cmd` is a function
local start = vim.lsp.start

vim.lsp.start = function(config, opts)
  if not server_allowed(config.name) then
    return
  end

  return start(vim.tbl_extend('force', config, { cmd = unwrap_nix_shell(config.cmd) }), opts)
end
