local options = require('layers.ui.options')
local g = vim.g
local opt = vim.opt

opt.termguicolors = true
g.Illuminate_delay = options.illuminate_delay
g.Illuminate_ftblacklist = options.illuminate_filetype_exclude

opt.cursorline = true
vim.cmd [[
autocmd WinEnter * if &filetype != "alpha" | setlocal cursorline | endif
autocmd WinLeave * setlocal nocursorline
]]

vim.cmd [[
augroup illuminate_augroup
  autocmd!
  autocmd VimEnter * hi link illuminatedWord CursorLine
  autocmd VimEnter * hi illuminatedCurWord cterm=underline gui=underline
augroup END
]]

vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

vim.cmd [[ autocmd BufEnter,BufRead,BufWinEnter,FileType,WinEnter * lua require("layers.ui.utils").hide_statusline() ]]

