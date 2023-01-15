local cosmos = require('core.cosmos')
local configs = require('layers.git.configs')

cosmos.add_plugin(
  'TimUntersberger/neogit',
  {
    requires = { 'nvim-lua/plenary.nvim' },
  }
)

cosmos.add_plugin(
  'lewis6991/gitsigns.nvim',
  {
    opt = true,
    requires = { 'nvim-lua/plenary.nvim', opt = true },
    config = configs.gitsigns,
    event = { 'BufRead', 'BufNewFile' },
  }
)

