local utils = require('core.utils')
local cosmos = require('core.cosmos')

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
