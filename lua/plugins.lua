local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'ambv/black'
    -- LSP
    use 'neovim/nvim-lspconfig'
	use 'onsails/lspkind-nvim'
	use 'nvim-lua/lsp_extensions.nvim'
	use 'nvim-lua/lsp-status.nvim'
	-- cmp (completion)
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-nvim-lua'
	use 'hrsh7th/cmp-nvim-lsp'

	use 'saadparwaiz1/cmp_luasnip'


	-- Snippets
	use 'L3MON4D3/LuaSnip'
	use 'rafamadriz/friendly-snippets'
	use 'hrsh7th/vim-vsnip'

    -- Info
    use 'nanotee/nvim-lua-guide'

	-- Syntax
	use 'sbdchd/neoformat'
	use 'simrat39/rust-tools.nvim'

	-- Utils
	use 'windwp/nvim-autopairs'
	use "lukas-reineke/indent-blankline.nvim"
	use 'ryanoasis/vim-devicons'
	use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
	}
	-- use 'frazrepo/vim-rainbow'
	use 'tpope/vim-surround'
	use 'rust-lang/rust.vim'
	use 'darrikonn/vim-gofmt'
	use 'tpope/vim-fugitive'
	use 'tpope/vim-rhubarb'
	use 'junegunn/gv.vim'
	use 'vim-utils/vim-man'
	use 'mbbill/undotree'
	use 'tpope/vim-dispatch'
	use 'theprimeagen/vim-be-good'
	use 'tpope/vim-projectionist'
	use 'tomlion/vim-solidity'
	use 'ThePrimeagen/git-worktree.nvim'
	use({ "iamcco/markdown-preview.nvim",
		run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })
	use 'mfussenegger/nvim-jdtls'

	-- telescope requirements...
	use 'nvim-lua/popup.nvim'
	use 'nvim-lua/plenary.nvim'
	use 'nvim-telescope/telescope.nvim'
	use 'nvim-telescope/telescope-fzy-native.nvim'
	use "nvim-telescope/telescope-media-files.nvim"

	-- Icons
	use 'kyazdani42/nvim-web-devicons'
	use 'simrat39/symbols-outline.nvim'

	-- Theme
	-- use 'gruvbox-community/gruvbox'
	-- use 'luisiacc/gruvbox-baby'
	-- use { "ellisonleao/gruvbox.nvim" }
    -- use {"npxbr/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}
	--
	use({ 'rose-pine/neovim', as = 'rose-pine' })
	-- use { "ellisonleao/gruvbox.nvim" }
	-- treesitter
	use 'nvim-treesitter/nvim-treesitter-context'
	-- use 'p00f/nvim-ts-rainbow'
	use 'HiPhish/rainbow-delimiters.nvim'
	use("nvim-treesitter/nvim-treesitter", {
			run = ":TSUpdate"
	})
	use("nvim-treesitter/playground")

	--status line
	use {
	  'hoob3rt/lualine.nvim',
	  requires = {'kyazdani42/nvim-web-devicons', opt = true}
	}
	-- Harpoon
	use 'mhinz/vim-rfc'
	use("theprimeagen/harpoon")
	use("theprimeagen/refactoring.nvim")

	-- Debug
	use 'mfussenegger/nvim-dap'
	use 'Pocco81/DAPInstall.nvim'
	use 'szw/vim-maximizer'
    use 'github/copilot.vim'

    use("github/copilot.vim")



  if packer_bootstrap then
    require('packer').sync()
  end
end)

