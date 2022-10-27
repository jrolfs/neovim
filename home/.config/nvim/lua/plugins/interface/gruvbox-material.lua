vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "colorscheme",
  callback = function()
    if vim.v.option_new == 'gruvbox-material' then
      vim.api.nvim_set_var('gruvbox_material_background', 'soft')
      vim.api.nvim_set_var('gruvbox_material_transparent_background', 1)
      vim.api.nvim_set_var('gruvbox_material_enable_italic', 1)
      vim.api.nvim_set_var('gruvbox_material_enable_bold', 1)
    end
  end,
})
