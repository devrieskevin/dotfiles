return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    version = "^3.31",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function()
      local neotree = require("neo-tree")

      neotree.setup({
        window = {
          position = "float",
        },
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
          },
        },
      })

      vim.keymap.set("n", "<leader>nn", "<Cmd>Neotree toggle<CR>")
      vim.keymap.set("n", "<leader>nr", "<Cmd>Neotree reveal<CR>")
      vim.keymap.set("n", "<leader>nb", "<Cmd>Neotree buffers<CR>")
    end,
  },
}
