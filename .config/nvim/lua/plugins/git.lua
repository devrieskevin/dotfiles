return {
  {
    "lewis6991/gitsigns.nvim",
    version = "^1.0",
    config = function()
      require("gitsigns").setup({
        on_attach = function(bufnr)
          local gitsigns = require("gitsigns")

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then
              vim.cmd.normal({ "]c", bang = true })
            else
              gitsigns.nav_hunk("next")
            end
          end, { desc = "Navigate to next hunk" })

          map("n", "[c", function()
            if vim.wo.diff then
              vim.cmd.normal({ "[c", bang = true })
            else
              gitsigns.nav_hunk("prev")
            end
          end, { desc = "Navigate to previous hunk" })

          map("n", "<leader>gs", "<Cmd>Gitsigns<CR>", { desc = 'Open Gitsigns options (run ":Gitsigns")' })

          -- Actions
          map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage hunk" })
          map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset hunk" })
          map("v", "<leader>hs", function()
            gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "Stage hunk" })
          map("v", "<leader>hr", function()
            gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "Reset hunk" })
          map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage all hunks in buffer" })
          map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "Unstage hunk" })
          map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset all hunks in buffer" })
          map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview hunk" })
          map("n", "<leader>hb", function()
            gitsigns.blame_line({ full = true })
          end, { desc = "Blame line" })
          map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle current line blame" })
          map("n", "<leader>hd", gitsigns.diffthis, { desc = "Run gitsigns.diffthis" })
          map("n", "<leader>hD", function()
            gitsigns.diffthis("~")
          end, { desc = "Run diffthis with tilde" })
          map("n", "<leader>td", gitsigns.toggle_deleted, { desc = "Toggle deleted" })

          -- Text object
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk text object" })
        end,
      })
    end,
  },
  {
    "tpope/vim-fugitive",
    version = "^3.7",
  },
  {
    "rbong/vim-flog",
    version = "^3.0",
    cmd = { "Flog" },
  },
  {
    "kdheepak/lazygit.nvim",
    branch = "main",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      vim.keymap.set("n", "<leader>gg", ":LazyGitCurrentFile<CR>", {})
    end,
  },
}
