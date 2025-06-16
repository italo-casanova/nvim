vim.cmd('autocmd BufWritePre *.tsx, *.ts, *.jsx, *.js EslintFixAll')
vim.cmd('set numberwidth=2')
vim.cmd('let g:rainbow_active = 1')
vim.cmd('set matchpairs+=<:>')
vim.cmd('set guicursor=a:')
vim.cmd('set clipboard+=unnamedplus')
vim.cmd('autocmd TermOpen term://* startinsert')
vim.cmd('let g:python_highlight_space_errors = 0')

-- Theme
vim.cmd('set termguicolors')
vim.cmd([[let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy'] ]])
vim.cmd('let g:tex_no_error=1')

vim.cmd([[
   augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END ]])

vim.cmd([[autocmd BufWritePost *.tex silent! execute "!lualatex % >/dev/null 2>&1" | redraw!]])
