return {
  {
    "tpope/vim-fugitive",
  },
  {
    "rbong/vim-flog",
    cmd = { "Flog" },
  },
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      vim.keymap.set("n", "<leader>gg", ":LazyGitCurrentFile<CR>", {})
    end,
  },
}
