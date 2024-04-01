return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        pickers = {
          find_files = {
            find_command = {
              "rg",
              "--no-ignore",
              "--hidden",
              "--files",
              "-g",
              "!**/node_modules/*",
              "-g",
              "!**/.git/*",
            },
          },
        },
      })

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})

      -- Set `fd` as an alias for `find_files` again
      builtin.fd = builtin.find_files
    end,
  },
}
