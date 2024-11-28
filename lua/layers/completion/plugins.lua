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
    })
  end,
})

cosmos.add_plugin('supermaven-inc/supermaven-nvim', {
  enabled = true,
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
    provider = 'copilot',
    auto_suggestions_provider = 'copilot',
    copilot = {
      model = 'claude-3.5-sonnet',
    },
    openai = {
      -- endpoint = 'https://aihubmix.com/v1',
      -- model = 'claude-3-5-sonnet-20240620',
      model = 'gpt-4o',
      -- model = "o1-preview",
      -- timeout = 120000,
    },
    vendors = {
      ollama = {
        __inherited_from = 'openai',
        api_key_name = '',
        endpoint = 'http://yetone-mac-mini:11434/v1',
        model = 'qwen2.5-coder:14b',
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
      auto_suggestions = false,
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
