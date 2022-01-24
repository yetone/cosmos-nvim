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
    requires = {
      {
        'onsails/lspkind-nvim'
      },
      {
        'windwp/nvim-autopairs',
        config = configs.autopairs,
      },
      {
        'L3MON4D3/LuaSnip',
        requires = {
          'rafamadriz/friendly-snippets'
        },
        config = configs.luasnip,
      }
    },
    config = configs.cmp,
  }
)

cosmos.add_plugin('saadparwaiz1/cmp_luasnip', {
  requires = { 'L3MON4D3/LuaSnip' },
})

