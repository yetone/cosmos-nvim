local options = require('core.options')
local g = vim.g
local opt = vim.opt

-- g.do_filetype_lua = 1
-- g.did_load_filetypes = 1
-- g.polyglot_disabled = { 'graphql', 'jsx', 'javascript', 'javascriptreact', 'tsx', 'typescript', 'typescriptreact' }
g.mapleader = ' '
g.user_emmet_settings = {
  javascript = {
    extends = 'jsx',
  },
  typescript = {
    extends = 'tsx',
  },
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
-- opt.background = 'dark'
vim.cmd('syntax on')
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

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'make',
  command = 'set noexpandtab',
})
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*.go',
  command = 'setlocal noet ts=4 sw=4 sts=4',
})

-- autocmd bufnewfile,bufread *.tsx set filetype=typescriptreact
-- autocmd bufnewfile,bufread *.jsx set filetype=javascriptreact
-- autocmd bufnewfile,bufread *.ts set filetype=typescript
-- autocmd bufnewfile,bufread *.lua set filetype=lua

opt.list = true
opt.listchars = 'tab:»·,trail:·,nbsp:·'

opt.undofile = true
opt.ruler = true
opt.undolevels = 1000
-- opt.backspace = 'indent,eol,start'
opt.shell = os.getenv('SHELL') or 'bash'

vim.cmd([[
hi Pmenu ctermfg=white ctermbg=238
]])

-- Jump to the last position when opening a file. If you want to seen more details, see :help last-position-jump'.
vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = '*',
  callback = function()
    local line = vim.fn.line('\'"')
    if line >= 1 and line <= vim.fn.line('$') then
      vim.cmd('normal! g`"')
    end
  end,
})
