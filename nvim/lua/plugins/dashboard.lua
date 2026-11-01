return {
  "goolord/alpha-nvim",
  lazy = false,
  priority = 1000,
  cmd = "Alpha",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
      [[                                                ]],
      [[  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
      [[  ████╗  ██║██╔════╝██╔════╝ ██║   ██║██║████╗ ████║ ]],
      [[  ██╔██╗ ██║█████╗  ██║  ███╗██║   ██║██║██╔████╔██║ ]],
      [[  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
      [[  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
      [[  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
      [[                                                ]],
    }

    dashboard.section.buttons.val = {
      dashboard.button("<leader><leader>", "󰈞  Find File", ":FzfLua files<CR>"),
      dashboard.button("<leader>fo", "󰄉  Recent Files", ":FzfLua oldfiles<CR>"),
      dashboard.button("<leader>fg", "󰈬  Live Grep", ":FzfLua live_grep<CR>"),
      dashboard.button("<leader>e", "󰙅  File Explorer", ":NvimTreeToggle<CR>"),
      dashboard.button("<leader>gg", "󰊢  Lazygit", "<cmd>lua _G.toggle_lazygit()<CR>"),
      dashboard.button("q", "󰅚  Quit", ":qa<CR>"),
    }

    local stats = require("lazy").stats()
    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
    dashboard.section.footer.val = {
      "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms",
    }

    dashboard.section.header.opts.hl = "Keyword"
    dashboard.section.buttons.opts.hl = "Function"
    dashboard.section.footer.opts.hl = "Comment"

    dashboard.config.layout = {
      { type = "padding", val = 2 },
      dashboard.section.header,
      { type = "padding", val = 2 },
      dashboard.section.buttons,
      { type = "padding", val = 1 },
      dashboard.section.footer,
    }

    alpha.setup(dashboard.config)

    -- Ensure dashboard is reliably loaded when opening Neovim with no arguments or on a directory
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        local should_open = false
        local old_bufs = vim.api.nvim_list_bufs()

        if vim.fn.argc() == 0 then
          should_open = true
        elseif vim.fn.argc() == 1 then
          local arg = vim.fn.argv(0)
          if vim.fn.isdirectory(arg) == 1 then
            vim.cmd.cd(arg)
            should_open = true
          end
        end

        if should_open then
          pcall(function()
            alpha.start(false)
          end)

          -- Wipe out leftover initial empty buffer and directory buffer so only alpha remains
          local alpha_buf = vim.api.nvim_get_current_buf()
          for _, buf in ipairs(old_bufs) do
            if buf ~= alpha_buf and vim.api.nvim_buf_is_valid(buf) then
              pcall(vim.api.nvim_buf_delete, buf, { force = true })
            end
          end
        end
      end,
    })
  end,
}
