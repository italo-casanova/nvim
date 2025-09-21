
vim.g.mapleader = " "
-- Set <space> as leader key
vim.api.nvim_set_keymap('n', '<Space>', '<NOP>', { noremap = true, silent = true })

-- toggle hlsearch
vim.api.nvim_set_keymap('n', '<leader>h', ':set hlsearch!<CR>', { noremap = true, silent = true })

-- file manager
vim.api.nvim_set_keymap('n', '<c-n>', ':Lexplore<CR>', { noremap = true, silent = true })

-- terminal
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })

--better  split navigation
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

vim.api.nvim_set_keymap('t', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<C-l>', '<C-w>l', { noremap = true, silent = true })

-- open terminal
vim.api.nvim_set_keymap('n', '<leader>tb', ':split<CR>:resize 10<CR>:ter<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tv', ':vsplit<CR>:vertical resize - 20<CR>:ter<CR>',
    { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-t>', ':tabnew<CR>:terminal<CR>', { noremap = true, silent = true })


vim.api.nvim_set_keymap('n', '<leader>tn', ':tabnew<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gcc', ':w<CR>:!g++ -o  %:r % -std=c++17<Enter>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>rp', ':w<CR>:!python3 %<CR>', { noremap = true, silent = true })


-- resize buffer
vim.api.nvim_set_keymap('n', '<leader>+', ':vertical resize +5<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>-', ':vertical resize -5<CR>', { noremap = true, silent = true })

-- Indenting
vim.api.nvim_set_keymap('v', ',', '<gv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '.', '>gv', { noremap = true, silent = true })

-- show hover doc

vim.api.nvim_set_keymap('n', '<F8>', ':TagbarToggle<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>j', ':m .+1<CR>==', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>k', ':m .-2<CR>==', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>s', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>',
    { noremap = true, silent = true })

-- Debug
-- vim.api.nvim_set_keymap('n', '<leader>bt', ':lua require"dap".toggle_breakpoint()<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>sb', ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
--     { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>td', ':lua require"dap".terminate()<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>cb', ':lua require"dap".clear_breakpoints()<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<A-k>', ':lua require"dap".step_out()<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', "<A-l>", ':lua require"dap".step_into()<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<A-h>', ':lua require"dap".continue()<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<A-j>', ':lua require"dap".step_over()<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>dn', ':lua require"dap".run_to_cursor()<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>dk', ':lua require"dap".up()<CR>zz', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>dj', ':lua require"dap".down()<CR>zz', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>dr', ':lua require"dap".repl.toggle({}, "vsplit")<CR><C-w>l',
--     { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>de', ':lua require"dap".set_exception_breakpoints({"all"})<CR>',
--     { noremap = true, silent = true })
--

vim.api.nvim_set_keymap("n", "<leader>cp", "<cmd>:w<CR><cmd>:! lualatex %<CR><CR>", { noremap = true })

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
keymap("i", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
keymap("s", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
keymap("i", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
keymap("s", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

vim.keymap.set('n', '<leader>to', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)


vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
vim.api.nvim_set_keymap("i", "<C-H>", 'copilot#Previous()', { silent = true, expr = true })
vim.api.nvim_set_keymap("i", "<C-K>", 'copilot#Next()', { silent = true, expr = true })
vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>")
vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>")
