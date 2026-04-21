vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    local hl = vim.api.nvim_get_hl(0, { name = 'NormalFloat' })
    if hl.bg then
      local bg = string.format('#%06x', hl.bg)
      vim.api.nvim_set_hl(0, 'OilFloatBorder', { fg = bg, bg = 'NONE' })
      vim.api.nvim_set_hl(0, 'OilFloatTitle', { fg = hl.fg and string.format('#%06x', hl.fg) or '#ffffff', bg = bg })
    end
  end,
})

local oil_border = {
  { "▗", "OilFloatBorder" },  -- top-left: lower-right quadrant
  { "▄", "OilFloatBorder" },  -- top: lower half block
  { "▖", "OilFloatBorder" },  -- top-right: lower-left quadrant
  { "▌", "OilFloatBorder" },  -- right: left half block
  { "▘", "OilFloatBorder" },  -- bottom-right: upper-left quadrant
  { "▀", "OilFloatBorder" },  -- bottom: upper half block
  { "▝", "OilFloatBorder" },  -- bottom-left: upper-right quadrant
  { "▐", "OilFloatBorder" },  -- left: right half block
}

require("oil").setup({
  default_file_explorer = true,
  -- Id is automatically added at the beginning, and name at the end
  -- See :help oil-columns
  columns = {
    "icon",
    "permissions",
    "size",
    "mtime",
  },
  -- Buffer-local options to use for oil buffers
  buf_options = {
    buflisted = false,
    bufhidden = "hide",
  },
  -- Window-local options to use for oil buffers
  win_options = {
    wrap = false,
    signcolumn = "yes",
    cursorcolumn = false,
    foldcolumn = "1",
    spell = false,
    list = true,
    conceallevel = 3,
    concealcursor = "nvic",
  },
  -- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
  delete_to_trash = false,
  -- Skip the confirmation popup for simple operations
  skip_confirm_for_simple_edits = false,
  -- Change this to customize the command used when deleting to trash
  trash_command = "trash-put",
  -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
  prompt_save_on_select_new_entry = true,
  -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
  -- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
  -- Additionally, if it is a string that matches "actions.<name>",
  -- it will use the mapping at require("oil.actions").<name>
  -- Set to `false` to remove a keymap
  -- See :help oil-actions for a list of all available actions
  keymaps = {
    ["g?"] = "actions.show_help",
    ["<CR>"] = "actions.select",
    ["<C-s>"] = "actions.select_vsplit",
    ["<C-h>"] = "actions.select_split",
    ["<C-t>"] = "actions.select_tab",
    ["<C-p>"] = "actions.preview",
    ["<C-c>"] = "actions.close",
    ["<C-l>"] = "actions.refresh",
    ["-"] = "actions.parent",
    ["_"] = "actions.open_cwd",
    ["`"] = "actions.cd",
    ["~"] = "actions.tcd",
    ["gs"] = "actions.change_sort",
    ["gx"] = "actions.open_external",
    ["g."] = "actions.toggle_hidden",
  },
  -- Set to false to disable all of the above keymaps
  use_default_keymaps = true,
  view_options = {
    -- Show files and directories that start with "."
    show_hidden = true,
    -- This function defines what is considered a "hidden" file
    is_hidden_file = function(name, bufnr)
      return vim.startswith(name, ".")
    end,
    -- This function defines what will never be shown, even when `show_hidden` is set
    is_always_hidden = function(name, bufnr)
      return false
    end,
    sort = {
      -- sort order can be "asc" or "desc"
      -- see :help oil-columns to see which columns are sortable
      { "type", "asc" },
      { "name", "asc" },
    },
  },
  -- Configuration for the floating window in oil.open_float
  float = {
    -- Padding around the floating window
    padding = 5,
    max_width = 100,
    max_height = 30,
    border = oil_border,
    win_options = { winblend = 0 },
    override_win_config = function(conf)
      conf.title_pos = "center"
      conf.title_hl = "OilFloatTitle"
      return conf
    end,
    get_win_title = function(winid)
      -- Get the current directory path from the oil buffer
      local oil_buf = vim.api.nvim_win_get_buf(winid)
      local dir_path = require("oil").get_current_dir(oil_buf) or vim.fn.getcwd()

      -- Get the local working directory (lcd or tcd)
      local local_cwd = vim.fn.getcwd(-1, -1) -- Get cwd for current window

      -- Get the home directory
      local home_dir = vim.fn.expand("~")

      -- If the path is under the local working directory, make it relative
      if vim.startswith(dir_path, local_cwd) and dir_path ~= local_cwd then
        -- Create relative path
        local rel_path = dir_path:sub(#local_cwd + 2) -- +2 to account for the trailing slash
        return "   " .. rel_path
        -- If the path is under home directory, replace with ~
      elseif vim.startswith(dir_path, home_dir) then
        local home_relative = dir_path:sub(#home_dir + 1)
        if home_relative == "" then
          return "Oil: ~"
        else
          return "Oil: ~" .. home_relative
        end
      else
        -- Return the absolute path
        return "Oil: " .. dir_path
      end
    end,
  },
  -- Configuration for the actions floating preview window
  preview = {
    -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    -- min_width and max_width can be a single value or a list of mixed integer/float types.
    -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
    max_width = 0.9,
    -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
    min_width = { 40, 0.4 },
    -- optionally define an integer/float for the exact width of the preview window
    width = nil,
    -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    -- min_height and max_height can be a single value or a list of mixed integer/float types.
    -- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
    max_height = 0.9,
    -- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
    min_height = { 5, 0.1 },
    -- optionally define an integer/float for the exact height of the preview window
    height = nil,
    border = "rounded",
    win_options = {
      winblend = 0,
    },
  },
  -- Configuration for the floating progress window
  progress = {
    max_width = 0.9,
    min_width = { 40, 0.4 },
    width = nil,
    max_height = { 10, 0.9 },
    min_height = { 5, 0.1 },
    height = nil,
    border = "rounded",
    minimized_border = "none",
    win_options = {
      winblend = 0,
    },
  },
})
