require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` 'if' you depend on 'syntax' being enabled (like 'for' indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
    -- additional_vim_regex_highlighting = false,
  },

  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable 'for' files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },

}

local function bind(op, outer_opts)
    outer_opts = outer_opts or {noremap = true}
    return function(lhs, rhs, opts)
        opts = vim.tbl_extend("force",
            outer_opts,
            opts or {}
        )
        vim.keymap.set(op, lhs, rhs, opts)
    end
end

local nnoremap = bind("n")

function ContextSetup(show_all_context)
    require("treesitter-context").setup({
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        throttle = true, -- Throttles plugin updates (may improve performance)
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        show_all_context = show_all_context,
        patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
            -- For all filetypes
            -- Note that setting an entry here replaces all other patterns for this entry.
            -- By setting the 'default' entry below, you can control which nodes you want to
            -- appear in the context window.
            default = {
                "function",
                "method",
                "for",
                "while",
                "if",
                "switch",
                "case",
            },

            rust = {
                "loop_expression",
                "impl_item",
            },

            typescript = {
                "class_declaration",
                "abstract_class_declaration",
                "else_clause",
            },
        },
    })
end

nnoremap("<leader>cf", function() ContextSetup(true) end)
nnoremap("<leader>cp", function() ContextSetup(false) end)
ContextSetup(false)

require"nvim-treesitter.highlight"
