local options = require('layers.ui.options')
local g = vim.g

g.neon_style = 'doom'
vim.cmd('silent! colorscheme neon')
g.indentLine_fileTypeExclude = options.indentLine_fileTypeExclude

