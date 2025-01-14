local cosmos = require('core.cosmos')
local configs = require('layers.completion.configs')

cosmos.add_plugin('zbirenbaum/copilot.lua', {
  enabled = false,
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    require('copilot').setup({
      suggestion = {
        auto_trigger = true,
      },
    })
  end,
})

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

local local_codecompanion_dir = os.getenv('HOME') .. '/workspace/projects/codecompanion.nvim'
local local_codecompanion_dir_exists = vim.fn.isdirectory(local_codecompanion_dir) == 1

cosmos.add_plugin('olimorris/codecompanion.nvim', {
  dev = local_codecompanion_dir_exists,
  dir = local_codecompanion_dir_exists and local_codecompanion_dir or nil,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    { 'MeanderingProgrammer/render-markdown.nvim', ft = { 'markdown', 'codecompanion' } },
  },
  config = function()
    require('codecompanion').setup({
      display = {
        diff = {
          provider = 'mini_diff',
        },
      },
      opts = {
        log_level = 'DEBUG',
      },
      strategies = {
        chat = {
          slash_commands = {
            ['file'] = {
              opts = {
                provider = 'default',
              },
            },
          },
        },
      },
    })
  end,
})

cosmos.add_plugin('supermaven-inc/supermaven-nvim', {
  enabled = false,
  config = function()
    require('supermaven-nvim').setup({
      ignore_filetypes = { 'Avante', 'TelescopePrompt' },
    })
  end,
})

cosmos.add_plugin('CopilotC-Nvim/CopilotChat.nvim', {
  enabled = false,
  branch = 'canary',
  dependencies = {
    { 'zbirenbaum/copilot.lua' }, -- or zbirenbaum/copilot.lua
    { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
  },
  build = 'make tiktoken', -- Only on MacOS or Linux
  opts = {
    -- See Configuration section for options
  },
})

local local_avante_dir = os.getenv('HOME') .. '/workspace/projects/avante.nvim'
local local_avante_dir_exists = vim.fn.isdirectory(local_avante_dir) == 1

cosmos.add_plugin('yetone/avante.nvim', {
  dev = local_avante_dir_exists,
  dir = local_avante_dir_exists and local_avante_dir or nil,
  event = 'VeryLazy',
  build = 'make',
  opts = {
    debug = true,
    provider = 'claude',
    auto_suggestions_provider = 'claude',
    copilot = {
      model = 'claude-3.5-sonnet',
    },
    gemini = {
      model = 'gemini-2.0-flash-exp',
      -- model = 'gemini-2.0-flash-thinking-exp-1219',
    },
    openai = {
      -- endpoint = 'https://aihubmix.com/v1',
      -- model = 'claude-3-5-sonnet-20240620',
      model = 'gpt-4o',
      -- model = "o1-preview",
      -- timeout = 120000,
    },
    file_selector = {
      provider = 'telescope',
      -- Options override for custom providers
      provider_opts = {},
    },
    vendors = {
      openrouter = {
        __inherited_from = 'openai',
        endpoint = 'https://openrouter.ai/api/v1',
        api_key_name = 'OPENROUTER_API_KEY',
        model = '',
      },
      ollama = {
        __inherited_from = 'openai',
        api_key_name = '',
        endpoint = 'http://yetone-mac-mini:11434/v1',
        model = 'phi4',
      },
      mlc = {
        __inherited_from = 'openai',
        api_key_name = '',
        endpoint = 'http://yetone-mac-mini:8000/v1',
        model = 'qwen2.5-coder:32b',
      },
      groq = {
        __inherited_from = 'openai',
        api_key_name = 'GROQ_API_KEY',
        endpoint = 'https://api.groq.com/openai/v1/',
        model = 'llama-3.1-70b-versatile',
      },
      perplexity = {
        __inherited_from = 'openai',
        api_key_name = 'PPLX_API_KEY',
        endpoint = 'https://api.perplexity.ai',
        model = 'llama-3.1-sonar-large-128k-online',
      },
      deepseek = {
        __inherited_from = 'openai',
        api_key_name = 'DEEPSEEK_API_KEY',
        endpoint = 'https://api.deepseek.com',
        model = 'deepseek-coder',
      },
      qianwen = {
        __inherited_from = 'openai',
        api_key_name = 'DASHSCOPE_API_KEY',
        endpoint = 'https://dashscope.aliyuncs.com/compatible-mode/v1',
        model = 'qwen-coder-plus-latest',
      },
    },
    behaviour = {
      auto_focus_sidebar = true,
      auto_suggestions = true,
      minimize_diff = true,
    },
    windows = {
      position = 'smart',
      height = 46,
      wrap = true,
      sidebar_header = {
        align = 'center',
      },
      ask = {
        floating = false,
      },
    },
  },
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'stevearc/dressing.nvim',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'ibhagwan/fzf-lua',
    -- {
    --   'zbirenbaum/copilot.lua',
    --   config = function()
    --     require('copilot').setup({})
    --   end,
    -- },
    {
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { 'markdown', 'Avante' },
      },
      ft = { 'markdown', 'Avante' },
    },
  },
})
