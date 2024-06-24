-- require modules
require('plugins')      -- plugins install
require('maps')         -- basic remaps
require('plugins_conf') -- plugins config directory
require('plugins-conf') -- minors plugins conf which don't deserve it's own file
require('commands')     -- basic vim commands i still can't write in lua
require('lsp')          -- lsp clients config
require('snips')        -- plugins config directory

require 'lsp_extensions'.inlay_hints { prefix = '', highlight = "Comment", enabled = { "TypeHint", "ChainingHint", "ParameterHint" } }
-- require("symbols-outline").setup()
require("outline").setup({})



-- sets
vim.cmd('set mouse=')
vim.cmd('set syntax=enable')
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
vim.cmd("set clipboard+=unnamedplus")
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
vim.o.completeopt = "menuone,noselect"
vim.o.showmode = true
vim.o.incsearch = true
vim.g.snippets = "luasnip"
vim.o.background = "dark"
vim.g.copilot_no_tab_map = true
vim.cmd [[ autocmd BufRead,BufNewFile *.org set filetype=org ]]

vim.cmd([[
autocmd CursorHold,CursorHoldI *.rs :lua require'lsp_extensions'.inlay_hints{ only_current_line = true }
]])

require('rose-pine').setup({
    disable_background = true,
    highlight_groups = {
        ColorColumn = { bg = 'rose' },

        CursorLine = { bg = 'foam', blend = 10 },
        -- StatusLine = { fg = 'love', bg = 'love', blend = 10 },
    }

})

function ColorMyPencils(color)
    color = color or "rose-pine"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()
-- vim.cmd([[
-- 	autocmd CursorHold,CursorHoldI * lua require('lsp').code_action_listener()
-- 	]])
-- This module contains a number of default definitions
