return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        -- Events for lazy loading the plugin
        event = { "BufReadPost", "BufNewFile", "VeryLazy" },
        -- Dependencies for nvim-treesitter
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects", -- For advanced text selection based on tree-sitter nodes
            "nvim-treesitter/nvim-treesitter-context",      -- For showing context of code blocks at the top of the window
            "HiPhish/rainbow-delimiters.nvim",              -- For colorful delimiters (parentheses, brackets, braces)
        },
        ---@type LazyKeys[]
        -- Keymaps for toggling Treesitter Context behavior
        keys = {
            { "<leader>cf", function() require("treesitter-context").setup({ show_all_context = true }) end, desc = "Treesitter Context: Show Full" },
            { "<leader>cp", function() require("treesitter-context").setup({ show_all_context = false }) end, desc = "Treesitter Context: Show Partial" },
        },
        ---@type nvim-treesitter.configs.Config
        -- Options for nvim-treesitter core functionality
        opts = {
            -- A list of parser names to install. "all" can also be used.
            ensure_installed = {
                "c",
                "cpp",
                "lua",
                "vim",
                "vimdoc",
                "query",
                "javascript",
                "typescript",
                "vue",
                "latex",
                "java",
                "python",
                "rust",
                "jsdoc",
                "bash",
                "go",
                "html", -- Combined from all configurations
            },
            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,
            -- Automatically install missing parsers when entering a buffer
            auto_install = true,
            -- List of parsers to ignore during installation (e.g., if causing issues)
            ignore_install = {},
            -- Specific modules to enable (none defined here, but could be 'refactor', 'folding', etc.)
            modules = {},
            -- Indentation settings
            indent = {
                enable = true -- Enable Treesitter-based indentation
            },
            -- Highlighting settings
            highlight = {
                enable = true, -- Enable Treesitter highlighting
                -- Function to disable highlighting for certain languages or large files for performance
                disable = function(lang, buf)
                    -- Disable highlighting for HTML to avoid conflicts or preference
                    if lang == "html" then
                        return true
                    end

                    -- Performance check: Disable highlighting for very large files (e.g., > 100 KB)
                    local max_filesize = 100 * 1024 -- 100 KB threshold
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        vim.notify(
                            "File larger than 100KB, Treesitter highlighting disabled for performance.",
                            vim.log.levels.WARN,
                            { title = "Treesitter" }
                        )
                        return true
                    end
                    return false -- Enable highlighting for other cases
                end,
                -- Additional Vim regex highlighting for specific file types (e.g., Markdown)
                additional_vim_regex_highlighting = { "markdown" },
            },

            -- Incremental selection (text objects) based on Treesitter nodes.
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "gnn",
                    node_incremental = "grn",
                    scope_incremental = "grc",
                    node_decremental = "grm",
                },
            },

            -- Note: 'rainbow' support for nvim-treesitter's built-in functionality is commented out,
            -- as `rainbow-delimiters.nvim` is being used separately.
        },
        -- Main configuration function for nvim-treesitter plugin
        config = function(_, opts)
            -- Apply the opts table to nvim-treesitter's setup
            require("nvim-treesitter.configs").setup(opts)

            --- Custom parser for 'templ' language ---
            -- This custom parser definition needs to be added after nvim-treesitter is set up.
            -- It tells Treesitter how to find and build the 'templ' parser.
            local treesitter_parser_config = require("nvim-treesitter.parsers").get_parser_configs()
            treesitter_parser_config.templ = {
                install_info = {
                    url = "https://github.com/vrischmann/tree-sitter-templ.git",
                    files = { "src/parser.c", "src/scanner.c" },
                    branch = "master",
                },
            }
            -- Register the 'templ' language with Treesitter
            vim.treesitter.language.register("templ", "templ")
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        -- Ensure this plugin loads after nvim-treesitter
        after = "nvim-treesitter",
        -- Configuration for nvim-treesitter-context
        config = function()
            -- IMPORTANT: Use 'treesitter-context' as the module name for require
            require('treesitter-context').setup({
                enable = true,           -- Enable this plugin (Can be enabled/disabled later via commands)
                throttle = true,         -- Throttles updates for performance.
                max_lines = 0,           -- How many lines the context window should span. Values <= 0 mean no limit.
                min_window_height = 0,   -- Minimum editor window height to enable context. Values <= 0 mean no limit.
                line_numbers = true,     -- Show line numbers in the context window.
                multiline_threshold = 20, -- Maximum number of lines to show for a single context entry.
                trim_scope = 'outer',    -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
                mode = 'cursor',         -- Line used to calculate context. Choices: 'cursor', 'topline'
                separator = nil,         -- Separator between context and content. (nil means no explicit separator).
                zindex = 20,             -- The Z-index of the context window.
                on_attach = nil,         -- (fun(buf: integer): boolean) return false to disable attaching for a specific buffer.
                multiwindow = false,     -- Disable multiwindow support (context shown only in the current window).
                show_all_context = true, -- Default to showing all context, keymaps can toggle this.
                -- Patterns to match for TS nodes to display in context
                patterns = {
                    default = { "function", "method", "for", "while", "if", "switch", "case" },
                    rust = { "loop_expression", "impl_item" },
                    typescript = { "class_declaration", "abstract_class_declaration", "else_clause" },
                },
            })
        end
    },

    {
        "HiPhish/rainbow-delimiters.nvim",
        -- Ensure this plugin loads after nvim-treesitter
        after = "nvim-treesitter",
        -- Configuration for rainbow-delimiters.nvim
        config = function()
            -- IMPORTANT: Use 'rainbow-delimiters' as the module name for require
            local rainbow_delimiters = require('rainbow-delimiters')
            vim.g.rainbow_delimiters = {
                -- Strategy for applying rainbow highlighting
                strategy = {
                    -- Global strategy for most filetypes.
                    [''] = rainbow_delimiters.strategy['global'],
                    -- Local strategy specifically for VimL files (e.g., for different parsing needs).
                    vim = rainbow_delimiters.strategy['local'],
                },
                -- Tree-sitter query to identify delimiters for highlighting
                query = {
                    -- Default query for common delimiters (parentheses, brackets, braces).
                    [''] = 'rainbow-delimiters',
                    -- Specific query for Lua blocks (e.g., 'do...end' blocks).
                    lua = 'rainbow-blocks',
                },
                -- List of highlight group names to cycle through for delimiters
                highlight = {
                    'RainbowDelimiterRed',
                    'RainbowDelimiterYellow',
                    'RainbowDelimiterBlue',
                    'RainbowDelimiterOrange',
                    'RainbowDelimiterGreen',
                    'RainbowDelimiterViolet',
                    'RainbowDelimiterCyan',
                },
            }
        end
    },
}
