return {
  {
    "zbirenbaum/copilot.lua",
    enabled = false,
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
    enabled = false,
    branch = "master",
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}
