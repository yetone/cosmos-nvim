local cosmos = require('core.cosmos')
local configs = require('layers.completion.configs')

cosmos.add_plugin('zbirenbaum/copilot.lua', {
  enabled = true,
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    require('copilot').setup({
      suggestion = {
        auto_trigger = false,
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
    adapters = {
      openai = function()
        return require('codecompanion.adapters').extend('openai', {
          schema = {
            model = {
              default = 'gpt-4o',
            },
          },
        })
      end,
      ollama = function()
        return require('codecompanion.adapters').extend('ollama', {
          env = {
            url = 'http://10.0.0.207:11434',
            -- api_key = "OLLAMA_API_KEY",
          },
          headers = {
            ['Content-Type'] = 'application/json',
            -- ["Authorization"] = "Bearer ${api_key}",
          },
          schema = {
            model = {
              default = 'devstral:24b',
            },
          },
          parameters = {
            sync = true,
          },
        })
      end,
    },
    strategies = {
      chat = {
        -- adapter = 'anthropic',
        -- adapter = 'openai',
        adapter = 'ollama',
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
  enabled = true,
  branch = 'main',
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

cosmos.add_plugin('ravitemer/mcphub.nvim', {
  dev = true,
  dir = os.getenv('HOME') .. '/workspace/projects/mcphub.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim', -- Required for Job and HTTP requests
  },
  build = 'npm install -g mcp-hub@latest', -- Installs required mcp-hub npm module
  config = function()
    require('mcphub').setup({
      -- Required options
      port = 3001, -- Port for MCP Hub server
      config = vim.fn.expand('~/mcpservers.json'), -- Absolute path to config file

      -- Optional options
      on_ready = function(hub)
        -- Called when hub is ready
      end,
      on_error = function(err)
        -- Called on errors
      end,
      shutdown_delay = 0, -- Wait 0ms before shutting down server after last client exits
      log = {
        level = vim.log.levels.WARN,
        to_file = false,
        file_path = nil,
        prefix = 'MCPHub',
      },
    })
  end,
})

-- cosmos.add_plugin('augmentcode/augment.vim')

cosmos.add_plugin('yetone/avante.nvim', {
  dev = local_avante_dir_exists,
  dir = local_avante_dir_exists and local_avante_dir or nil,
  event = 'VeryLazy',
  build = 'make',
  opts = {
    debug = true,
    mode = 'agentic',
    web_search_engine = {
      provider = 'serpapi',
    },
    rag_service = {
      enabled = false, -- Enables the rag service, requires OPENAI_API_KEY to be set
      provider = 'ollama',
      llm_model = 'llama3.2',
      embed_model = 'nomic-embed-text',
      endpoint = 'http://10.0.0.244:11434',
    },
    -- The system_prompt type supports both a string and a function that returns a string. Using a function here allows dynamically updating the prompt with mcphub
    -- system_prompt = function()
    --   local hub = require('mcphub').get_hub_instance()
    --   return hub:get_active_servers_prompt()
    -- end,
    -- -- The custom_tools type supports both a list and a function that returns a list. Using a function here prevents requiring mcphub before it's loaded
    -- custom_tools = function()
    --   return {
    --     require('mcphub.extensions.avante').mcp_tool(),
    --   }
    -- end,
    -- provider = 'copilot_gemini',
    -- provider = 'copilot_openai',
    -- provider = 'copilot:gpt-4.1',
    -- provider = 'openai-gpt-4o-mini',
    selector = {
      provider = 'snacks',
    },
    history = {
      -- carried_entry_count = 3,
    },
    provider = 'gemini',
    providers = {
      gemini_flash = {
        __inherited_from = 'gemini',
        model = 'gemini-2.5-flash-preview-05-20',
        timeout = 30000,
        extra_request_body = {
          generationConfig = {
            temperature = 0,
            -- max_tokens = 65536
          },
        },
      },
      ollama = {
        -- endpoint = 'http://10.0.0.244:11434',
        -- endpoint = 'http://10.0.0.207:11434',
        endpoint = 'http://100.92.182.127:11434',
        -- model = 'qwen3:14b',
        -- model = 'qwen2.5-coder:14b',
        -- model = 'hhao/qwen2.5-coder-tools:14b',
        model = 'devstral:24b',
      },
      aihubmix = {
        model = 'o3',
      },
      gemini = {
        model = 'gemini-2.5-pro-preview-06-05',
        -- model = 'gemini-2.5-flash-preview-04-17',
        -- api_key_name = 'cmd:security find-generic-password -s GEMINI_KEY -w',
      },
      ['gemini-2.0-flash'] = {
        __inherited_from = 'copilot',
        display_name = 'copilot/gemini-2.0-flash',
        model = 'gemini-2.0-flash-001',
        disable_tools = true,
      },
      ['copilot:gpt-4.1'] = {
        __inherited_from = 'copilot',
        model = 'gpt-4.1',
      },
      ['gemini_2.5_pro'] = {
        __inherited_from = 'openai',
        api_key_name = 'GEMINI_API_KEY',
        endpoint = 'https://generativelanguage.googleapis.com/v1beta',
        model = 'gemini-2.5-pro-exp-03-25',
      },
      ark = {
        __inherited_from = 'openai',
        api_key_name = 'ARK_API_KEY',
        endpoint = 'https://ark.cn-beijing.volces.com/api/v3',
        model = 'deepseek-v3-250324',
        extra_request_body = {
          max_completion_tokens = 12288,
        },
      },
      cursor_claude_3_5_sonnet = {
        __inherited_from = 'openai',
        api_key_name = 'CURSOR_REVERSE_API_KEY',
        endpoint = 'http://localhost:9999/v1',
        model = 'cursor/claude-3-5-sonnet-20241022',
      },
      cursor_deepseek_v3 = {
        __inherited_from = 'openai',
        api_key_name = 'CURSOR_REVERSE_API_KEY',
        endpoint = 'http://localhost:9999/v1',
        model = 'cursor/deepseek-v3',
        extra_request_body = {
          max_tokens = 32768, -- remember to increase this value, otherwise it will stop generating halfway
        },
        disable_tools = true,
      },
      claude_3_5_sonnet = {
        __inherited_from = 'claude',
        model = 'claude-3-5-sonnet-20241022',
        extra_request_body = {
          max_tokens = 8192,
        },
      },
      claude_sonnet_4 = {
        __inherited_from = 'claude',
        model = 'claude-sonnet-4-20250514',
        extra_request_body = {
          max_tokens = 8192,
        },
      },
      copilot_claude = {
        __inherited_from = 'copilot',
        model = 'claude-3.7-sonnet',
      },
      copilot_claude_3_5 = {
        __inherited_from = 'copilot',
        model = 'claude-3.5-sonnet',
      },
      copilot_claude_thought = {
        __inherited_from = 'copilot',
        model = 'claude-3.7-sonnet-thought',
        extra_request_body = {
          temperature = 1,
          max_tokens = 20000,
        },
      },
      copilot_openai = {
        __inherited_from = 'copilot',
        model = 'gpt-4o-2024-11-20',
        extra_request_body = {
          max_tokens = 12333,
        },
      },
      copilot_gemini = {
        __inherited_from = 'copilot',
        model = 'gemini-2.5-pro-preview-05-06',
      },
      copilot_o3_mini = {
        __inherited_from = 'copilot',
        model = 'o3-mini',
      },
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
        model = 'anthropic/claude-3.5-sonnet',
        -- model = 'openai/gpt-4o',
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
        model = 'deepseek-r1-distill-llama-70b',
        -- model = 'qwen-2.5-coder-32b',
      },
      groq = {
        __inherited_from = 'openai',
        api_key_name = 'GROQ_API_KEY',
        endpoint = 'https://api.groq.com/openai/v1/',
        -- model = 'deepseek-r1-distill-llama-70b',
        -- model = 'qwen-2.5-coder-32b',
        model = 'llama-3.3-70b-versatile',
        extra_request_body = {
          max_completion_tokens = 32768, -- remember to increase this value, otherwise it will stop generating halfway
        },
        disable_tools = true,
      },
      groq_qwq = {
        __inherited_from = 'openai',
        api_key_name = 'GROQ_API_KEY',
        endpoint = 'https://api.groq.com/openai/v1/',
        model = 'qwen-qwq-32b',
        extra_request_body = {
          max_completion_tokens = 32768, -- remember to increase this value, otherwise it will stop generating halfway
        },
        disable_tools = true,
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
        disable_tools = false,
      },
      qianwen = {
        __inherited_from = 'openai',
        api_key_name = 'DASHSCOPE_API_KEY',
        endpoint = 'https://dashscope.aliyuncs.com/compatible-mode/v1',
        model = 'qwen-coder-plus-latest',
        -- hide_in_model_selector = true,
      },
    },
    behaviour = {
      auto_focus_sidebar = true,
      auto_suggestions = use_avante_auto_suggestions,
      minimize_diff = true,
      enable_token_counting = true,
      use_cwd_as_project_root = true,
      auto_check_diagnostics = false,
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
    { 'echasnovski/mini.pick', config = true },
    {
      'folke/snacks.nvim',
      priority = 1000,
      lazy = false,
      ---@type snacks.Config
      opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        bigfile = { enabled = false },
        dashboard = { enabled = false },
        indent = { enabled = true },
        input = { enabled = false },
        picker = { enabled = true },
        notifier = { enabled = false },
        quickfile = { enabled = false },
        scroll = { enabled = false },
        statuscolumn = { enabled = false },
        words = { enabled = false },
      },
    },
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
