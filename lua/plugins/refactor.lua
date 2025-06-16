return {
  "theprimeagen/refactoring.nvim",
  cmd = "Refactor", -- The main command to start refactoring
  keys = {
    { "<leader>rr", "<cmd>Refactor<CR>", desc = "Refactor: Open Refactor Menu" },
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter", -- Required for parsing code
    "nvim-lua/plenary.nvim",           -- General utility functions
  },
  config = function()
    require("refactoring").setup({
    })
  end,
}
