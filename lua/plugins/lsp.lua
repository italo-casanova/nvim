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

local uv = vim.loop

local function read_ltex_language()
    local config_file = vim.fn.getcwd() .. "/ltex-lang.json"
    local file = io.open(config_file, "r")
    if not file then
        return "en"
    end

    local content = file:read("*a")
    file:close()
    local ok, json = pcall(vim.fn.json_decode, content)
    if ok and json and json.language then
        return json.language
    else
        return "en"
    end
end

local project_language = read_ltex_language()

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
            formatters_by_ft = {}
        })

        local sumneko_root_path = "/home/italo/.config/nvim/lua-language-server"
        local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"

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
            view = { entries = "native" },
            formatting = {
                format = lspkind.cmp_format {
                    mode = 'text_symbol',
                    with_text = true,
                    menu = {
                        luasnip = "[SNIP]",
                        nvim_lsp = "[LSP]",
                        nvim_lua = "[API]",
                        path = "[PATH]",
                        buffer = "[BUFF]",
                        gh_issues = "[ISSUES]",
                        ["vim-dadbod-completion"] = "[SQL]",
                        zsh = "[ZSH]",
                    },
                },
            },
            experimental = { ghost_text = true },
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
            signs = { severity = { min = vim.diagnostic.severity.ERROR } },
            underline = { severity = { min = vim.diagnostic.severity.WARN } },
            virtual_text = true,
        })

        capabilities = cmp_lsp.default_capabilities(capabilities)
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        capabilities.offsetEncoding = { 'utf-8', 'utf-16' }

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

        -- ========================================
        -- LSP CONFIGS (DEFERRED START)
        -- ========================================

        -- Lua
        vim.lsp.config["lua_ls"] = {
            cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
            settings = {
                Lua = {
                    runtime = { version = 'LuaJIT', path = vim.split(package.path, ";") },
                    diagnostics = { globals = { 'vim' } },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false,
                    },
                    telemetry = { enable = false },
                },
            },
        }
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "lua",
            callback = function()
                vim.lsp.start(vim.lsp.config["lua_ls"])
            end,
        })

        -- Pyright
        vim.lsp.config["pyright"] = { capabilities = capabilities }
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "python",
            callback = function()
                vim.lsp.start(vim.lsp.config["pyright"])
            end,
        })

        vim.lsp.config["ruff"] = { capabilities = capabilities }
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "python",
            callback = function()
                vim.lsp.start(vim.lsp.config["ruff"])
            end,
        })

        -- LTeX
        vim.lsp.config["ltex"] = {
            capabilities = capabilities,
            cmd = { "/home/italo/.local/bin/ltex-wrapper" },
            settings = {
                ltex = {
                    language = project_language,
                    enabled = true,
                    additionalRules = {
                        enablePickyRules = true,
                        motherTongue = project_language == "es-PE" and "es" or "en",
                    },
                },
            },
        }
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "markdown", "text", "latex", "tex", "rst" },
            callback = function()
                vim.lsp.start(vim.lsp.config["ltex"])
            end,
        })

        -- C / C++
        vim.lsp.config["clangd"] = {
            cmd = {
                "clangd",
                "--offset-encoding=utf-16",
                "--background-index",
                "--suggest-missing-includes",
                "--clang-tidy",
                "--header-insertion=iwyu",
            },
            capabilities = capabilities,
        }
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "c", "cpp", "objc", "objcpp" },
            callback = function()
                vim.lsp.start(vim.lsp.config["clangd"])
            end,
        })

        -- Rust
        local rust_capabilities = capabilities
        rust_capabilities.codeAction = {
            codeActionLiteralSupport = {
                codeActionKind = {
                    valueSet = {
                        "quickfix", "refactor", "refactor.extract",
                        "refactor.inline", "refactor.rewrite",
                        "source", "source.organizeImports"
                    }
                }
            }
        }
        vim.lsp.config["rust_analyzer"] = {
            cmd = { "rustup", "run", "nightly", "rust-analyzer" },
            capabilities = rust_capabilities,
            settings = { ["rust-analyzer"] = { diagnostics = { enable = true } } },
        }
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "rust",
            callback = function()
                vim.lsp.start(vim.lsp.config["rust_analyzer"])
            end,
        })

        -- Java
        vim.lsp.config["jdtls"] = { capabilities = capabilities }
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "java",
            callback = function()
                vim.lsp.start(vim.lsp.config["jdtls"])
            end,
        })

        -- Vue / TS / JS
        vim.lsp.config["vuels"] = { capabilities = capabilities }
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
            callback = function()
                vim.lsp.start(vim.lsp.config["vuels"])
            end,
        })

        vim.lsp.config["ts_ls"] = {
            capabilities = capabilities,
            init_options = {
                plugins = {
                    {
                        name = "@vue/typescript-plugin",
                        location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
                        languages = { "javascript", "typescript", "vue" },
                    },
                },
            },
        }
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "typescript", "javascript", "vue" },
            callback = function()
                vim.lsp.start(vim.lsp.config["ts_ls"])
            end,
        })

        -- LaTeX
        vim.lsp.config["texlab"] = { capabilities = capabilities }
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "tex", "latex" },
            callback = function()
                vim.lsp.start(vim.lsp.config["texlab"])
            end,
        })

        -- ESLint
        vim.lsp.config["eslint"] = {
            capabilities = capabilities,
            root_dir = vim.fs.dirname(vim.fs.find({ ".eslintrc.js", "package.json", ".git" }, { upward = true })[1]),
        }
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "javascript", "typescript", "vue" },
            callback = function()
                vim.lsp.start(vim.lsp.config["eslint"])
            end,
        })

        -- Go
        vim.lsp.config["gopls"] = {
            capabilities = capabilities,
            cmd = { "gopls" },
        }
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "go", "gomod", "gotmpl" },
            callback = function()
                vim.lsp.start(vim.lsp.config["gopls"])
            end,
        })

        -- Docker
        vim.lsp.config["dockerls"] = { capabilities = capabilities }
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "dockerfile" },
            callback = function()
                vim.lsp.start(vim.lsp.config["dockerls"])
            end,
        })

        vim.lsp.config["docker_compose_language_service"] = { capabilities = capabilities }
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "yaml", "yml" },
            callback = function()
                vim.lsp.start(vim.lsp.config["docker_compose_language_service"])
            end,
        })

        -- Solidity
        vim.lsp.config["solidity_ls_nomicfoundation"] = { capabilities = capabilities }
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "solidity" },
            callback = function()
                vim.lsp.start(vim.lsp.config["solidity_ls_nomicfoundation"])
            end,
        })

        vim.lsp.config["solidity_ls"] = { capabilities = capabilities }
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "solidity" },
            callback = function()
                vim.lsp.start(vim.lsp.config["solidity_ls"])
            end,
        })

        -- Terraform
        vim.lsp.config["terraformls"] = { capabilities = capabilities }
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "terraform", "tf", "hcl" },
            callback = function()
                vim.lsp.start(vim.lsp.config["terraformls"])
            end,
        })

        -- ========================================
        -- Autocmds for extra completions
        -- ========================================
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

        vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
            pattern = '*.org',
            callback = function()
                vim.opt.filetype = 'org'
            end
        })

        local function preview_location_callback(_, result)
            if result == nil or vim.tbl_isempty(result) then
                return nil
            end
            lsp_util.preview_location(result[1])
        end

        local util = require('vim.lsp.util')
        local orig = util.apply_text_edits
        function util.apply_text_edits(edits, bufnr, encoding, change_annotations)
            change_annotations = change_annotations or {}
            return orig(edits, bufnr, encoding, change_annotations)
        end
    end
}
