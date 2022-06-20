-- require modules
require('plugins') -- plugins install
require('commands') -- basic vim commands i still can't write in lua
require('maps') -- basic remaps
require('lsp') -- lsp clients config
require'plugins-conf' -- minors plugins conf which don't deserve it's own file
require'plugins_conf' -- plugins config directory
require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"}}


-- sets
--
vim.opt.guicursor = ""
vim.opt.relativenumber = true
vim.opt.hlsearch = false
vim.opt.hidden = true
vim.opt.errorbells = false
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.nu = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.isfname:append("@-@")
vim.opt.cmdheight = 1
vim.opt.updatetime = 50
vim.opt.shortmess:append("c")
vim.g.mapleader = " "
vim.o.ruler = true
vim.o.shell = "/bin/zsh" --make zzsh as a nvim default terminal shell
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.cursorline = true
vim.o.autoindent = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.smarttab = true
vim.o.listchars = 'tab:┆·,trail:·,precedes:,extends:'
--vim.cmd [[vim.opt undofile]] --save undo file
vim.o.completeopt = "menuone,noselect"
vim.o.showmode = true
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
vim.cmd([[
autocmd CursorHold,CursorHoldI *.rs :lua require'lsp_extensions'.inlay_hints{ only_current_line = true }
]])
