local opt = vim.opt

-- Line numbers (absolute, non-relative)
opt.number = true
opt.relativenumber = false

-- Tabs & Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Appearance
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.wrap = false

-- Window title (updates terminal title with active file for Sway tabs)
opt.title = true
opt.titlestring = "nvim %t"

-- Scrolling
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Clipboard & History
opt.clipboard = "unnamedplus"
if vim.env.SSH_CONNECTION and not vim.env.DISPLAY and not vim.env.WAYLAND_DISPLAY then
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
      ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
    },
  }
end
opt.undofile = true
opt.updatetime = 250
opt.timeoutlen = 300
