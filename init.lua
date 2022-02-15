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


