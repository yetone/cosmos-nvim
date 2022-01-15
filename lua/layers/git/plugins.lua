local cosmos = require('core.cosmos')
local configs = require('layers.git.configs')

cosmos.add_plugin('jreybert/vimagit')

cosmos.add_plugin(
  'lewis6991/gitsigns.nvim',
  {
    requires = { 'nvim-lua/plenary.nvim' },
    config = configs.gitsigns,
  }
)

