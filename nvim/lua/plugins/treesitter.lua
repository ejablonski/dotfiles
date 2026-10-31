return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local ts = require("nvim-treesitter")
    ts.setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
    })

    -- Enable Treesitter highlighting and indent on FileType
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "c",
        "cpp",
        "cmake",
        "lua",
        "vim",
        "vimdoc",
        "bash",
        "markdown",
        "json",
        "yaml",
      },
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })
  end,
}
