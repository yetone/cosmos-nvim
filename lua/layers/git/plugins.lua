local cosmos = require('core.cosmos')
local configs = require('layers.git.configs')

cosmos.add_plugin(
  'jreybert/vimagit',
  {
    event = 'BufRead',
    branch = 'master',
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

