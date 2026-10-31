return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      theme = "tokyonight",
      component_separators = "",
      section_separators = "",
      disabled_filetypes = {
        statusline = { "NvimTree", "lazy", "toggleterm", "alpha" },
      },
      globalstatus = true,
    },
    sections = {
      lualine_a = {
        {
          "mode",
          padding = 1,
        },
      },
      lualine_b = {
        { "branch", icon = "" },
        "diff",
        {
          "diagnostics",
          symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " },
        },
      },
      lualine_c = {
        {
          "filename",
          path = 1,
          symbols = { modified = " ●", readonly = " ", unnamed = "[No Name]" },
        },
      },
      lualine_x = {
        {
          function()
            local clients = vim.lsp.get_clients({ bufnr = 0 })
            if next(clients) == nil then
              return ""
            end
            local names = {}
            for _, client in ipairs(clients) do
              table.insert(names, client.name)
            end
            return " " .. table.concat(names, ", ")
          end,
          color = { fg = "#7aa2f7" },
        },
        "filetype",
      },
      lualine_y = { "progress" },
      lualine_z = {
        {
          "location",
        },
      },
    },
  },
}
