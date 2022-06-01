vim.opt.completeopt = { "menu", "menuone", "noselect" }

function CreateNoremap(type, opts)
	return function(lhs, rhs, bufnr)
		bufnr = bufnr or 0
		vim.api.nvim_buf_set_keymap(bufnr, type, lhs, rhs, opts)
	end
end


Nnoremap = CreateNoremap("n", { noremap = true, silent = true })
Inoremap = CreateNoremap("i", { noremap = true, silent = true})

function CreateNoremap(type, opts)
	return function(lhs, rhs, bufnr)
		bufnr = bufnr or 0
		vim.api.nvim_buf_set_keymap(bufnr, type, lhs, rhs, opts)
	end
end
-- sumneku-lua local runtime_path = vim.split(package.path, ';')
local sumneko_root_path = "/home/italo/.config/nvim/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"

local lspconfig = require 'lspconfig'
local on_attach = function(_, bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-l>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>to', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

local luasnip = require("luasnip")
local cmp = require'cmp'

require('lspkind').init()
local source_mapping = {
    buffer = "[BUFF]",
    nvim_lsp = "[LSP]",
    nvim_lua = "[API]",
    path = "[PATH]",
    luasnip = "[SNIP]",
    cmp_tabnine = "[TN]",
}

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

      ["<tab>"] = cmp.config.disable,
      ['<c-y>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,

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
        with_text = true,
        menu = {
          buffer = "[BUFF]",
          nvim_lsp = "[LSP]",
          nvim_lua = "[API]",
          path = "[PATH]",
          luasnip = "[SNIP]",
          cmp_tabnine = "[TN]",
          gh_issues = "[ISSUES]",
        },
      },
    },

  experimental = {

      ghost_text = true,
    },

	sources = {

		{ name = "nvim_lsp" },
        { name = "path" },
        { name = "nvim_lua" },
        { name = "luasnip" },
		{ name = "buffer" },
	},
})

local function config(_config)
	return vim.tbl_deep_extend("force", {
        on_attach = function ()
            Nnoremap("gd", ":lua vim.lsp.buf.definition()<CR>")
			Nnoremap("K", ":lua vim.lsp.buf.hover()<CR>")
			Nnoremap("<leader>vws", ":lua vim.lsp.buf.workspace_symbol()<CR>")
			Nnoremap("<leader>vd", ":lua vim.diagnostic.open_float()<CR>")
			Nnoremap("[d", ":lua vim.lsp.diagnostic.goto_next()<CR>")
			Nnoremap("]d", ":lua vim.lsp.diagnostic.goto_prev()<CR>")
			Nnoremap("<leader>vca", ":lua vim.lsp.buf.code_action()<CR>")
			Nnoremap("<leader>vrr", ":lua vim.lsp.buf.references()<CR>")
			Nnoremap("<leader>vrn", ":lua vim.lsp.buf.rename()<CR>")
			Inoremap("<C-h>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
		end,
	}, _config or {})
end

-- set up language client

lspconfig.ccls.setup(config({
  init_options = {
    compilationDatabaseDirectory = "build";
    index = {
      threads = 0;
    };
    clang = {
      excludeArgs = { "-frounding-math"} ;
    };
  }
  }))

require'lspconfig'.sumneko_lua.setup {
  cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ";"),
      },
      diagnostics = {
        globals = {'vim'},
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

-- require'lspconfig'.pylsp.setup{}
-- require('lspconfig').pyright.setup{config()}
require("lspconfig").jedi_language_server.setup(config())
require("lspconfig").cssls.setup{config()}
require'lspconfig'.clangd.setup{
 cmd = { "clangd", "--background-index" },
  filetypes = { "c", "cpp", "objc", "objcpp" }
}
require'lspconfig'.tsserver.setup({
 on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
        local ts_utils = require("nvim-lsp-ts-utils")
        ts_utils.setup({})
        ts_utils.setup_client(client)
    end,
  })
require'lspconfig'.rust_analyzer.setup(config({
	cmd = { "rustup", "run", "nightly", "rust-analyzer" },
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      ["rust-analyzer"] = {
    --     checkOnSave = {
    --       command = "clippy"
    --       },
    --       assist = {
    --         importGranularity = "module",
    --         importPrefix = "by_self",
    --       },
          cargo = {loadOutDirsFromCheck = true},
          procMacro = {enable = true},
        },
      },
    }))
require'lspconfig'.jdtls.setup{
  capabilities = capabilities,
}

-- require'lspconfig'.html.setup {
--   capabilities = capabilities,
-- }
-- local servers = {'sumneko_lua', 'clangd', 'ccls', 'pylsp', 'pyright', 'tsserver'}

-- for _, lsp in ipairs(servers) do
--   lspconfig[lsp].setup{capabilities = capabilities,}
-- end

--lua/code_action_utils.lua
local servers = { 'ccls', 'clangd' , 'jedi_language_server', 'tsserver', 'jdtls'}
-- local servers = {'clangd' , 'jedi_language_server', 'tsserver', 'jdtls'}
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    capabilities = capabilities,
  }
end

local M = {}

local lsp_util = vim.lsp.util

function M.code_action_listener()
  local context = { diagnostics = vim.lsp.diagnostic.get_line_diagnostics() }
  local params = lsp_util.make_range_params()
  params.context = context
  vim.lsp.buf_request(0, 'textDocument/codeAction', params, function(err, _, result)
    -- do something with result - e.g. check if empty and show some indication such as a sign
  end)
end

return M
