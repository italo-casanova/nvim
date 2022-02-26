-- vim.cmd([let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']]])

vim.cmd([[
    fun! LspLocationList()
        " lua vim.lsp.diagnostic.set_loclist({open_loclist = false})
    endfun


     augroup THE_PRIMEAGEN_LSP
          autocmd!
          autocmd! BufWrite,BufEnter,InsertLeave * :call LspLocationList()
      augroup END

    let g:compe = {}
    let g:compe.enabled = v:true
    let g:compe.autocomplete = v:true
    let g:compe.debug = v:false
    let g:compe.min_length = 1
    let g:compe.preselect = 'enable'
    let g:compe.throttle_time = 80
    let g:compe.source_timeout = 200
    let g:compe.incomplete_delay = 400
    let g:compe.max_abbr_width = 100
    let g:compe.max_kind_width = 100
    let g:compe.max_menu_width = 100
    let g:compe.documentation = v:true

    let g:compe.source = {}
    let g:compe.source.path = v:true
    let g:compe.source.buffer = v:true
    let g:compe.source.calc = v:true
    let g:compe.source.nvim_lsp = v:true
    let g:compe.source.nvim_lua = v:true
    let g:compe.source.vsnip = v:true
    let g:compe.source.luasnip = v:true
    ]])

vim.api.nvim_set_keymap('n', '<leader>vn', ':lua vim.lsp.diagnostic.goto_next()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>vll', ':call LspLocationList()<CR>', {noremap = true, silent = true})


vim.api.nvim_set_keymap('n', '<silent>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', {noremap = true, silent = true})
