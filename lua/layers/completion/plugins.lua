local cosmos = require('core.cosmos')
local configs = require('layers.completion.configs')

cosmos.add_plugin('github/copilot.vim')

cosmos.add_plugin('mattn/emmet-vim')

cosmos.add_plugin('hrsh7th/cmp-nvim-lsp')
cosmos.add_plugin('hrsh7th/cmp-buffer')
cosmos.add_plugin('hrsh7th/cmp-path')
cosmos.add_plugin('hrsh7th/cmp-cmdline')
cosmos.add_plugin(
  'hrsh7th/nvim-cmp',
  {
    requires = { 'hrsh7th/nvim-cmp', 'onsails/lspkind-nvim' },
    config = configs.cmp,
  }
)

cosmos.add_plugin(
  'hrsh7th/cmp-vsnip',
  { after = 'nvim-cmp', requires = { 'hrsh7th/nvim-cmp' } }
)
cosmos.add_plugin('hrsh7th/vim-vsnip')
cosmos.add_plugin('hrsh7th/vim-vsnip-integ')

cosmos.add_plugin(
  'windwp/nvim-autopairs',
  {
    config = configs.autopairs,
  }
)

