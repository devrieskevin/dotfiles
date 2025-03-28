local function get_python_path(workspace, path)
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

return {
  {
    "williamboman/mason.nvim",
    version = "^1.11",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    version = "^1.32",
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
    },
    config = function()
      local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

      local default_setup = function(server)
        lspconfig[server].setup({
          capabilities = lsp_capabilities,
        })
      end

      -- venv support code taken from: https://github.com/neovim/nvim-lspconfig/issues/500
      local util = require("lspconfig/util")
      local path = util.path

      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "pyright",
          "phpactor",
          "ts_ls",
          "twiggy_language_server",
          "docker_compose_language_service",
          "dockerls",
          "yamlls",
          "cssls",
        },
        handlers = {
          default_setup,
          pyright = function()
            lspconfig.pyright.setup({
              capabilities = lsp_capabilities,
              before_init = function(_, config)
                config.settings.python.pythonPath = get_python_path(config.root_dir, path)
              end,
            })
          end,
          phpactor = function()
            lspconfig.phpactor.setup({
              capabilities = lsp_capabilities,
              init_options = {
                ["language_server_worse_reflection.inlay_hints.enable"] = true,
              },
            })
          end,
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    version = "^1.7",
    config = function()
      vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
      vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
      vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")

      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions",
        callback = function(event)
          local opts = { buffer = event.buf }

          vim.keymap.set("n", "K", function()
            vim.lsp.buf.hover({ border = "single" })
          end, opts)
          vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
          vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
          vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
          vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
          vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
          vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
          vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
          vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
          vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
        end,
      })

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

      vim.diagnostic.config({
        virtual_text = true,
        float = { border = "single" },
      })
    end,
  },
}
