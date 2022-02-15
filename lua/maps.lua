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

-- open terminal
vim.api.nvim_set_keymap('n', '<leader>tb', ':split<CR>:resize 10<CR>:ter<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>tv', ':vsplit<CR>:vertical resize - 20<CR>:ter<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-t>', ':tabnew<CR>:terminal<CR>', {noremap = true, silent = true})


vim.api.nvim_set_keymap('n', '<leader>tn', ':tabnew<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gcc', ':w<CR>:!g++ -o  %:r.exe % -std=c++11<Enter>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>p', ':w<CR>:!py %<CR>', {noremap = true, silent = true})


-- resize buffer
vim.api.nvim_set_keymap('n', '<leader>+', ':vertical resize +5<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>-', ':vertical resize -5<CR>', { noremap = true, silent = true})

-- Indenting
vim.api.nvim_set_keymap('v', ',', '<gv', { noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '.', '>gv', { noremap = true, silent = true})

-- show hover doc
vim.api.nvim_set_keymap('n', 'L', ':Lspsaga hover_doc<CR>', { noremap = true, silent = true})

vim.api.nvim_set_keymap('n', '<F8>', ':TagbarToggle<CR>', { noremap = true, silent = true})

vim.api.nvim_set_keymap('n', '<leader>j',':m .+1<CR>==', {noremap = true, silent = true} )
vim.api.nvim_set_keymap('n', '<leader>k',':m .-2<CR>==', {noremap = true, silent = true} )
vim.api.nvim_set_keymap('v', 'J', ":m '>+1<CR>gv=gv", {noremap = true, silent = true} )
vim.api.nvim_set_keymap('v', 'K', ":m '<-2<CR>gv=gv", {noremap = true, silent = true} )

vim.api.nvim_set_keymap('n','<leader>s', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>', {noremap = true, silent = true})

