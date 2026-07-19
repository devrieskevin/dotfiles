vim.api.nvim_create_user_command("PackUpdateAll", function(_)
  vim.pack.update()
end, { desc = "Update plugins using vim.pack. TODO: Remove in favour of :packupdate after upgrading to Neovim 0.13+." })
