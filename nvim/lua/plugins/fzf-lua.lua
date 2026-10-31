return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  keys = {
    { "<leader><leader>", "<cmd>FzfLua files<CR>", desc = "Find Files (fzf-lua)" },
    { "<leader>ff", "<cmd>FzfLua files<CR>", desc = "Find Files" },
    { "<leader>fg", "<cmd>FzfLua live_grep<CR>", desc = "Live Grep" },
    { "<leader>fb", "<cmd>FzfLua buffers<CR>", desc = "Find Buffers" },
    { "<leader>fh", "<cmd>FzfLua help_tags<CR>", desc = "Help Tags" },
    { "<leader>fo", "<cmd>FzfLua oldfiles<CR>", desc = "Recent Files" },
  },
  opts = {
    winopts = {
      border = "single", -- Sharp rectangular borders, no rounded corners
      preview = {
        border = "single",
      },
    },
    fzf_opts = {
      ["--no-scrollbar"] = true,
    },
  },
}
