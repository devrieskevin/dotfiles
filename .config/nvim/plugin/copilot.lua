vim.api.nvim_create_autocmd("InsertEnter", {
  once = true,
  callback = function()
    vim.pack.add({
      { src = "https://github.com/zbirenbaum/copilot.lua", version = "master" },
    })

    require("copilot").setup({
      suggestion = { enabled = false },
      panel = { enabled = false },
    })
  end,
})

vim.pack.add({
  { src = "https://github.com/zbirenbaum/copilot-cmp", version = "master" },
}, { load = true })

require("copilot_cmp").setup()
