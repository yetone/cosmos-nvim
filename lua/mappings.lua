local utils = require('utils')
local set_keymap = vim.api.nvim_set_keymap

local function _map(mode, shortcut, command)
  set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

local function map(shortcut, command)
  _map('', shortcut, command)
end

local function nmap(shortcut, command)
  _map('n', shortcut, command)
end

local function imap(shortcut, command)
  _map('i', shortcut, command)
end

local function vmap(shortcut, command)
  _map('v', shortcut, command)
end

local function cmap(shortcut, command)
  _map('c', shortcut, command)
end

local function tmap(shortcut, command)
  _map('t', shortcut, command)
end

-- Setup for emacs keybindings
-- insert mode
set_keymap('i', '<C-b>', '<Left>', {})
set_keymap('i', '<C-f>', '<Right>', {})
set_keymap('i', '<C-a>', '<Home>', {})
set_keymap('i', '<C-e>', '<End>', {})
set_keymap('i', '<C-d>', '<Del>', {})
set_keymap('i', '<C-h>', '<BS>', {})
set_keymap('i', '<C-k>', '<C-r>=KillLine()<CR>', {})
set_keymap('i', '<C-p>', '<Up>', {})
set_keymap('i', '<C-n>', '<Down>', {})

-- normal mode
set_keymap('n', '<C-p>', '<Up>', {})
set_keymap('n', '<C-n>', '<Down>', {})

-- command line mode
set_keymap('c', '<C-p>', '<Up>', {})
set_keymap('c', '<C-n>', '<Down>', {})
set_keymap('c', '<C-b>', '<Left>', {})
set_keymap('c', '<C-f>', '<Right>', {})
set_keymap('c', '<C-a>', '<Home>', {})
set_keymap('c', '<C-e>', '<End>', {})
set_keymap('c', '<C-d>', '<Del>', {})
set_keymap('c', '<C-h>', '<BS>', { noremap = true })
set_keymap('c', '<C-k>', '<C-f>D<C-c><C-c>:<Up>', { noremap = true })
-- End of setup for emacs keybindings

nmap('gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
nmap('gD', ':Lspsaga preview_definition<CR>')
set_keymap('n', '<C-f>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", { noremap = true, silent = true })
set_keymap('n', '<C-b>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", { noremap = true, silent = true })
tmap('<A-d>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
set_keymap('n', 's', '<Plug>(easymotion-overwin-f)', {})
set_keymap('n', '<leader>;;', 'gcc', {})
set_keymap('v', '<leader>;', 'gcc<esc>', {})

