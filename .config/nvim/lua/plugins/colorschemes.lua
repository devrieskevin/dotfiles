return {
  {
    "folke/tokyonight.nvim",
    config = function()
      local tokyonight = require("tokyonight")

      tokyonight.setup({
        style = "night",
      })

      vim.cmd.colorscheme("tokyonight")
    end,
  },
}
