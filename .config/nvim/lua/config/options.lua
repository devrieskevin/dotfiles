vim.opt.termguicolors = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.listchars = { lead = "·" }
vim.opt.list = true

local guicursor_opts = {
  "n-v-c-sm:block-blinkwait175-blinkoff150-blinkon175",
  "i-ci-ve:ver25-blinkwait175-blinkoff150-blinkon175-Cursor/lCursor",
  "r-cr-o:hor20",
}
vim.o.guicursor = table.concat(guicursor_opts, ",")

vim.o.foldenable = false

-- Prefer LSP folding if client supports it
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client:supports_method("textDocument/foldingRange") then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
    end
  end,
})
