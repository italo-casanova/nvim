
vim.g.mapleader = " "

return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",           -- Specify the exact tag for stability
    dependencies = {
        "nvim-lua/plenary.nvim", -- Required for Telescope
        'nvim-lua/popup.nvim',
        'nvim-telescope/telescope-fzy-native.nvim',
        "nvim-telescope/telescope-media-files.nvim",
    },
    cmd = "Telescope",
    keys = {
        { "<leader>ps",  function() require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") }) end,  desc = "Telescope: Grep string with input" },
        { "<leader>pf",  require('telescope.builtin').find_files,                                                        desc = "Telescope: Find files" },
        { "<leader>pg",  require('telescope.builtin').live_grep,                                                         desc = "Telescope: Live Grep" },
        { "<leader>pb",  require('telescope.builtin').buffers,                                                           desc = "Telescope: Buffers" },
        { "<leader>vh",  require('telescope.builtin').help_tags,                                                         desc = "Telescope: Help Tags" },
        { "<C-p>",       require('telescope.builtin').git_files,                                                         desc = "Telescope: Git files" },     -- Merged keymap
        { "<leader>pws", function() require('telescope.builtin').grep_string({ search = vim.fn.expand("<cword>") }) end, desc = "Telescope: Grep current word" }, -- Merged keymap
        { "<leader>pWs", function() require('telescope.builtin').grep_string({ search = vim.fn.expand("<cWORD>") }) end, desc = "Telescope: Grep current WORD" }, -- Merged keymap
    },
    config = function()
        require('telescope').setup({
            -- You can add global settings for Telescope here.
            -- For example:
            -- defaults = {
            --   layout_strategy = "horizontal",
            --   layout_config = { prompt_position = "top" },
            --   sorting_strategy = "ascending",
            -- },
            -- pickers = {
            --   find_files = {
            --     theme = "ivy",
            --   },
            -- },
        })

        -- The `keys` table above handles all your keymap definitions,
        -- so we don't need to redefine them within the `config` function.
        -- This keeps the `config` cleaner for actual `setup` options.
    end,
}
