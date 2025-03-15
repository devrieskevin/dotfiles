return {
  {
    "zbirenbaum/copilot.lua",
    branch = "master",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    branch = "master",
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}
