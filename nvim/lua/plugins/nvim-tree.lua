return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle File Explorer (NvimTree)" },
  },
  opts = {
    disable_netrw = true,
    hijack_netrw = true,
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    view = {
      width = 32,
      side = "left",
      relativenumber = false,
    },
    renderer = {
      group_empty = true,
      highlight_git = true,
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },
      },
    },
    filters = {
      dotfiles = false,
      custom = { "^.git$" },
    },
    git = {
      enable = true,
      ignore = false,
    },
  },
}
