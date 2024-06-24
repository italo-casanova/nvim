vim.opt.completeopt = { "menu", "menuone", "noselect" }


function CreateNoremap(type, opts)
    return function(lhs, rhs, bufnr)
        bufnr = bufnr or 0
        vim.keymap.set(bufnr, type, lhs, rhs, opts)
    end
end

Nnoremap = CreateNoremap("n", { noremap = true, silent = true })
Inoremap = CreateNoremap("i", { noremap = true, silent = true })

local sumneko_root_path = "/home/italo/.config/nvim/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})

local lspconfig = require 'lspconfig'
local on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    local opts = { noremap = true, silent = true }
    local bufopts = { noremap = true, silent = true }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)


    vim.keymap.set('n', '<leader>l', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.keymap.set('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    vim.keymap.set('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    vim.keymap.set('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.keymap.set('n', '<leader>to', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
    vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.offsetEncoding = { 'utf-8', 'utf-16' }


local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")
local cmp = require 'cmp'

require("luasnip.loaders.from_lua").load({ path = "~/.config/nvim/lua/plugins_conf/snippets" })



local lspkind = require("lspkind")
require('lspkind').init({
    mode = 'symbol_text',
})

cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = {
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
    },

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
                cmp_tabnine = "[TN]",
                gh_issues = "[ISSUES]",
            },
        },
    },

    experimental = {

        ghost_text = true,
    },

    sources = {

        { name = "luasnip" },
        { name = "nvim_lua" },
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "buffer" },
    },
})

-- lspconfig.ccls.setup({
--   on_attach = on_attach,
--   root_pattern = { 'compile_commands.json', '.ccls', '.git' },
--   init_options = {
--     compilationDatabaseDirectory = "build";
--     index = {
--       threads = 0;
--     };
--     clang = {
--       excludeArgs = { "-frounding-math" };
--     };
--     offset_encoding = { "utf-16" }
--   }
-- })

local function preview_location_callback(_, result)
    if result == nil or vim.tbl_isempty(result) then
        return nil
    end
    vim.lsp.util.preview_location(result[1])
end

function PeekDefinition()
    local params = vim.lsp.util.make_position_params()
    return vim.lsp.buf_request(0, 'textDocument/definition', params, preview_location_callback)
end

function PeekDeclaration()
    local params = vim.lsp.util.make_position_params()
    return vim.lsp.buf_request(0, 'textDocument/declaration', params, preview_location_callback)
end

require 'lspconfig'.lua_ls.setup {
    on_attach = on_attach,
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

_ = vim.cmd [[
  augroup DadbodSql
    au!
    autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer { sources = { { name = 'vim-dadbod-completion' } } }
  augroup END
]]

_ = vim.cmd [[
  augroup CmpZsh
    au!
    autocmd Filetype zsh lua require'cmp'.setup.buffer { sources = { { name = "zsh" }, } }
  augroup END
]]
vim.cmd [[ autocmd BufRead,BufNewFile *.org set filetype=org ]]

require('lspconfig').ltex.setup {
    capabilities = capabilities,
    on_attach = on_attach
}

require 'lspconfig'.jedi_language_server.setup {}
-- require("lspconfig").jedi_language_server.setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
--   filetype = {"python"},
-- })
require("lspconfig").cssls.setup({
    capabilities = capabilities,
    on_attach = on_attach
})
require 'lspconfig'.clangd.setup {
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
    on_attach = on_attach
}
require 'lspconfig'.tsserver.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
        local ts_utils = require("nvim-lsp-ts-utils")
        ts_utils.setup({})
        ts_utils.setup_client(client)
    end,
})

local rust_capabilities = capabilities

rust_capabilities.codeAction = {

    codeActionLiteralSupport = {
        codeActionKind = {
            valueSet = { "quickfix", "refactor", "refactor.extract", "refactor.inline", "refactor.rewrite", "source", "source.organizeImports" }
        }
    }
}
require 'lspconfig'.rust_analyzer.setup({
    cmd = { "rustup", "run", "nightly", "rust-analyzer" },
    capabilities = rust_capabilities,
    on_attach = on_attach,
    settings = {
        ['rust-analyzer'] = {
            diagnostics = {
                enable = true,
            }
        }
    },
    root_dir = lspconfig.util.root_pattern("Cargo.toml", "rust-project.json", ".git"),
})
require 'lspconfig'.jdtls.setup {
    capabilities = capabilities,
    on_attach = on_attach
}

require 'lspconfig'.volar.setup {
  filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'},
  capabilities = capabilities, on_attach = on_attach

}

require 'lspconfig'.vuels.setup {
  filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'},
  capabilities = capabilities, on_attach = on_attach
}

require 'lspconfig'.texlab.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

vim.cmd [[ autocmd BufRead,BufNewFile *.org set filetype=org ]]
-- require'lspconfig'.ltex.setup{}

-- require'lspconfig'.html.setup {
--   capabilities = capabilities,
-- }
-- local servers = {'sumneko_lua', 'clangd', 'ccls', 'pylsp', 'pyright', 'tsserver'}

require("lspconfig").clangd.setup({ capabilities = capabilities, on_attach = on_attach })
require 'lspconfig'.eslint.setup {
    { capabilities = capabilities },
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
        })
    end,
    root_dir = lspconfig.util.root_pattern(".git"),

}

--lua/code_action_utils.lua
-- local servers = {'clangd' , 'jedi_language_server', 'tsserver', 'jdtls'}
require('lspkind').init()

local lsp_util = vim.lsp.util


require 'lspconfig'.gopls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gotmtl" },
    root_dir = lspconfig.util.root_pattern(".git", "go.mod", ".git"),
}
require 'lspconfig'.csharp_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

require 'lspconfig'.dockerls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

require 'lspconfig'.docker_compose_language_service.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
require'lspconfig'.solidity_ls_nomicfoundation.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}
require'lspconfig'.solidity_ls.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}


-- local servers = { 'ccls', 'clangd', 'jedi_language_server', 'tsserver', 'jdtls', 'vuels', 'ltex', 'texlab', 'eslint' }
local servers = { 'clangd', 'jedi_language_server', 'tsserver', 'jdtls', 'vuels', 'ltex', 'texlab', 'eslint',
    'rust_analyzer', 'csharp_ls', 'docker_compose_language_service', 'dockerls', 'solidity_ls_nomicfoundation',
    'solidity_ls'}
-- local servers = { 'ccls', 'clangd' , 'jedi_language_server', 'tsserver', 'jdtls', 'vuels', 'ltex', 'texlab'}
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        capabilities = capabilities,
    }
end



local M = {}


function M.code_action_listener()
    local context = { diagnostics = vim.lsp.diagnostic.get_line_diagnostics() }
    local params = lsp_util.make_range_params()
    params.context = context
    vim.lsp.buf_request(0, 'textDocument/codeAction', params, function(err, _, result)
    end)
end

vim.lsp.handlers["textDocument/definition"] = function(_, result)
    if not result or vim.tbl_isempty(result) then
        print "[LSP] Could not find definition"
        return
    end

    if vim.tbl_islist(result) then
        vim.lsp.util.jump_to_location(result[1], "utf-8")
    else
        vim.lsp.util.jump_to_location(result, "utf-8")
    end
end

vim.lsp.handlers["textDocument/declaration"] = function(_, result)
    if not result or vim.tbl_isempty(result) then
        print "[LSP] Could not find definition"
        return
    end

    if vim.tbl_islist(result) then
        vim.lsp.util.jump_to_location(result[1], "utf-8")
    else
        vim.lsp.util.jump_to_location(result, "utf-8")
    end
end

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.handlers["textDocument/publishDiagnostics"], {
        signs = {
            severity_limit = "Error",
        },
        underline = {
            severity_limit = "Warning",
        },
        virtual_text = true,
    })

return M
