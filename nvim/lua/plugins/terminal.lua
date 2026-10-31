return {
  "akinsho/toggleterm.nvim",
  version = "*",
  cmd = { "ToggleTerm", "ToggleTermToggleAll", "CTest" },
  keys = {
    { "<C-\\>", desc = "Toggle Terminal" },
    { "<leader>tt", desc = "Toggle Terminal (Float)" },
    { "<leader>tf", desc = "Floating Terminal" },
    { "<leader>th", desc = "Horizontal Terminal" },
    { "<leader>tv", desc = "Vertical Terminal" },
    { "<leader>gg", desc = "Lazygit" },
    { "<leader>tc", desc = "Run CTest" },
  },
  opts = {
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
    open_mapping = [[<C-\>]],
    hide_numbers = true,
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true,
    persist_size = true,
    direction = "float",
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
      border = "single",
      winblend = 0,
    },
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)

    local Terminal = require("toggleterm.terminal").Terminal

    -- Better navigation in terminal mode
    function _G.set_terminal_keymaps()
      local keymap_opts = { buffer = 0 }
      vim.keymap.set("t", "<esc><esc>", [[<C-\><C-n>]], keymap_opts)
      vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], keymap_opts)
      vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], keymap_opts)
      vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], keymap_opts)
      vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], keymap_opts)
    end

    vim.api.nvim_create_autocmd("TermOpen", {
      pattern = "term://*",
      callback = function()
        set_terminal_keymaps()
      end,
    })

    -- Lazygit floating terminal
    local lazygit = Terminal:new({
      cmd = "lazygit",
      dir = "git_dir",
      direction = "float",
      float_opts = {
        border = "single",
      },
      on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
      end,
    })

    local function toggle_lazygit()
      lazygit:toggle()
    end

    vim.keymap.set("n", "<leader>gg", toggle_lazygit, { desc = "Toggle Lazygit" })

    -- Terminal toggle mappings
    local float_term = Terminal:new({ direction = "float" })
    local horiz_term = Terminal:new({ direction = "horizontal" })
    local vert_term = Terminal:new({ direction = "vertical" })

    vim.keymap.set("n", "<leader>tt", function() float_term:toggle() end, { desc = "Toggle Float Terminal" })
    vim.keymap.set("n", "<leader>tf", function() float_term:toggle() end, { desc = "Toggle Float Terminal" })
    vim.keymap.set("n", "<leader>th", function() horiz_term:toggle() end, { desc = "Toggle Horizontal Terminal" })
    vim.keymap.set("n", "<leader>tv", function() vert_term:toggle() end, { desc = "Toggle Vertical Terminal" })

    -- CTest runner
    local function run_ctest()
      local cmd = "ctest --output-on-failure"
      if vim.fn.isdirectory(vim.fn.getcwd() .. "/build") == 1 then
        cmd = "ctest --test-dir build --output-on-failure"
      end

      local ctest_term = Terminal:new({
        cmd = cmd,
        direction = "float",
        close_on_exit = false,
        float_opts = {
          border = "single",
        },
        on_open = function(term)
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
        end,
      })
      ctest_term:toggle()
    end

    vim.keymap.set("n", "<leader>tc", run_ctest, { desc = "Run CTest" })
    vim.api.nvim_create_user_command("CTest", run_ctest, { desc = "Run CTest in terminal float" })
  end,
}
