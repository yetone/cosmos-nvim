local utils = require('utils')
local vim = vim
local set_keymap = vim.api.nvim_set_keymap

function _map(mode, shortcut, command)
  set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function map(shortcut, command)
  _map('', shortcut, command)
end

function nmap(shortcut, command)
  _map('n', shortcut, command)
end

function imap(shortcut, command)
  _map('i', shortcut, command)
end

function vmap(shortcut, command)
  _map('v', shortcut, command)
end

function cmap(shortcut, command)
  _map('c', shortcut, command)
end

function tmap(shortcut, command)
  _map('t', shortcut, command)
end

-- Setup for emacs keybindings
-- insert mode
set_keymap('i', '<C-b>', '<Left>', {})
set_keymap('i', '<C-f>', '<Right>', {})
set_keymap('i', '<C-a>', '<C-o>:call Home()<CR>', {})
set_keymap('i', '<C-e>', '<End>', {})
set_keymap('i', '<C-d>', '<Del>', {})
set_keymap('i', '<C-h>', '<BS>', {})
set_keymap('i', '<C-k>', '<C-r>=KillLine()<CR>', {})
set_keymap('i', '<C-p>', '<Up>', {})
set_keymap('i', '<C-n>', '<Down>', {})

-- command line mode
set_keymap('c', '<C-p>', '<Up>', {})
set_keymap('c', '<C-n>', '<Down>', {})
set_keymap('c', '<C-b>', '<Left>', {})
set_keymap('c', '<C-f>', '<Right>', {})
set_keymap('c', '<C-a>', '<Home>', {})
set_keymap('c', '<C-e>', '<End>', {})
set_keymap('c', '<C-d>', '<Del>', {})
set_keymap('c', '<C-h>', '<BS>', {})
set_keymap('c', '<C-k>', '<C-f>D<C-c><C-c>:<Up>', {})
-- End of setup for emacs keybindings

utils.safe_require('which-key', function(wk)
  wk.register({
    w = {
      name = '+Windows',
      s = { '<C-w>s', 'Split window below' },
      v = { '<C-w>v', 'Split window right' },
      ['-'] = { '<C-w>s', 'Split window below' },
      ['/'] = { '<C-w>v', 'Split window right' },
      w = { '<C-w>w', 'Other window' },
      j = { '<C-w>j', 'Go to the down window' },
      k = { '<C-w>k', 'Go to the up window' },
      h = { '<C-w>h', 'Go to the left window' },
      l = { '<C-w>l', 'Go to the right window' },
      d = { '<C-w>c', 'Delete window' },
      m = { '<C-w>o', 'Maximize window' },
    },
    b = {
      name = '+Buffers',
      b = { '<cmd>Telescope buffers<cr>', 'List buffers' },
      n = { ':BufferLineCycleNext<CR>', 'Next buffer' },
      p = { ':BufferLineCyclePrev<CR>', 'Previous buffer' },
      d = { ':bw<CR>', 'Delete buffer' },
    },
    f = {
      name = '+Files',
      -- f = { "<cmd>lua require 'telescope'.extensions.file_browser.file_browser()<CR>", 'Find file' },
      -- f = { '<cmd>Telescope find_files<cr>', 'Find file' },
      f = { ":FilesWithDevicons <C-R>=expand('%:h')<CR><CR>", "Find file" },
      r = { '<cmd>Telescope oldfiles<cr>', 'Open recent file', noremap = false },
    },
    p = {
      name = '+Projects',
      f = { ':ProjectFiles<CR>', 'Find project files' },
    },
    j = {
      name = '+Jump',
      j = { '<Plug>(easymotion-s)', 'Jump to char' },
      l = { '<Plug>(easymotion-bd-jk)', 'Jump to line' },
      i = { "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", 'Jump to symbol' },
    },
    s = {
      name = '+Search/Symbols',
      e = { ':Lspsaga rename<CR>', 'Edit symbol' },
      s = { ':Telescope current_buffer_fuzzy_find fuzzy=false case_mode=ignore_case<cr>', 'Search current buffer' },
    },
    g = {
      name = '+Git',
      s = { ':Magit<CR>', 'Magit status' },
    },
    e = {
      name = '+Errors',
      l = { "<cmd>lua require('telescope.builtin').diagnostics{ bufnr=0 }<cr>", 'List errors' },
      n = { ':Lspsaga diagnostic_jump_next<CR>', 'Next error' },
      p = { ':Lspsaga diagnostic_jump_prev<CR>', 'Previous error' },
      f = { ':Lspsaga code_action<CR>', 'Fix error' },
    },
    [';'] = {
      name = 'Comment',
      [';'] = {
        'gcc', 'Comment line', noremap = false
      },
    },
    ["'"] = { ':Lspsaga open_floaterm<CR>', 'Open shell' },
    ['*'] = { "<cmd>lua require('telescope.builtin').lsp_references()<cr>", 'Search reference in current project' },
    ['/'] = { ':Telescope live_grep<CR>', 'Search project' },
    ['<Tab>'] = { ':b#<CR>', 'Last buffer' },
    ['<Space>'] = { ':Telescope commands<CR>', 'Commands' },
  }, { prefix = '<leader>' })
end)

map('<Leader>fed', ':e ~/.config/nvim/lua/config.lua<CR>')

nmap('gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
nmap('gD', ':Lspsaga preview_definition<CR>')
tmap('<A-d>', '<C-\\><C-n>:Lspsaga close_floaterm<CR>')
set_keymap('n', 's', '<Plug>(easymotion-overwin-f)', {})

vim.cmd [[
au FileType html,typescriptreact,javascriptreact EmmetInstall
au FileType html,gohtmltmpl,typescriptreact,javascriptreact imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
]]
