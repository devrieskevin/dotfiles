vim.pack.add({
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
}, { load = true })

local harpoon = require("harpoon")

harpoon:setup()

vim.keymap.set("n", "<leader>qa", function()
  harpoon:list():add()
end)

vim.keymap.set("n", "<leader>qq", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)

vim.keymap.set("n", "<leader>qc", function()
  harpoon:list():clear()
end)
