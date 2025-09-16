return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
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
  end,
}
