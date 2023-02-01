local cosmos = require('core.cosmos')
local configs = require('layers.completion.configs')

cosmos.add_plugin(
  'github/copilot.vim',
  {
    dependencies = { 'hrsh7th/nvim-cmp' },
    event = 'BufRead',
  }
)

cosmos.add_plugin(
  'hrsh7th/nvim-cmp',
  {
    dependencies = {
      {
        'windwp/nvim-autopairs',
        branch = 'master',
        config = configs.autopairs,
        event = 'InsertCharPre',
      },
      {
        'L3MON4D3/LuaSnip',
        dependencies = {
          {
            'rafamadriz/friendly-snippets',
            event = 'InsertEnter',
          }
        },
        config = configs.luasnip,
        event = 'InsertCharPre',
      }
    },
    config = configs.cmp,
    event = 'InsertEnter',
  }
)

cosmos.add_plugin('hrsh7th/cmp-nvim-lua', { dependencies = { 'hrsh7th/nvim-cmp' }, event = 'BufRead' })
cosmos.add_plugin('hrsh7th/cmp-nvim-lsp', { dependencies = { 'hrsh7th/nvim-cmp' }, event = 'BufRead' })
cosmos.add_plugin('hrsh7th/cmp-buffer', { dependencies = { 'hrsh7th/nvim-cmp' }, event = 'BufRead' })
cosmos.add_plugin('hrsh7th/cmp-path', { dependencies = { 'hrsh7th/nvim-cmp' }, event = 'BufRead' })
cosmos.add_plugin('hrsh7th/cmp-cmdline', { dependencies = { 'hrsh7th/nvim-cmp' }, event = 'BufRead' })
cosmos.add_plugin('dmitmel/cmp-cmdline-history', { dependencies = { 'hrsh7th/nvim-cmp' }, event = 'BufRead' })

cosmos.add_plugin('saadparwaiz1/cmp_luasnip', { dependencies = { 'hrsh7th/nvim-cmp' }, event = 'BufRead' })

