require("catppuccin").setup {
  flavour = "frappe",
  transparent_background = true
}

vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = function()
    if vim.g.colors_name == 'catppuccin' then
      vim.cmd("Catppuccin " .. (vim.v.option_new == "light" and "latte" or "frappe"))
    end
  end,
})
