return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = { "n", "v" },
      desc = "Format file (clang-format)",
    },
  },
  opts = function()
    local formatters_by_ft = {}
    if vim.fn.executable("clang-format") == 1 then
      formatters_by_ft.c = { "clang-format" }
      formatters_by_ft.cpp = { "clang-format" }
    end
    if vim.fn.executable("gersemi") == 1 then
      formatters_by_ft.cmake = { "gersemi" }
    end

    return {
      formatters_by_ft = formatters_by_ft,
      format_on_save = {
        timeout_ms = 1000,
        lsp_fallback = true,
      },
    }
  end,
}
