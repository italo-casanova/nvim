vim.cmd('autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js EslintFixAll')
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

vim.cmd([[autocmd BufWritePost *.tex silent! execute "!lualatex % >/dev/null 2>&1" | redraw!]])


-- vim.cmd([[
--     let g:theprimeagen_colorscheme = "gruvbox"
--     fun! ColorMyPencils()
--     let g:gruvbox_contrast_dark = 'hard'
--     if exists('+termguicolors')
--         let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
--         let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
--     endif
--     let g:gruvbox_invert_selection='0'
--
--     set background=dark
--     if has('nvim')
--         call luaeval('vim.cmd("colorscheme " .. _A[1])', [g:theprimeagen_colorscheme])
--     else
--         " TODO: What the way to use g:theprimeagen_colorscheme
--         colorscheme gruvbox
--     endif
--
--     highlight ColorColumn ctermbg=0 guibg=grey
--     hi SignColumn guibg=none
--     hi CursorLineNR guibg=None
--     highlight Normal guibg=none
--     " highlight LineNr guifg=#ff8659
--     " highlight LineNr guifg=#aed75f
--     highlight LineNr guifg=#5eacd3
--     highlight netrwDir guifg=#5eacd3
--     highlight qfFileName guifg=#aed75f
--     hi TelescopeBorder guifg=#5eacd
-- endfun
-- call ColorMyPencils()
--     ]])

-- vim.cmd('autocmd BufWritePost *.tex silent! execute "!pdflatex % >/dev/null 2>&1" | redraw!')
