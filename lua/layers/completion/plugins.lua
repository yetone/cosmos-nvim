local cosmos = require('core.cosmos')
local configs = require('layers.completion.configs')

cosmos.add_plugin(
  'github/copilot.vim',
  {
    after = 'nvim-cmp',
  }
)

cosmos.add_plugin(
  'hrsh7th/nvim-cmp',
  {
    wants = { "LuaSnip" },
    requires = {
      {
        'windwp/nvim-autopairs',
        branch = 'master',
        config = configs.autopairs,
      },
      {
        'L3MON4D3/LuaSnip',
        wants = "friendly-snippets",
        requires = {
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
    after = 'nvim-autopairs',
    event = 'InsertEnter',
  }
)

cosmos.add_plugin('hrsh7th/cmp-nvim-lua', { after = 'nvim-cmp' })
cosmos.add_plugin('hrsh7th/cmp-nvim-lsp', { after = 'nvim-cmp' })
cosmos.add_plugin('hrsh7th/cmp-buffer', { after = 'nvim-cmp' })
cosmos.add_plugin('hrsh7th/cmp-path', { after = 'nvim-cmp' })
cosmos.add_plugin('hrsh7th/cmp-cmdline', { after = 'nvim-cmp' })

cosmos.add_plugin('saadparwaiz1/cmp_luasnip', { after = 'nvim-cmp' })

