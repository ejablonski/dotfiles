return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "helix",
    win = {
      border = "single",
    },
    spec = {
      { "<leader>b", group = "Buffer" },
      { "<leader>c", group = "Code / LSP" },
      { "<leader>f", group = "Find / FZF" },
      { "<leader>g", group = "Git" },
      { "<leader>h", group = "Git Hunk" },
      { "<leader>t", group = "Terminal" },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
