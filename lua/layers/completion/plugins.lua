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
  opts = {
    display = {
      diff = {
        enabled = true,
        provider = 'default',
      },
    },
    opts = {
      log_level = 'DEBUG',
    },
    strategies = {
      chat = {
        adapter = 'anthropic',
      },
    },
  },
})

local use_avante_auto_suggestions = false

cosmos.add_plugin('supermaven-inc/supermaven-nvim', {
  enabled = not use_avante_auto_suggestions,
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
    web_search_engine = {
      provider = 'serpapi',
    },
    rag_service = {
      enabled = true, -- Enables the rag service, requires OPENAI_API_KEY to be set
      provider = 'ollama',
      llm_model = 'llama3.2',
      embed_model = 'nomic-embed-text',
      endpoint = 'http://10.0.0.249:11434',
    },
    provider = 'bedrock',
    claude = {
      temperature = 1,
      max_tokens = 20000,
      -- thinking = {
      --     type = 'enabled',
      --     budget_tokens = 16000,
      -- },
    },
    auto_suggestions_provider = 'ollama',
    cursor_applying_provider = 'groq',
    memory_summary_provider = 'openai-gpt-4o-mini',
    -- highlights = {
    --     diff = {
    --         current = "DiffText",
    --         incoming = "DiffAdd",
    --     },
    -- },
    copilot = {
      model = 'claude-3.5-sonnet',
    },
    gemini = {
      model = 'gemini-2.0-flash',
      -- model = 'gemini-2.0-flash-exp',
      -- model = 'gemini-2.0-pro-exp',
      -- model = 'gemini-2.0-flash-thinking-exp-1219',
    },
    openai = {
      -- endpoint = 'https://api.gptsapi.net/v1',
      -- endpoint = 'https://aihubmix.com/v1',
      -- model = 'claude-3-5-sonnet-20240620',
      model = 'gpt-4o',
      -- model = 'o3-mini',
      -- api_key_name = 'GPTSAPI_API_KEY',
      -- model = "o1-preview",
      -- timeout = 120000,
    },
    file_selector = {
      provider = 'telescope',
      -- Options override for custom providers
      provider_opts = {},
    },
    vendors = {
      together = {
        __inherited_from = 'openai',
        endpoint = 'https://api.together.xyz/v1',
        api_key_name = 'TOGETHER_API_KEY',
        model = 'deepseek-ai/DeepSeek-R1',
        disable_tools = true,
      },
      siliconflow = {
        __inherited_from = 'openai',
        endpoint = 'https://api.siliconflow.cn/v1',
        api_key_name = 'SILICONFLOW_API_KEY',
        model = 'Pro/deepseek-ai/DeepSeek-R1',
        disable_tools = true,
      },
      mistral = {
        __inherited_from = 'openai',
        endpoint = 'https://api.mistral.ai/v1',
        api_key_name = 'MISTRAL_API_KEY',
        model = 'codestral-latest',
      },
      openrouter = {
        __inherited_from = 'openai',
        endpoint = 'https://openrouter.ai/api/v1',
        api_key_name = 'OPENROUTER_API_KEY',
        -- model = 'deepseek/deepseek-r1',
        -- model = 'anthropic/claude-3.5-sonnet',
        model = 'openai/gpt-4o',
        disable_tools = true,
      },
      ollama = {
        __inherited_from = 'openai',
        api_key_name = '',
        endpoint = 'http://yetone-mac-mini.local:11434/v1',
        -- model = 'deepseek-r1:7b',
        model = 'qwen2.5-coder:14b',
        -- model = 'llama3.2:latest',
      },
      fastapply = {
        __inherited_from = 'openai',
        api_key_name = '',
        endpoint = 'http://yetone-mac-mini.local:11434/v1',
        model = 'hf.co/Kortix/FastApply-7B-v1.0_GGUF:Q4_K_M',
        -- model = 'hf.co/Kortix/FastApply-1.5B-v1.0_GGUF:F16',
      },
      mlc = {
        __inherited_from = 'openai',
        api_key_name = '',
        endpoint = 'http://yetone-mac-mini:8000/v1',
        model = 'qwen2.5-coder:32b',
      },
      groq_deepseek = {
        __inherited_from = 'openai',
        api_key_name = 'GROQ_API_KEY',
        endpoint = 'https://api.groq.com/openai/v1/',
        model = 'deepseek-r1-distill-qwen-32b',
        -- model = 'qwen-2.5-coder-32b',
      },
      groq = {
        __inherited_from = 'openai',
        api_key_name = 'GROQ_API_KEY',
        endpoint = 'https://api.groq.com/openai/v1/',
        -- model = 'deepseek-r1-distill-llama-70b',
        -- model = 'qwen-2.5-coder-32b',
        model = 'llama-3.3-70b-versatile',
        max_tokens = 32768, -- remember to increase this value, otherwise it will stop generating halfway
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
        model = 'deepseek-reasoner',
        disable_tools = true,
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
      auto_suggestions = use_avante_auto_suggestions,
      minimize_diff = true,
      enable_token_counting = true,
      enable_cursor_planning_mode = true,
      use_cwd_as_project_root = true,
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
    'echasnovski/mini.pick',
    -- {
    --     "folke/snacks.nvim",
    --     priority = 1000,
    --     lazy = false,
    --     ---@type snacks.Config
    --     opts = {
    --         -- your configuration comes here
    --         -- or leave it empty to use the default settings
    --         -- refer to the configuration section below
    --         bigfile = { enabled = true },
    --         dashboard = { enabled = false },
    --         indent = { enabled = true },
    --         input = { enabled = true },
    --         picker = { enabled = true },
    --         notifier = { enabled = true },
    --         quickfile = { enabled = true },
    --         scroll = { enabled = true },
    --         statuscolumn = { enabled = true },
    --         words = { enabled = true },
    --     },
    -- },
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
