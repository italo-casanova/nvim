vim.cmd('autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js EslintFixAll')
vim.cmd('set numberwidth=2')
vim.cmd('let g:rainbow_active = 1')
vim.cmd('set matchpairs+=<:>')
vim.cmd('set guicursor=a:')
vim.cmd('autocmd TermOpen term://* startinsert')
vim.cmd('let g:python_highlight_space_errors = 0')

-- Theme
vim.cmd('set termguicolors')
vim.cmd([[let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy'] ]])
vim.cmd('let g:tex_no_error=1')

vim.cmd([[
augroup THE_PRIMEAGEN
    autocmd!
    autocmd BufWritePre lua,cpp,c,h,hpp,cxx,cc,py,xml Neoformat
    autocmd BufWritePre * %s/\s\+$//e
    autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}
augroup END ]])

vim.cmd([[
   augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END ]])

vim.cmd([[autocmd BufWritePost *.tex silent! execute "!pdflatex % >/dev/null 2>&1" | redraw!]])
