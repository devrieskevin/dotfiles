return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "L3MON4D3/LuaSnip" },
    },
    config = function()
      local cmp = require("cmp")
      local types = require('cmp.types')

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
            -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
          end,
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "copilot" },
        }, {
          { name = "buffer" },
        }),
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = {
            i = function()
              if cmp.visible() then
                cmp.select_next_item({ behavior = types.cmp.SelectBehavior.Select })
              else
                cmp.complete()
              end
            end,
          },
          ["<C-p>"] = {
            i = function()
              if cmp.visible() then
                cmp.select_prev_item({ behavior = types.cmp.SelectBehavior.Select })
              else
                cmp.complete()
              end
            end,
          },
        }),
      })
    end,
  },
}
