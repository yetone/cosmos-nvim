local utils = require('core.utils')
local cosmos = require('core.cosmos')

local i = 0
for i = 1, 6 do
  cosmos.add_leader_keymapping(
    string.format('n|%d', i),
    { string.format('%d<C-w><C-w>', i), name = string.format('Select window %d', i) }
  )
end

cosmos.add_leader_keymapping('n|ws', { '<C-w>s', name = 'Split window below' })
cosmos.add_leader_keymapping('n|wv', { '<C-w>v', name = 'Split window right' })
cosmos.add_leader_keymapping('n|w-', { '<C-w>s', name = 'Split window below' })
cosmos.add_leader_keymapping('n|w/', { '<C-w>v', name = 'Split window right' })
cosmos.add_leader_keymapping('n|ww', { '<C-w>w', name = 'Other window' })
cosmos.add_leader_keymapping('n|wj', { '<C-w>j', name = 'Go to the down window' })
cosmos.add_leader_keymapping('n|wk', { '<C-w>k', name = 'Go to the up window' })
cosmos.add_leader_keymapping('n|wh', { '<C-w>h', name = 'Go to the left window' })
cosmos.add_leader_keymapping('n|wl', { '<C-w>l', name = 'Go to the right window' })
cosmos.add_leader_keymapping('n|wd', { '<C-w>c', name = 'Delete window' })
cosmos.add_leader_keymapping('n|wm', { '<C-w>o', name = 'Maximize window' })

-- Setup for emacs keybindings
-- insert mode
utils.set_keymap('i', '<C-b>', '<Left>', {})
utils.set_keymap('i', '<C-f>', '<Right>', {})
utils.set_keymap('i', '<C-a>', '<Home>', {})
utils.set_keymap('i', '<C-e>', '<End>', {})
utils.set_keymap('i', '<C-d>', '<Del>', {})
utils.set_keymap('i', '<C-h>', '<BS>', {})
utils.set_keymap('i', '<C-k>', '<C-r>=KillLine()<CR>', {})
utils.set_keymap('i', '<C-p>', '<Up>', {})
utils.set_keymap('i', '<C-n>', '<Down>', {})
utils.set_keymap('i', '<A-f>', '<Esc>lWi', {})
utils.set_keymap('i', '<A-b>', '<Esc>Bi', {})

-- normal mode
utils.set_keymap('n', '<C-p>', '<Up>', {})
utils.set_keymap('n', '<C-n>', '<Down>', {})

-- command line mode
utils.set_keymap('c', '<C-p>', '<Up>', {})
utils.set_keymap('c', '<C-n>', '<Down>', {})
utils.set_keymap('c', '<C-b>', '<Left>', {})
utils.set_keymap('c', '<C-f>', '<Right>', {})
utils.set_keymap('c', '<C-a>', '<Home>', {})
utils.set_keymap('c', '<C-e>', '<End>', {})
utils.set_keymap('c', '<C-d>', '<Del>', {})
utils.set_keymap('c', '<C-h>', '<BS>', { noremap = true })
utils.set_keymap('c', '<C-k>', '<C-f>D<C-c><C-c>:<Up>', { noremap = true })
-- End of setup for emacs keybindings
