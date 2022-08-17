local options = require('core.options')
local g = vim.g
local opt = vim.opt

g.do_filetype_lua = 1
g.did_load_filetypes = 0
g.polyglot_disabled = { 'graphql', 'jsx', 'javascript', 'javascriptreact', 'tsx', 'typescript', 'typescriptreact' }
g.mapleader = ' '
g.user_emmet_settings = {
  javascript = {
    extends = 'jsx'
  },
  typescript = {
    extends = 'tsx'
  }
}
g.copilot_filetypes = {
  TelescopePrompt = false,
}

g.EasyMotion_do_mapping = 0
g.EasyMotion_smartcase = 1
g.rust_clip_command = 'pbcopy'
g.python3_host_prog = options.python3_host_prog

vim.cmd('set nocompatible')

opt.complete = ''
opt.background = 'dark'
-- vim.cmd('syntax on')
vim.cmd('filetype plugin indent on')

local indent = 4

opt.timeoutlen = 500
opt.mouse = 'a'
opt.encoding = 'utf-8'
opt.number = true
opt.relativenumber = true
opt.linebreak = true
opt.showbreak = '+++'
opt.showmatch = true
opt.visualbell = true

opt.hlsearch = true
opt.smartcase = true
opt.ignorecase = true
opt.incsearch = true

opt.autoindent = true
-- opt.copyindent = true
opt.shiftwidth = indent
opt.tabstop = indent
opt.softtabstop = indent
opt.expandtab = true
-- opt.smartindent = true

vim.cmd [[
autocmd FileType make setlocal noexpandtab
autocmd BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4

autocmd bufnewfile,bufread *.tsx set filetype=typescriptreact
autocmd bufnewfile,bufread *.jsx set filetype=javascriptreact
autocmd bufnewfile,bufread *.ts set filetype=typescript
]]

opt.list = true
opt.listchars = 'tab:»·,trail:·,nbsp:·'

opt.undofile = true
opt.ruler = true
opt.undolevels = 1000
-- opt.backspace = 'indent,eol,start'
opt.clipboard = 'unnamed'
opt.clipboard:append('unnamedplus')
opt.shell = os.getenv('SHELL') or 'bash'

vim.cmd [[
hi Pmenu ctermfg=white ctermbg=238
]]

vim.cmd [[
augroup last_cursor_position
  autocmd!
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit' | execute "normal! g`\"zvzz" | endif
augroup END
]]

