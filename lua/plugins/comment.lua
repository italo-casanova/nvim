-- lua/plugins/comment.lua
return {
    "numToStr/Comment.nvim",
    lazy = true,
    ft = {
        "javascript",
        "typescript",
        "lua",
        "c",
        "cpp",
        "python",
        "vim",
        "html",
        "css",
        "gitcommit",
        "markdown",
        "vue",
        "latex",
        "java",
    },
    opts = {}, -- Your current setup is an empty table, indicating default configuration
}
