local ls = require"luasnip"
-- local types = require"luasnip.util.types"
--
-- Set <space> as leader key
vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', { noremap = true, silent = true})
vim.g.mapleader = ' '

-- toggle hlsearch
vim.api.nvim_set_keymap('n' , '<leader>h', ':set hlsearch!<CR>', { noremap = true, silent = true })

-- file manager
vim.api.nvim_set_keymap('n' , '<c-n>', ':Lexplore<CR>', { noremap = true, silent = true })

-- terminal
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true})

--better  split navigation
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', {noremap = true, silent = true})

vim.api.nvim_set_keymap('t', '<C-h>', '<C-w>h', {noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<C-j>', '<C-w>j', {noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<C-k>', '<C-w>k', {noremap = true, silent = true})
vim.api.nvim_set_keymap('t', '<C-l>', '<C-w>l', {noremap = true, silent = true})

-- open terminal
vim.api.nvim_set_keymap('n', '<leader>tb', ':split<CR>:resize 10<CR>:ter<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>tv', ':vsplit<CR>:vertical resize - 20<CR>:ter<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-t>', ':tabnew<CR>:terminal<CR>', {noremap = true, silent = true})


vim.api.nvim_set_keymap('n', '<leader>tn', ':tabnew<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gcc', ':w<CR>:!g++ -o  %:r % -std=c++17<Enter>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>py', ':w<CR>:!python3 %<CR>', {noremap = true, silent = true})


-- resize buffer
vim.api.nvim_set_keymap('n', '<leader>+', ':vertical resize +5<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>-', ':vertical resize -5<CR>', { noremap = true, silent = true})

-- Indenting
vim.api.nvim_set_keymap('v', ',', '<gv', { noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '.', '>gv', { noremap = true, silent = true})

-- show hover doc

vim.api.nvim_set_keymap('n', '<F8>', ':TagbarToggle<CR>', { noremap = true, silent = true})

vim.api.nvim_set_keymap('n', '<leader>j',':m .+1<CR>==', {noremap = true, silent = true} )
vim.api.nvim_set_keymap('n', '<leader>k',':m .-2<CR>==', {noremap = true, silent = true} )
vim.api.nvim_set_keymap('v', 'J', ":m '>+1<CR>gv=gv", {noremap = true, silent = true} )
vim.api.nvim_set_keymap('v', 'K', ":m '<-2<CR>gv=gv", {noremap = true, silent = true} )

vim.api.nvim_set_keymap('n','<leader>s', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>', {noremap = true, silent = true})

-- Debug
vim.api.nvim_set_keymap('n', '<leader>bt', ':lua require"dap".toggle_breakpoint()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>sb', ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>td', ':lua require"dap".terminate()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>cb', ':lua require"dap".clear_breakpoints()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<A-k>', ':lua require"dap".step_out()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', "<A-l>", ':lua require"dap".step_into()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<A-h>', ':lua require"dap".continue()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<A-j>', ':lua require"dap".step_over()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>dn', ':lua require"dap".run_to_cursor()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>dk', ':lua require"dap".up()<CR>zz', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>dj', ':lua require"dap".down()<CR>zz', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>dr', ':lua require"dap".repl.toggle({}, "vsplit")<CR><C-w>l', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>de', ':lua require"dap".set_exception_breakpoints({"all"})<CR>', {noremap = true, silent = true})

-- telescope
vim.api.nvim_set_keymap("n", "<leader>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", {noremap = true, silent = true}
)
vim.api.nvim_set_keymap("n", "<leader>F", "<cmd>Telescope find_files<cr>", {noremap = true, silent = true})

vim.api.nvim_set_keymap('n', '<leader>vv', '<A-v>', {noremap = true, silent = true})

vim.api.nvim_set_keymap("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/lua/plugins_conf/luaSnip.lua<CR>", {})

vim.api.nvim_set_keymap("n", "<leader>cp", "<cmd>:! pdflatex %<CR><CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>rp", "<cmd>:! zathura $(echo %\\| sed 's/tex$/pdf/') & disown<CR><CR>", {noremap = true})

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
keymap("i", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
keymap("s", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
keymap("i", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
keymap("s", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)

vim.keymap.set({"i", "s"}, "c-k", function()
   if ls.expand_or_jumpable() then
       ls.expand_or_jump()
   end
end, opts)

vim.keymap.set({"i", "s"}, "c-j", function()
   if ls.jumpable(-1) then
       ls.jump(-1)
   end
end, opts)

vim.keymap.set("i", "c-l", function ()
   if ls.choice_active() then
       ls.change_node(1)
   end
end, opts)

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- local opts = { noremap = true, silent = true }
-- local bufopts = { noremap=true, silent=true, buffer=bufnr}
-- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
-- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
-- vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
-- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
-- vim.keymap.set('n', '<leader>bk', vim.lsp.buf.signature_help, bufopts)
-- vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
-- vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
-- vim.keymap.set('n', '<leader>wl', function()
-- vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
-- vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
-- vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
-- vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
--  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
-- end, bufopts)
-- vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
-- vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
-- vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
-- vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
-- vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
-- vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
--
--
-- vim.keymap.set('n', '<leader>l', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
-- vim.keymap.set('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
-- vim.keymap.set('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
-- vim.keymap.set('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
-- --
--
-- vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

vim.keymap.set('n', '<leader>to', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<C-1>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-2>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-3>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<C-4>", function() ui.nav_file(4) end)
