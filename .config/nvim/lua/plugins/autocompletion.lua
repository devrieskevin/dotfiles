return {
  {
    "tzachar/cmp-ai",
    branch = "main",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      local cmp_ai = require("cmp_ai.config")

      cmp_ai:setup({
        max_lines = 100,
        provider = "Ollama",
        provider_options = {
          model = "granite-code:3b",
          -- Uncomment prompt and suffix for `<fim_*>` based templates
          prompt = function(lines_before, lines_after)
            return lines_before
          end,
          suffix = function(lines_after)
            return lines_after
          end,
          options = {
            stop = { "\n" },
          },
        },
        run_on_every_keystroke = true,
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    version = "^0.2.0",
    dependencies = {
      { "L3MON4D3/LuaSnip" },
      { "tzachar/cmp-ai" },
    },
    config = function()
      local cmp = require("cmp")
      local types = require("cmp.types")

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
          ["<C-y>"] = {
            i = cmp.mapping.confirm({ select = true }),
          },
          ["<C-x>"] = cmp.mapping(
            cmp.mapping.complete({
              config = {
                sources = cmp.config.sources({
                  { name = "copilot" },
                  { name = "cmp_ai" },
                }),
              },
            }),
            { "i" }
          ),
        }),
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })
    end,
  },
}
