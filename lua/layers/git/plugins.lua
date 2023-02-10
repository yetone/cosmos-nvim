local cosmos = require('core.cosmos')
local configs = require('layers.git.configs')

cosmos.add_plugin('TimUntersberger/neogit', {
  dependencies = { 'nvim-lua/plenary.nvim' },
})

cosmos.add_plugin('lewis6991/gitsigns.nvim', {
  lazy = true,
  dependencies = { 'nvim-lua/plenary.nvim', lazy = true },
  config = configs.gitsigns,
  event = { 'BufRead', 'BufNewFile' },
})
