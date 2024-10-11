local cosmos = require('core.cosmos')
local configs = require('layers.completion.configs')

-- cosmos.add_plugin('github/copilot.vim', {
--   dependencies = { 'hrsh7th/nvim-cmp' },
-- })

cosmos.add_plugin('hrsh7th/nvim-cmp', {
  dependencies = {
    {
      'windwp/nvim-autopairs',
      branch = 'master',
      config = configs.autopairs,
      lazy = true,
    },
    {
      'L3MON4D3/LuaSnip',
      dependencies = {
        {
          'rafamadriz/friendly-snippets',
          lazy = true,
        },
      },
      config = configs.luasnip,
      version = 'v2.3.0',
      build = 'make install_jsregexp',
      lazy = true,
    },
  },
  config = configs.cmp,
  event = 'InsertEnter',
})

cosmos.add_plugin('hrsh7th/cmp-nvim-lua', { dependencies = { 'hrsh7th/nvim-cmp' }, event = 'BufRead' })
cosmos.add_plugin('hrsh7th/cmp-buffer', { dependencies = { 'hrsh7th/nvim-cmp' }, event = 'BufRead' })
cosmos.add_plugin('hrsh7th/cmp-path', { dependencies = { 'hrsh7th/nvim-cmp' }, event = 'BufRead' })
cosmos.add_plugin('hrsh7th/cmp-cmdline', { dependencies = { 'hrsh7th/nvim-cmp' }, event = 'BufRead' })
cosmos.add_plugin('dmitmel/cmp-cmdline-history', { dependencies = { 'hrsh7th/nvim-cmp' }, event = 'BufRead' })

cosmos.add_plugin('saadparwaiz1/cmp_luasnip', { dependencies = { 'hrsh7th/nvim-cmp' }, event = 'BufRead' })

cosmos.add_plugin('jackMort/ChatGPT.nvim', {
  event = 'VeryLazy',
  config = configs.chatgpt,
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
    'folke/trouble.nvim',
    'nvim-telescope/telescope.nvim',
  },
})

cosmos.add_plugin('olimorris/codecompanion.nvim', {
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-telescope/telescope.nvim', -- Optional
    {
      'stevearc/dressing.nvim', -- Optional: Improves the default Neovim UI
      opts = {},
    },
  },
  config = function()
    require('codecompanion').setup({
      adapters = {
        anthropic = function()
          return require('codecompanion.adapters').extend('anthropic', {
            env = {
              api_key = 'ANTHROPIC_API_KEY',
            },
          })
        end,
      },
    })
  end,
})

cosmos.add_plugin('supermaven-inc/supermaven-nvim', {
  enabled = false,
  config = function()
    require('supermaven-nvim').setup({})
  end,
})

cosmos.add_plugin('yetone/avante.nvim', {
  dev = true,
  dir = '~/workspace/projects/avante.nvim',
  event = 'VeryLazy',
  build = 'make',
  opts = {
    debug = true,
    provider = 'claude',
    auto_suggestions_provider = 'claude',
    openai = {
      -- endpoint = 'https://aihubmix.com/v1',
      -- model = 'claude-3-5-sonnet-20240620',
      model = 'gpt-4o',
      -- model = "o1-preview",
      -- timeout = 120000,
    },
    vendors = {
      ollama = {
        ['local'] = true,
        endpoint = '127.0.0.1:11434/v1',
        model = 'deepseek-coder-v2',
        parse_curl_args = function(opts, code_opts)
          return {
            url = opts.endpoint .. '/chat/completions',
            headers = {
              ['Accept'] = 'application/json',
              ['Content-Type'] = 'application/json',
            },
            body = {
              model = opts.model,
              messages = require('avante.providers').copilot.parse_message(code_opts), -- you can make your own message, but this is very advanced
              max_tokens = 2048,
              stream = true,
            },
          }
        end,
        parse_response_data = function(data_stream, event_state, opts)
          require('avante.providers').openai.parse_response(data_stream, event_state, opts)
        end,
      },
      perplexity = {
        endpoint = 'https://api.perplexity.ai/chat/completions',
        model = 'llama-3.1-sonar-large-128k-online',
        api_key_name = 'PPLX_API_KEY',
        --- this function below will be used to parse in cURL arguments.
        parse_curl_args = function(opts, code_opts)
          return {
            url = opts.endpoint,
            headers = {
              ['Accept'] = 'application/json',
              ['Content-Type'] = 'application/json',
              ['Authorization'] = 'Bearer ' .. os.getenv(opts.api_key_name),
            },
            body = {
              model = opts.model,
              messages = require('avante.providers').openai.parse_message(code_opts), -- you can make your own message, but this is very advanced
              temperature = 0,
              max_tokens = 8192,
              stream = true, -- this will be set by default.
            },
          }
        end,
        -- The below function is used if the vendors has specific SSE spec that is not claude or openai.
        parse_response_data = function(data_stream, event_state, opts)
          require('avante.providers').openai.parse_response(data_stream, event_state, opts)
        end,
      },
    },
    behaviour = {
      auto_suggestions = true,
      minimize_diff = true,
    },
    windows = {
      wrap = true,
      sidebar_header = {
        align = 'center',
        rounded = true,
      },
    },
  },
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'stevearc/dressing.nvim',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    -- "zbirenbaum/copilot.lua",
    {
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { 'markdown', 'Avante' },
      },
      ft = { 'markdown', 'Avante' },
    },
  },
})
