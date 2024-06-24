
-- indent blankline
-- require("indent_blankline").setup {
--     char = "|",
--     buftype_exclude = {"terminal"}
-- }
--
require("ibl").setup()

-- require("ibl").setup({ scope = { enabled = true } })

require('nvim-autopairs').setup{}

if vim.g.snippets ~= "luasnip" or not pcall(require, "luasnip") then
  return
end

local ls = require "luasnip"
local types = require "luasnip.util.types"

ls.config.set_config {
  history = true,

  updateevents = "TextChanged,TextChangedI",

  enable_autosnippets = true,

  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { " <- Current Choice", "NonTest" } },
      },
    },
  },
}

vim.g.neoformat_try_node_exe = 1

require('Comment').setup()
