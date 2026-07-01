vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "lua",
  callback = function()
    vim.pack.add({
      { src = "https://github.com/folke/lazydev.nvim", version = vim.version.range("^1.9") },
    }, { load = true })

    require("lazydev").setup({
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    })
  end,
})
