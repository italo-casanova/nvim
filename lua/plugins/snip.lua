return {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    event = "InsertEnter",
    dependencies = {
        "saadparwaiz1/cmp_luasnip",
    },
    config = function()
        local ls = require("luasnip")
        local types = require("luasnip.util.types")

        ls.config.set_config {
            history = true,
            updateevents = "TextChanged,TextChangedI",
            enable_autosnippets = true,
            ext_opts = {
                [types.choiceNode] = {
                    active = {
                        virt_text = { { " <- Current Choice", "NonTest" } },
                    },
                },
            },
        }

        ls.filetype_extend("javascript", { "jsdoc" })

        -- `<C-s>e`: Expands the current snippet.
        vim.keymap.set({ "i" }, "<C-s>e", function() ls.expand() end, { silent = true, desc = "LuaSnip: Expand snippet" })
        -- `<C-s>;`: Jumps to the next placeholder in a snippet.
        vim.keymap.set({ "i", "s" }, "<C-s>;", function() ls.jump(1) end,
            { silent = true, desc = "LuaSnip: Jump next placeholder" })
        -- `<C-s>,`: Jumps to the previous placeholder in a snippet.
        vim.keymap.set({ "i", "s" }, "<C-s>,", function() ls.jump(-1) end,
            { silent = true, desc = "LuaSnip: Jump previous placeholder" })
        -- `<C-E>`: Cycles through choices in a choice node within a snippet.
        vim.keymap.set({ "i", "s" }, "<C-E>", function()
            if ls.choice_active() then
                ls.change_choice(1)
            end
        end, { silent = true, desc = "LuaSnip: Change choice" })

    end,
}
