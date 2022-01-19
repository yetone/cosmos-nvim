local options = require('layers.ui.options')
local g = vim.g
local opt = vim.opt

opt.termguicolors = true
vim.cmd('silent! colorscheme doom-one')
g.indentLine_fileTypeExclude = options.indentLine_fileTypeExclude
g.illuminate_delay = options.illuminate_delay

vim.cmd [[
augroup illuminate_augroup
  autocmd!
  autocmd VimEnter * hi illuminatedWord cterm=underline gui=underline
  autocmd VimEnter * hi illuminatedCurWord cterm=italic gui=italic
augroup END
]]

