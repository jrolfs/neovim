local config = require('plugins.lsp.nvim-lspconfig')

--- Manual TypeScript/JavaScript language server setup.
--
--  `lazy-lsp` can no longer start `ts_ls`: recent `nvim-lspconfig` releases
--  define `vim.lsp.config.ts_ls.cmd` as a function, and lazy-lsp's
--  `use_vim_lsp_config` path only knows how to nix-wrap a *table* `cmd`. When
--  it sees a function it logs "ts_ls has dynamic `cmd`, config will not work"
--  and skips the server entirely, so nothing ever attaches. `ts_ls` is
--  excluded in `lazy-lsp.lua` and configured here instead.
--
--  Server preference, resolved per project root:
--    1. Project-local tsgo (@typescript/native-preview) — the native server.
--    2. Project-local typescript-language-server.
--    3. Global tsgo, then typescript-language-server, on PATH.
--    4. nix-provided tsgo (nixpkgs `typescript-go`), via lazy-lsp's shell helper.

local root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' }

--- Resolve the language server to launch for a given project root.
--
--  @param root string Project root directory.
--  @return table|nil `{ name, cmd }` for `vim.lsp.start`, or nil if none found.
local function resolve_server(root)
  local local_tsgo = vim.fs.find('node_modules/.bin/tsgo', { path = root, upward = true })[1]
  if local_tsgo then
    return { name = 'tsgo', cmd = { local_tsgo, '--lsp', '-stdio' } }
  end

  local local_tsls = vim.fs.find('node_modules/.bin/typescript-language-server', { path = root, upward = true })[1]
  if local_tsls then
    return { name = 'ts_ls', cmd = { local_tsls, '--stdio' } }
  end

  if vim.fn.executable('tsgo') == 1 then
    return { name = 'tsgo', cmd = { 'tsgo', '--lsp', '-stdio' } }
  end

  if vim.fn.executable('typescript-language-server') == 1 then
    return { name = 'ts_ls', cmd = { 'typescript-language-server', '--stdio' } }
  end

  -- Last resort: let nix provide tsgo (nixpkgs `typescript-go`), reusing
  -- lazy-lsp's own `in_shell` helper so the wrapping matches this machine (it
  -- decides between `nix shell` and `nix-shell -p` based on whether the flake
  -- registry maps nixpkgs).
  if vim.fn.executable('nix') == 1 or vim.fn.executable('nix-shell') == 1 then
    local ok, helpers = pcall(require, 'lazy-lsp.helpers')
    if ok then
      return {
        name = 'tsgo',
        cmd = helpers.in_shell(
          { 'typescript-go' },
          { 'tsgo', '--lsp', '-stdio' }
        ),
      }
    end
  end

  return nil
end

--- Advertise nvim-cmp's completion capabilities to the server.
local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_ok, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
if cmp_ok then
  capabilities = cmp_lsp.default_capabilities(capabilities)
end

--- tsgo registers a watcher with a `bundled:///libs/**/*` glob that Neovim's
--  glob parser rejects, erroring on every attach. Opt out of dynamic
--  watched-file registration for tsgo to silence it (harmless — the bundled
--  libs never change). ts_ls is unaffected.
local tsgo_capabilities = vim.deepcopy(capabilities)
tsgo_capabilities.workspace = tsgo_capabilities.workspace or {}
tsgo_capabilities.workspace.didChangeWatchedFiles = { dynamicRegistration = false }

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  callback = function(args)
    local fname = vim.api.nvim_buf_get_name(args.buf)
    if fname == '' then
      return
    end

    local root = vim.fs.root(args.buf, root_markers) or vim.fs.dirname(fname)
    if not root then
      return
    end

    local server = resolve_server(root)
    if not server then
      return
    end

    vim.lsp.start({
      name = server.name,
      cmd = server.cmd,
      root_dir = root,
      capabilities = server.name == 'tsgo' and tsgo_capabilities or capabilities,
      on_attach = config.on_attach,
    })
  end,
})
