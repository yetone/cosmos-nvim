local cosmos = require('core.cosmos')
local configs = require('layers.git.configs')

cosmos.add_plugin('TimUntersberger/neogit', {
  dependencies = { 'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim' },
  config = true,
})

cosmos.add_plugin('lewis6991/gitsigns.nvim', {
  lazy = true,
  dependencies = { 'nvim-lua/plenary.nvim', lazy = true },
  config = configs.gitsigns,
  event = { 'BufRead', 'BufNewFile' },
})

cosmos.add_plugin('nvim-telescope/telescope-github.nvim', {
  dependencies = { 'nvim-telescope/telescope.nvim' },
  config = configs.telescope_github,
})
