local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,

        hover_with_actions = true,

        executor = require("rust-tools/executors").termopen,

        on_initialized = nil,

        runnables = {
            use_telescope = true

        },

        hover_actions = {
            border = {
                {"╭", "FloatBorder"}, {"─", "FloatBorder"},
                {"╮", "FloatBorder"}, {"│", "FloatBorder"},
                {"╯", "FloatBorder"}, {"─", "FloatBorder"},
                {"╰", "FloatBorder"}, {"│", "FloatBorder"}
            },

            auto_focus = false
        },

        crate_graph = {
            backend = "x11",
            output = nil,
            pipe = nil,
            full = true,
        }
    },

    server = {
        standalone = true,
    }, -- rust-analyer options

}

require('rust-tools').setup(opts)
