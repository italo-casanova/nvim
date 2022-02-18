-- require modules
require('plugins') -- plugins install
require('commands') -- basic vim commands i still can't write in lua
require('maps') -- basic remps
require('lsp') -- lsp clients config
require'plugins-conf'
require'plugins_conf'


-- sets
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.number = true
vim.o.clipboard = 'unnamedplus'
vim.o.ruler = true
vim.o.shell = "/bin/zsh" --make zzsh as a nvim default terminal shell
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.hidden = true
vim.o.cursorline = true
vim.o.autoindent = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.smarttab = true
vim.o.listchars = 'tab:┆·,trail:·,precedes:,extends:'
--vim.cmd [[vim.opt undofile]] --save undo file
vim.o.completeopt = "menuone,noselect"
vim.o.showmode = false
vim.o.incsearch = true
vim.o.background = "dark"

vim.cmd([[
    let g:color_shceme = "gruvbox"
    fun! ColorMyPencils()
    let g:gruvbox_contrast_dark = 'hard'
    if exists('+termguicolors')
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    endif
    let g:gruvbox_invert_selection='0'

    set background=dark
    if has('nvim')
        call luaeval('vim.cmd("colorscheme " .. _A[1])', [g:color_shceme])
    else
        colorscheme gruvbox
    endif

    highlight ColorColumn ctermbg=0 guibg=grey
    hi SignColumn guibg=none
    hi CursorLineNR guibg=None
    highlight Normal guibg=none
    " highlight LineNr guifg=#ff8659
    " highlight LineNr guifg=#aed75f
    highlight LineNr guifg=#5eacd3
    highlight netrwDir guifg=#5eacd3
    highlight qfFileName guifg=#aed75f
    hi TelescopeBorder guifg=#5eacd
endfun
call ColorMyPencils()
    ]])
