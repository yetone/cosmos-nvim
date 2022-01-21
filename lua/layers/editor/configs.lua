local configs = {}

function configs.lsp_installer()
  require('core.utils').safe_require('nlspsettings', function(nlspsettings)
    nlspsettings.setup({
      config_home = vim.fn.stdpath('config') .. '/nlsp-settings',
      local_settings_root_markers = { '.git' },
      jsonls_append_default_schemas = true
    })
  end)

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  require('core.utils').safe_require('cmp_nvim_lsp', function(cmp_nvim_lsp)
    capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
  end)
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  ---@diagnostic disable-next-line: unused-local
  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', '==', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    buf_set_keymap('v', '=', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

    require('core.utils').safe_require('illuminate', function(illuminate)
      illuminate.on_attach(client)
    end, { silent = true })
  end

  require('core.utils').safe_require('nvim-lsp-installer', function(lsp_installer)
    local opt = {
      capabilities = capabilities,
      on_attach = on_attach,
      flags = {
        debounce_text_changes = 150,
      }
    }
    lsp_installer.on_server_ready(function(server)
      if server.name == 'sumneko_lua' then
        opt = require('core.utils').safe_require('lua-dev', function(luadev)
          local opt_ = luadev.setup()
          return vim.tbl_deep_extend('force', opt_, opt)
        end) or opt
      end
      server:setup(opt)
    end)
  end)
end

function configs.fterm()
  require('core.utils').safe_require('FTerm', function(fterm)
    fterm.setup({
      ft = 'FTerm',
      cmd = 'TERM=xterm-256color ' .. os.getenv('SHELL'),
      border = 'double',
      dimensions  = {
        height = 0.9,
        width = 0.9,
      },
    })
  end)
end

function configs.project()
  require('core.utils').safe_require('project_nvim', function(project)
    project.setup {
      exclude_dirs = { "*//*" },
      detection_methods = { "pattern" },
      patterns = { ".git", },
    }
  end)
end

function configs.lspsaga()
  require('core.utils').safe_require('lspsaga', function(saga)
    saga.init_lsp_saga({
      code_action_keys = {
        quit = {"q", "<ESC>"},
      },
      rename_action_keys = {
        quit = {"q", "<ESC>"},
      },
    })
  end)
end

function configs.lspfuzzy()
  require('core.utils').safe_require('lspfuzzy', function(lspfuzzy)
    lspfuzzy.setup {}
  end)
end

function configs.treesitter()
  require('core.utils').safe_require('nvim-treesitter.configs', function(treesitter)
    local options = require('layers.editor.options')
    local ui_options = require('layers.ui.options')
    treesitter.setup {
      -- One of "all", "maintained" (parsers with maintainers), or a list of languages
      ensure_installed = "maintained",

      -- Install languages synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- List of parsers to ignore installing
      ignore_install = {},

      playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
          toggle_query_editor = 'o',
          toggle_hl_groups = 'i',
          toggle_injected_languages = 't',
          toggle_anonymous_nodes = 'a',
          toggle_language_display = 'I',
          focus_language = 'f',
          unfocus_language = 'F',
          update = 'R',
          goto_node = '<cr>',
          show_help = '?',
        },
      },

      highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- list of language that will be disabled
        disable = {},

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },

      rainbow = {
        enable = ui_options.enable_rainbow,
        -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
        -- colors = {}, -- table of hex strings
        -- termcolors = {} -- table of colour name strings
      },

      context_commentstring = {
        enable = true
      },

      textsubjects = {
        enable = true,
        prev_selection = ',', -- (Optional) keymap to select the previous selection
        keymaps = {
          ['.'] = 'textsubjects-smart',
          -- [';'] = 'textsubjects-container-outer',
        },
      },

      textobjects = {
        select = {
          enable = true,
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@conditional.outer",
            ["ic"] = "@conditional.inner",
            ["ai"] = "@call.outer",
            ["ii"] = "@call.inner",
            ["ab"] = "@block.outer",
            ["ib"] = "@block.inner",
            ["is"] = "@statement.inner",
            ["as"] = "@statement.outer",
            ["aC"] = "@class.outer",
            ["iC"] = "@class.inner",
            ["al"] = "@loop.outer",
            ["il"] = "@loop.inner",
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>a"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>A"] = "@parameter.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
        },
        lsp_interop = {
          enable = true,
          border = 'none',
          peek_definition_code = {
            ["<leader>sd"] = "@function.outer",
            ["<leader>sD"] = "@class.outer",
          },
        },
      },
    }
  end)
end

function configs.telescope()
  require('core.utils').safe_require('telescope', function(telescope)
    local options = require('layers.editor.options')
    telescope.load_extension 'projects'
    telescope.load_extension 'file_browser'
    telescope.load_extension 'dap'

    local fb_actions = require "telescope".extensions.file_browser.actions

    local theme = options.telescope_theme
    telescope.setup {
      defaults = {
        mappings = {
          i = {
            ["<C-a>"] = { "<esc>0i", type = "command" },
            ["<Esc>"] = require('telescope.actions').close
          },
        },
        file_ignore_patterns = { "node_modules", ".git" },
      },
      extensions = {
        file_browser = {
          theme = theme,
          mappings = {
            ["i"] = {
              -- your custom insert mode mappings
              ["<C-h>"] = fb_actions.goto_parent_dir,
              ["<C-e>"] = fb_actions.rename,
              ["<C-c>"] = fb_actions.create,
            },
            ["n"] = {
              -- your custom normal mode mappings
            },
          },
        },
      },
      pickers = {
        buffers = {
          theme = theme,
        },
        find_files = {
          theme = theme,
          hidden = true,
        },
        oldfiles = {
          theme = theme,
          hidden = true,
        },
        live_grep = {
          theme = theme,
        },
        current_buffer_fuzzy_find = {
          theme = theme,
        },
        commands = {
          theme = theme,
        },
        lsp_document_symbols = {
          theme = theme,
        },
        diagnostics = {
          theme = theme,
          initial_mode = 'normal',
        },
        lsp_references = {
          theme = 'cursor',
          initial_mode = 'normal',
          layout_config = {
            width = 0.8,
            height = 0.4,
          },
        },
        lsp_code_actions = {
          theme = 'cursor',
          initial_mode = 'normal',
        },
      },
    }
  end)
end

configs.dap = function()
  require('core.utils').safe_require('dap', function(dap)
    for name, adapter in pairs(require('layers.editor.utils').get_dap_adapters()) do
      dap.adapters[name] = adapter
    end
    for name, configuration in pairs(require('layers.editor.utils').get_dap_configurations()) do
      dap.configurations[name] = configuration
    end
  end)
end

configs.dap_install = function()
  require('core.utils').safe_require('dap-install', function(dap_install)
    dap_install.setup({
      installation_path = vim.fn.stdpath("data") .. "/dapinstall/",
    })
  end)
end

configs.dapui = function()
  vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})
  vim.fn.sign_define('DapStopped', {text='👉', texthl='', linehl='', numhl=''})
  require('core.utils').safe_require('dapui', function(dapui)
    dapui.setup({
      icons = { expanded = "▾", collapsed = "▸" },
      mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
      },
      sidebar = {
        -- You can change the order of elements in the sidebar
        elements = {
          -- Provide as ID strings or tables with "id" and "size" keys
          {
            id = "scopes",
            size = 0.25, -- Can be float or integer > 1
          },
          { id = "breakpoints", size = 0.25 },
          { id = "stacks", size = 0.25 },
          { id = "watches", size = 00.25 },
        },
        size = 40,
        position = "left", -- Can be "left", "right", "top", "bottom"
      },
      tray = {
        elements = { "repl" },
        size = 10,
        position = "bottom", -- Can be "left", "right", "top", "bottom"
      },
      floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        border = "single", -- Border style. Can be "single", "double" or "rounded"
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
      windows = { indent = 1 },
    })
  end)
end

configs.dap_virtual_text = function()
  require('core.utils').safe_require('nvim-dap-virtual-text', function(dap_virtual_text)
    dap_virtual_text.setup({ enabled = true, enabled_commands = true, all_frames = true })
  end)
end

return configs
