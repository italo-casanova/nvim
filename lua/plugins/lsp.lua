local root_files = {
    '.luarc.json',
    '.luarc.jsonc',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
    '.git',
}

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "stevearc/conform.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
        'nvim-lua/lsp_extensions.nvim',
        'nvim-lua/lsp-status.nvim',
        'onsails/lspkind-nvim',
        'mfussenegger/nvim-jdtls'
    },

    config = function()
        require 'lsp_extensions'.inlay_hints { prefix = '', highlight = "Comment", enabled = { "TypeHint", "ChainingHint", "ParameterHint" } }
        require("conform").setup({
            formatters_by_ft = {
            }
        })
        local sumneko_root_path = "/home/italo/.config/nvim/lua-language-server"
        local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"
        local lspconfig = require 'lspconfig'
        local luasnip = require("luasnip")
        local lsp_util = vim.lsp.util
        local lspkind = require("lspkind")

        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("fidget").setup({})

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),

                ['<Tab>'] = nil,
                ['<S-Tab>'] = nil,
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-e>"] = cmp.mapping.close(),
                ["<c-y>"] = cmp.mapping(
                    cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Insert,
                        select = true,
                    },
                    { "i", "c" }
                ),

                ["<c-space>"] = cmp.mapping {
                    i = cmp.mapping.complete(),
                    c = function(_)
                        if cmp.visible() then
                            if not cmp.confirm { select = true } then
                                return
                            end
                        else
                            cmp.complete()
                        end
                    end,
                },

            }),
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            view = {
                entries = "native"
            },
            formatting = {
                format = lspkind.cmp_format {
                    mode = 'text_symbol',
                    with_text = true,
                    menu = {
                        luasnip = "[SNIP]",
                        nvim_lsp = "[LSP]",
                        nvim_lua = "[API]",
                        buffer = "[BUFF]",
                        path = "[PATH]",
                        gh_issues = "[ISSUES]",
                        ["vim-dadbod-completion"] = "[SQL]", -- For Dadbod
                        zsh = "[ZSH]",                       -- For Zsh
                    },
                },
            },
            experimental = {
                ghost_text = true,
            },
            sources = cmp.config.sources({
                { name = "copilot", group_index = 2 },
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
            }, {
                { name = 'buffer' },
            })
        })


        vim.diagnostic.config({
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
            signs = {
                severity = { min = vim.diagnostic.severity.ERROR }
            },
            underline = {
                severity = { min = vim.diagnostic.severity.WARN }
            },
            virtual_text = true,
        })

        -- luasnip.loaders.from_lua.load({ path = "~/.config/nvim/lua/plugins_conf/snippets" })

        -- LSP Capabilities
        capabilities = cmp_lsp.default_capabilities(capabilities)
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        capabilities.offsetEncoding = { 'utf-8', 'utf-16' }

        -- Custom LSP handlers
        vim.lsp.handlers["textDocument/definition"] = function(_, result)
            if not result or vim.tbl_isempty(result) then
                print "[LSP] Could not find definition"
                return
            end
            if vim.tbl_islist(result) then
                lsp_util.jump_to_location(result[1], "utf-8")
            else
                lsp_util.jump_to_location(result, "utf-8")
            end
        end

        vim.lsp.handlers["textDocument/declaration"] = function(_, result)
            if not result or vim.tbl_isempty(result) then
                print "[LSP] Could not find declaration"
                return
            end
            if vim.tbl_islist(result) then
                lsp_util.jump_to_location(result[1], "utf-8")
            else
                lsp_util.jump_to_location(result, "utf-8")
            end
        end
        -- Setup individual LSP servers
        lspconfig.lua_ls.setup {
            cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
            settings = {
                Lua = {
                    runtime = {
                        version = 'LuaJIT',
                        path = vim.split(package.path, ";"),
                    },
                    diagnostics = {
                        globals = { 'vim' },
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false,
                    },
                    telemetry = {
                        enable = false,
                    },
                },
            },
        }

        lspconfig.ltex.setup {
            capabilities = capabilities,
        }

        lspconfig.pyright.setup({
            capabilities = capabilities,
            filetype = { "python" },
        })
        lspconfig.ruff.setup({
            capabilities = capabilities,
        })

        lspconfig.clangd.setup({
            cmd = {
                "clangd --offset-encoding=utf-16",
                "--background-index",
                "--suggest-missing-includes",
                "--clang-tidy",
                "--header-insertion=iwyu",
            },
            filetypes = { "c", "cpp", "objc", "objcpp" },
            offsetEncoding = { 'utf-8', 'utf-16' },
            capabilities = capabilities,
            root_dir = lspconfig.util.root_pattern('compile_commands.json', '.git'),
        })

        -- Rust Analyzer with custom capabilities
        local rust_capabilities = capabilities
        rust_capabilities.codeAction = {
            codeActionLiteralSupport = {
                codeActionKind = {
                    valueSet = { "quickfix", "refactor", "refactor.extract", "refactor.inline", "refactor.rewrite", "source", "source.organizeImports" }
                }
            }
        }
        lspconfig.rust_analyzer.setup({
            cmd = { "rustup", "run", "nightly", "rust-analyzer" },
            capabilities = rust_capabilities,
            settings = {
                ['rust-analyzer'] = {
                    diagnostics = {
                        enable = true,
                    }
                }
            },
            root_dir = lspconfig.util.root_pattern("Cargo.toml", "rust-project.json", ".git"),
        })

        lspconfig.jdtls.setup {
            capabilities = capabilities,
        }

        lspconfig.vuels.setup {
            filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
            capabilities = capabilities,
        }

        lspconfig.ts_ls.setup({
            init_options = {
                plugins = {
                    {
                        name = "@vue/typescript-plugin",
                        location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
                        languages = { "javascript", "typescript", "vue" },
                    },
                },
            },
            filetypes = {
                "javascript",
                "typescript",
                "vue",
            },
            capabilities = capabilities,
        })


        lspconfig.texlab.setup {
            capabilities = capabilities,
        }

        lspconfig.eslint.setup {
            capabilities = capabilities,
            root_dir = lspconfig.util.root_pattern('.eslintrc.js', 'package.json', '.git'),
        }

        lspconfig.gopls.setup {
            capabilities = capabilities,
            cmd = { "gopls" },
            filetypes = { "go", "gomod", "gotmpl" }, -- Corrected gotmtl to gotmpl
            root_dir = lspconfig.util.root_pattern(".git", "go.mod"),
        }


        lspconfig.dockerls.setup {
            capabilities = capabilities,
        }

        lspconfig.docker_compose_language_service.setup {
            capabilities = capabilities,
        }

        lspconfig.solidity_ls_nomicfoundation.setup {
            capabilities = capabilities,
        }

        lspconfig.solidity_ls.setup {
            capabilities = capabilities,
        }

        lspconfig.terraformls.setup {
            capabilities = capabilities,
        }

        -- Autocmds for specific filetypes and completion sources
        vim.api.nvim_create_augroup('DadbodSql', { clear = true })
        vim.api.nvim_create_autocmd('FileType', {
            group = 'DadbodSql',
            pattern = 'sql,mysql,plsql',
            callback = function()
                cmp.setup.buffer { sources = { { name = 'vim-dadbod-completion' } } }
            end
        })

        vim.api.nvim_create_augroup('CmpZsh', { clear = true })
        vim.api.nvim_create_autocmd('FileType', {
            group = 'CmpZsh',
            pattern = 'zsh',
            callback = function()
                cmp.setup.buffer { sources = { { name = "zsh" } } }
            end
        })

        vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, { -- <--- FIX IS HERE
            pattern = '*.org',
            callback = function()
                vim.opt.filetype = 'org'
            end
        })

        -- Moved `PeekDefinition` and `PeekDeclaration` inside config if they are only used there.
        -- If they are meant to be global functions, they should be defined outside the return block.
        local function preview_location_callback(_, result)
            if result == nil or vim.tbl_isempty(result) then
                return nil
            end
            lsp_util.preview_location(result[1])
        end
    end
}
