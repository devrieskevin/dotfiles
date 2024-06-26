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
              "--hidden",
              "--files",
              "-g",
              "!**/.git/*",
            },
          },
          live_grep = {
            additional_args = {
              "--hidden",
              "-g",
              "!**/.git/*",
            },
          },
        },
      })

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
      vim.keymap.set("n", "<leader>FF", function()
        return builtin.find_files({
          find_command = {
            "rg",
            "--no-ignore",
            "--hidden",
            "--files",
            "-g",
            "!**/.git/*",
          },
        })
      end, {})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
      vim.keymap.set("n", "<leader>fk", builtin.keymaps, {})

      -- Set `fd` as an alias for `find_files` again
      builtin.fd = builtin.find_files
    end,
  },
}
