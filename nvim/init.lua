-- Disable netrw at the very start (recommended for custom file explorers and dashboard)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Leader keys must be set before loading plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load core settings
require("config.options")
require("config.keymaps")

-- Bootstrap & load lazy.nvim
require("config.lazy")
