return {
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    dependencies = {
      -- LSP Support
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "L3MON4D3/LuaSnip" },
    },
    config = function()
      local lsp = require("lsp-zero").preset({})

      lsp.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        lsp.default_keymaps({ buffer = bufnr })
      end)

      lsp.setup()

      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "pyright",
          "phpactor",
          "tsserver",
          "rust_analyzer",
          "twiggy_language_server",
        },
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "folke/neodev.nvim" },
    },
    config = function()
      -- Found in https://vonheikemen.github.io/devlog/tools/neovim-lsp-client-guide/
      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "Enable inlay hints",
        callback = function(event)
          local id = vim.tbl_get(event, "data", "client_id")
          local client = id and vim.lsp.get_client_by_id(id)
          if client == nil or not client.supports_method("textDocument/inlayHint") then
            return
          end

          vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
        end,
      })

      local lspconfig = require("lspconfig")

      -- venv support code taken from: https://github.com/neovim/nvim-lspconfig/issues/500
      local util = require("lspconfig/util")
      local path = util.path

      local function get_python_path(workspace)
        -- Use activated virtualenv.
        if vim.env.VIRTUAL_ENV then
          return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
        end

        -- Find and use virtualenv in workspace directory.
        for _, pattern in ipairs({ "*", ".*" }) do
          local match = vim.fn.glob(path.join(workspace, pattern, "pyvenv.cfg"))
          if match ~= "" then
            return path.join(path.dirname(match), "bin", "python")
          end
        end

        -- Fallback to system Python.
        return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
      end

      lspconfig.pyright.setup({
        before_init = function(_, config)
          config.settings.python.pythonPath = get_python_path(config.root_dir)
        end,
      })

      lspconfig.phpactor.setup({
        init_options = {
          ["language_server_worse_reflection.inlay_hints.enable"] = true,
        },
      })
    end,
  },
}
