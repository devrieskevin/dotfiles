vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/nvim-tree/nvim-web-devicons",
  {
    src = "https://github.com/stevearc/aerial.nvim",
    version = vim.version.range("^3.1"),
  },
}, { load = true })

require("aerial").setup({
  on_attach = function(bufnr)
    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
  end,
})
vim.keymap.set("n", "<leader>cn", "<cmd>AerialToggle!<CR>")
