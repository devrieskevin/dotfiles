return {
  "lukas-reineke/indent-blankline.nvim",
  version = "^3.8",
  enabled = false,
  main = "ibl",
  opts = {},
  config = function()
    require("ibl").setup({
      indent = { char = "┊" },
    })
  end,
}
