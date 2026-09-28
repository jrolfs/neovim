local treesitter = require('nvim-treesitter')

treesitter.setup()

local available = {}
for _, language in ipairs(treesitter.get_available()) do available[language] = true end

local function installed(language)
  return vim.list_contains(treesitter.get_installed(), language)
end

-- Every available parser, rather than only the ones whose filetype gets
-- opened, because injected languages never reach the FileType autocmd below.
-- An injection resolves its parser through `resolve_lang` in Neovim's
-- runtime/lua/vim/treesitter/languagetree.lua, which drops the injection when
-- the parser is absent and memoizes that miss for the rest of the session.
-- Installing the parser afterwards revives nothing, not even after `:edit` or
-- a stop/start, so the embedded code reads as plain text until Neovim is
-- restarted. On a fresh machine that silently took out every `# bash` block in
-- the nix config, since the only parsers ever requested were the ones matching
-- a filetype that had been opened.
--
-- The whole set was 287 parsers in 42 seconds and 291MB. install_lang() skips
-- anything already present, so a warm start does no work.
local missing = vim.tbl_filter(
  function(language) return not installed(language) end,
  vim.tbl_keys(available)
)

if #missing > 0 then
  local install = treesitter.install(missing)

  -- The warm-up in modules/home/neovim.nix boots this config headlessly at
  -- switch time and quits as soon as it has been sourced, which would kill the
  -- install mid-flight. Waiting here is what lets a fresh machine arrive with
  -- the parsers already on disk, so no interactive session has to race the
  -- memoized miss above.
  if #vim.api.nvim_list_uis() == 0 then install:wait(600000) end
end

-- `main` dropped `ensure_installed` and `auto_install`, and it no longer turns
-- highlighting on, so that is left to us.
vim.api.nvim_create_autocmd('FileType', {
  callback = function(event)
    local language = vim.treesitter.language.get_lang(event.match)

    if not language or not available[language] then return end

    if installed(language) then
      vim.treesitter.start(event.buf, language)
      return
    end

    -- Reached for a language nvim-treesitter gained since the last start, or
    -- while the bulk install above is still working, so this buffer doesn't
    -- have to wait its turn. Starting on a failed install would throw, hence
    -- the error check.
    treesitter.install(language):await(vim.schedule_wrap(function(error)
      if error or not vim.api.nvim_buf_is_valid(event.buf) then return end
      vim.treesitter.start(event.buf, language)
    end))
  end,
})
