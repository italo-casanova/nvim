return {
	"github/copilot.vim",
	init = function()
		vim.g.copilot_nes_debounce = 500
		vim.lsp.enable("copilot")
        vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
        vim.api.nvim_set_keymap("i", "<C-H>", 'copilot#Previous()', { silent = true, expr = true })
        vim.api.nvim_set_keymap("i", "<C-K>", 'copilot#Next()', { silent = true, expr = true })
	end,
}
