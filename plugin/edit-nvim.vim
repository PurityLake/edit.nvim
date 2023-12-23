" Title:        edit-nvim
" Description:  A plugin for Neovim that provides some editing features
" Last Change:  23 December 0223
" Maintainer:   PurityLake <https://github.com/PurityLake

if exists("g:loaded_editnvim")
    finish
endif
let g:loaded_editnvim = 1

command! -nargs=1 DelimiterDelete lua require("edit-nvim").delimiter_delete()
