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
  enabled = false,
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
      http = {
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
  enabled = false, -- paused: do not install/start MCPHub
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
      auto_approve = true,
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
  enabled = false, -- paused: copilot provider fails (no hosts.json/apps.json, only auth.db)
  dev = local_avante_dir_exists,
  dir = local_avante_dir_exists and local_avante_dir or nil,
  event = 'VeryLazy',
  build = 'make',
  opts = {
    disabled_tools = { 'run_python' },
    debug = false,
    mode = 'agentic',
    rag_service = {
      enabled = false, -- Enables the RAG service
      host_mount = os.getenv('HOME'),
      runner = 'docker',
      llm = {
        provider = 'ollama',
        endpoint = 'http://10.0.0.244:11434',
        api_key = '',
        model = 'llama3.2',
        extra = nil,
      },
      embed = {
        provider = 'ollama',
        endpoint = 'http://10.0.0.244:11434',
        api_key = '',
        model = 'nomic-embed-text',
        extra = nil,
      },
      docker_extra_args = '',
    },
    -- The system_prompt type supports both a string and a function that returns a string. Using a function here allows dynamically updating the prompt with mcphub
    system_prompt = function()
      local ok, mcphub = pcall(require, 'mcphub')
      if not ok then
        return ''
      end
      local hub = mcphub.get_hub_instance()
      return hub and hub:get_active_servers_prompt() or ''
    end,
    -- The custom_tools type supports both a list and a function that returns a list. Using a function here prevents requiring mcphub before it's loaded
    custom_tools = function()
      local ok, avante_ext = pcall(require, 'mcphub.extensions.avante')
      if not ok then
        return {}
      end
      return {
        avante_ext.mcp_tool(),
      }
    end,
    provider = 'copilot',
    selector = {
      provider = 'snacks',
    },
    history = {
      -- carried_entry_count = 3,
    },
    behaviour = {
      auto_focus_sidebar = true,
      auto_suggestions = false,
      minimize_diff = true,
      enable_token_counting = true,
      use_cwd_as_project_root = true,
      auto_check_diagnostics = false,
      enable_fastapply = false,
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
      opts = function()
        -- Toggle the profiler
        Snacks.toggle.profiler():map('<leader>pk')
        -- Toggle the profiler highlights
        Snacks.toggle.profiler_highlights():map('<leader>ph')
        return {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
          bigfile = { enabled = false },
          dashboard = { enabled = false },
          explorer = { enabled = false },
          indent = { enabled = true },
          input = { enabled = false },
          picker = { enabled = true },
          notifier = { enabled = false },
          quickfile = { enabled = false },
          scope = { enabled = false },
          scroll = { enabled = false },
          statuscolumn = { enabled = false },
          words = { enabled = false },
        }
      end,
      keys = {
        {
          '<leader>ps',
          function()
            Snacks.profiler.scratch()
          end,
          desc = 'Profiler Scratch Bufer',
        },
      },
      ---@type snacks.Config
      -- opts = {
      --   -- your configuration comes here
      --   -- or leave it empty to use the default settings
      --   -- refer to the configuration section below
      --   bigfile = { enabled = false },
      --   dashboard = { enabled = false },
      --   explorer = { enabled = false },
      --   indent = { enabled = true },
      --   input = { enabled = false },
      --   picker = { enabled = true },
      --   notifier = { enabled = false },
      --   quickfile = { enabled = false },
      --   scope = { enabled = false },
      --   scroll = { enabled = false },
      --   statuscolumn = { enabled = false },
      --   words = { enabled = false },
      -- },
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
