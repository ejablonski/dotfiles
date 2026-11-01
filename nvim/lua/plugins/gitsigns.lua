return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "󰍵" },
      topdelete = { text = "‾" },
      changedelete = { text = "▎" },
      untracked = { text = "▎" },
    },
    signs_staged = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "󰍵" },
      topdelete = { text = "‾" },
      changedelete = { text = "▎" },
      untracked = { text = "▎" },
    },
    preview_config = {
      border = "single",
    },
    on_attach = function(bufnr)
      local gs = require("gitsigns")

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
      end

      -- Navigation between hunks
      map("n", "]h", function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return "<Ignore>"
      end, "Next Git hunk")

      map("n", "[h", function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return "<Ignore>"
      end, "Previous Git hunk")

      -- Stage hunk / chunk (Normal & Visual mode)
      map("n", "<leader>hs", gs.stage_hunk, "Stage hunk (chunk)")
      map("n", "<leader>gs", gs.stage_hunk, "Stage hunk (chunk)")
      map("v", "<leader>hs", function()
        gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "Stage selected lines (chunk)")
      map("v", "<leader>gs", function()
        gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "Stage selected lines (chunk)")

      -- Reset / revert hunk / chunk (Normal & Visual mode)
      map("n", "<leader>hr", gs.reset_hunk, "Reset / revert hunk (chunk)")
      map("n", "<leader>gr", gs.reset_hunk, "Reset / revert hunk (chunk)")
      map("v", "<leader>hr", function()
        gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "Reset / revert selected lines (chunk)")
      map("v", "<leader>gr", function()
        gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "Reset / revert selected lines (chunk)")

      -- Whole file / buffer stage & reset
      map("n", "<leader>hS", gs.stage_buffer, "Stage entire buffer (file)")
      map("n", "<leader>gS", gs.stage_buffer, "Stage entire buffer (file)")
      map("n", "<leader>hR", gs.reset_buffer, "Reset / revert entire buffer (file)")
      map("n", "<leader>gR", gs.reset_buffer, "Reset / revert entire buffer (file)")

      -- Undo stage hunk
      map("n", "<leader>hu", gs.undo_stage_hunk, "Undo stage hunk")
      map("n", "<leader>gu", gs.undo_stage_hunk, "Undo stage hunk")

      -- Preview hunk diff in floating popup
      map("n", "<leader>hp", gs.preview_hunk, "Preview hunk diff")
      map("n", "<leader>gp", gs.preview_hunk, "Preview hunk diff")

      -- Blame line
      map("n", "<leader>hb", function()
        gs.blame_line({ full = true })
      end, "Blame line")
      map("n", "<leader>gb", function()
        gs.blame_line({ full = true })
      end, "Blame line")

      -- Diff this (against index)
      map("n", "<leader>hd", gs.diffthis, "Diff against git index")
      map("n", "<leader>gd", gs.diffthis, "Diff against git index")

      -- Text object for inner hunk
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Inner Git hunk")
    end,
  },
}
