local configs = {}

function configs.mason()
  require('mason').setup({
    ui = {
      keymaps = {
        -- Keymap to expand a package
        toggle_package_expand = '<CR>',
        -- Keymap to install the package under the current cursor position
        install_package = 'i',
        -- Keymap to reinstall/update the package under the current cursor position
        update_package = 'u',
        -- Keymap to check for new version for the package under the current cursor position
        check_package_version = 'c',
        -- Keymap to update all installed packages
        update_all_packages = 'U',
        -- Keymap to check which installed packages are outdated
        check_outdated_packages = 'C',
        -- Keymap to uninstall a package
        uninstall_package = 'X',
        -- Keymap to cancel a package installation
        cancel_installation = '<C-c>',
        -- Keymap to apply language filter
        apply_language_filter = '/',
      },
    },
  })

  require('mason-null-ls').setup({
    ensure_installed = nil,
    automatic_installation = false,
    automatic_setup = true,
  })
  require('null-ls').setup()
  -- require('mason-null-ls').setup_handlers()

  require('mason-lspconfig').setup()
  -- require('neodev').setup({
  --   library = { plugins = { 'nvim-dap-ui' }, types = true },
  -- })

  local lspconfig = require('lspconfig')
  local lspconfig_configs = require('lspconfig.configs')
  if not lspconfig_configs.golangcilsp then
    lspconfig_configs.golangcilsp = {
      default_config = {
        cmd = { 'golangci-lint-langserver' },
        root_dir = lspconfig.util.root_pattern('.git', 'go.mod'),
        init_options = {
          command = { 'golangci-lint', 'run', '--out-format', 'json', '--issues-exit-code=1' },
        },
      },
    }
  end
  if not lspconfig_configs.ls_emmet then
    lspconfig_configs.ls_emmet = {
      default_config = {
        cmd = { 'ls_emmet', '--stdio' },
        filetypes = {
          'html',
          'css',
          'scss',
          'javascript',
          'javascriptreact',
          'typescript',
          'typescriptreact',
          'haml',
          'xml',
          'xsl',
          'pug',
          'slim',
          'sass',
          'stylus',
          'less',
          'sss',
          'hbs',
          'handlebars',
        },
        ---@diagnostic disable-next-line: unused-local
        root_dir = function(fname)
          return vim.loop.cwd()
        end,
        settings = {},
      },
    }
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  ---@diagnostic disable-next-line: unused-local
  local on_attach = function(client, bufnr)
    -- local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...)
      vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- local opts = { noremap=true, silent=true }
    -- buf_set_keymap('n', '==', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    -- buf_set_keymap('v', '=', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    -- if client.supports_method('textDocument/formatting') then
    --   vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    --   vim.api.nvim_create_autocmd('BufWritePre', {
    --     group = augroup,
    --     buffer = bufnr,
    --     callback = function()
    --       -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
    --       if vim.fn.has('nvim-0.8') == 1 then
    --         vim.lsp.buf.format({ bufnr = bufnr })
    --       else
    --         vim.lsp.buf.formatting_sync()
    --       end
    --     end,
    --   })
    -- end
  end

  local default_opt = {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
  }

  local util = require('lspconfig.util')

  local server_opts = {
    tsserver = {
      root_dir = lspconfig.util.root_pattern('tsconfig.json', 'package.json', '.git'),
    },
    biome = {
      root_dir = function(fname)
        local root = util.root_pattern('biome.json', 'biome.jsonc')(fname)
        return root
      end,
    },
    golangci_lint_ls = {
      filetypes = { 'go', 'gomod' },
    },
    lua_ls = {
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
            special = { reload = 'require' },
          },
          workspace = {
            library = {
              vim.fn.expand('$VIMRUNTIME/lua'),
              vim.fn.expand('$VIMRUNTIME/lua/vim/lsp'),
              vim.fn.stdpath('data') .. '/lazy/lazy.nvim/lua/lazy',
              -- vim.fn.expand('$HOME/workspace/projects'), -- parent/avante.nvim
              '${3rd}/luv/library',
            },
          },
        },
      },
    },
  }

  -- Package installation folder
  local install_root_dir = vim.fn.stdpath('data') .. '/mason'

  require('mason-lspconfig').setup_handlers({
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
      local opt = server_opts[server_name] or {}
      opt = vim.tbl_deep_extend('force', {}, default_opt, opt)
      lspconfig[server_name].setup(opt)
    end,
    -- The following handlers will be called for the specified servers
    -- and will override the default handler for those servers.
    -- If a handler is not specified for a server, the default handler
    -- will be used.
    ['rust_analyzer'] = function()
      local opt = server_opts['rust_analyzer'] or {}
      opt = vim.tbl_deep_extend('force', {}, default_opt, opt)

      -- DAP settings - https://github.com/simrat39/rust-tools.nvim#a-better-debugging-experience
      local extension_path = install_root_dir .. '/packages/codelldb/extension/'
      local codelldb_path = extension_path .. 'adapter/codelldb'
      local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'
      local ih = require('inlay-hints')
      require('rust-tools').setup({
        tools = {
          hover_actions = { border = 'solid' },
          on_initialized = function()
            vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufEnter', 'CursorHold', 'InsertLeave' }, {
              pattern = { '*.rs' },
              callback = function()
                vim.lsp.codelens.refresh()
              end,
            })
            ih.set_all()
          end,
          inlay_hints = {
            auto = false,
          },
        },
        server = opt,
        dap = {
          adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path),
        },
      })
    end,
  })
end

function configs.project()
  local project = require('project_nvim')
  project.setup({
    exclude_dirs = { '*//*' },
    detection_methods = { 'pattern' },
    patterns = { '.git' },
  })
end

function configs.lspsaga()
  local saga = require('lspsaga')
  local ui_options = require('layers.ui.options')
  saga.setup({
    ui = {
      winblend = ui_options.transparency,
    },
    lightbulb = {
      enable = false,
    },
    symbol_in_winbar = {
      enable = false,
    },
    diagnostic = {
      border_follow = false,
      keys = {
        exec_action = 'o',
        quit = 'q',
        go_action = 'g',
      },
    },
    finder = {
      keys = {
        quit = { 'q', '<ESC>' },
      },
    },
    code_action = {
      show_server_name = true,
      keys = {
        quit = { 'q', '<ESC>' },
        exec = '<CR>',
      },
    },
    rename = {
      in_select = false,
      quit = '<ESC>',
      exec = '<CR>',
      confirm = '<CR>',
    },
  })
end

function configs.lspfuzzy()
  local lspfuzzy = require('lspfuzzy')
  lspfuzzy.setup()
end

function configs.treesitter()
  local treesitter = require('nvim-treesitter.configs')
  local ui_options = require('layers.ui.options')
  treesitter.setup({
    autotag = {
      enable = true,
    },
    indent = {
      enable = false,
    },
    -- One of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = 'all',
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
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = 'gnn',
        node_incremental = '.',
        scope_incremental = 'grc',
        node_decremental = ',',
      },
    },
    -- textsubjects = {
    --   enable = true,
    --   prev_selection = ',', -- (Optional) keymap to select the previous selection
    --   keymaps = {
    --     ['.'] = 'textsubjects-smart',
    --     -- [';'] = 'textsubjects-container-outer',
    --   },
    -- },

    textobjects = {
      select = {
        enable = true,
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@conditional.outer',
          ['ic'] = '@conditional.inner',
          ['ai'] = '@call.outer',
          ['ii'] = '@call.inner',
          ['ab'] = '@block.outer',
          ['ib'] = '@block.inner',
          ['is'] = '@statement.inner',
          ['as'] = '@statement.outer',
          ['aC'] = '@class.outer',
          ['iC'] = '@class.inner',
          ['al'] = '@loop.outer',
          ['il'] = '@loop.inner',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = { query = '@class.outer', desc = 'Next class start' },
          [']o'] = '@loop.*',
          [']s'] = { query = '@scope', query_group = 'locals', desc = 'Next scope' },
          [']z'] = { query = '@fold', query_group = 'folds', desc = 'Next fold' },
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
        goto_next = {
          [']d'] = '@conditional.outer',
        },
        goto_previous = {
          ['[d'] = '@conditional.outer',
        },
      },
      lsp_interop = {
        enable = true,
        border = 'none',
        peek_definition_code = {
          ['<leader>sd'] = '@function.outer',
          ['<leader>sD'] = '@class.outer',
        },
      },
    },
  })
end

function configs.telescope()
  local telescope = require('telescope')
  local options = require('layers.editor.options')
  local ui_options = require('layers.ui.options')

  local fb_actions = require('telescope').extensions.file_browser.actions

  local previewers = require('telescope.previewers')

  local new_maker = function(filepath, bufnr, opts)
    opts = opts or {}

    filepath = vim.fn.expand(filepath)
    vim.loop.fs_stat(filepath, function(_, stat)
      if not stat then
        return
      end
      if stat.size > 100000 then
        return
      else
        previewers.buffer_previewer_maker(filepath, bufnr, opts)
      end
    end)
  end

  local theme = options.telescope_theme
  telescope.setup({
    defaults = {
      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
      },
      mappings = {
        i = {
          ['<C-a>'] = { '<esc>0i', type = 'command' },
          ['<Esc>'] = require('telescope.actions').close,
        },
      },
      selection_caret = '  ',
      entry_prefix = '  ',
      initial_mode = 'insert',
      selection_strategy = 'reset',
      sorting_strategy = 'ascending',
      layout_strategy = 'horizontal',
      layout_config = {
        horizontal = {
          prompt_position = 'top',
          preview_width = 0.55,
          results_width = 0.8,
        },
        vertical = {
          mirror = false,
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },
      -- file_sorter = require("telescope.sorters").get_fuzzy_file,
      -- file_ignore_patterns = { "node_modules/", "\\.git/" },
      generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
      path_display = { 'smart' },
      winblend = ui_options.transparency,
      border = {},
      borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
      color_devicons = true,
      use_less = true,
      set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
      file_previewer = require('telescope.previewers').vim_buffer_cat.new,
      grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
      qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
      -- Developer configurations: Not meant for general override
      buffer_previewer_maker = new_maker,
    },
    extensions = {
      ['ui-select'] = {
        -- TODO: specify the cursor theme for codeaction only
        require('telescope.themes').get_cursor({}),
      },
      file_browser = {
        theme = theme,
        mappings = {
          ['i'] = {
            -- your custom insert mode mappings
            ['<C-h>'] = fb_actions.goto_parent_dir,
            ['<C-e>'] = fb_actions.rename,
            ['<C-c>'] = fb_actions.create,
          },
          ['n'] = {
            -- your custom normal mode mappings
          },
        },
      },
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      },
      media_files = {
        -- filetypes whitelist
        -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
        filetypes = { 'png', 'webp', 'jpg', 'jpeg' },
        find_cmd = 'rg', -- find command (defaults to `fd`)
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
        debounce = 100,
        theme = theme,
        on_input_filter_cb = function(prompt)
          -- AND operator for live_grep like how fzf handles spaces with wildcards in rg
          return { prompt = prompt:gsub('%s', '.*') }
        end,
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
  })

  telescope.load_extension('projects')
end

configs.dap = function()
  local dap = require('dap')
  for name, adapter in pairs(require('layers.editor.utils').get_dap_adapters()) do
    dap.adapters[name] = adapter
  end
  for name, configuration in pairs(require('layers.editor.utils').get_dap_configurations()) do
    dap.configurations[name] = configuration
  end
end

configs.dap_go = function()
  require('dap-go').setup()
end

configs.dapui = function()
  vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })
  vim.fn.sign_define('DapStopped', { text = '👉', texthl = '', linehl = '', numhl = '' })
  local dapui = require('dapui')
  dapui.setup()
end

configs.dap_virtual_text = function()
  local dap_virtual_text = require('nvim-dap-virtual-text')
  dap_virtual_text.setup({ enabled = true, enabled_commands = true, all_frames = true })
end

configs.trouble = function()
  local signs = {
    -- icons / text used for a diagnostic
    error = '󰅚',
    warning = '',
    -- for vim.fn.sign_define
    warn = '',
    hint = '',
    information = '',
    -- for vim.fn.sign_define
    info = '',
    other = '',
  }

  local trouble = require('trouble')
  trouble.setup({})

  for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type:gsub('^%l', string.upper)
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
end

configs.nvimtree = function()
  local nvimtree = require('nvim-tree')
  nvimtree.setup({
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    renderer = {
      add_trailing = false,
      highlight_git = false,
      highlight_opened_files = 'none',
      root_folder_label = false,
      root_folder_modifier = table.concat({ ':t:gs?$?/..', string.rep(' ', 1000), '?:gs?^??' }),
      icons = {
        show = {
          folder = true,
          file = true,
          git = true,
        },
        glyphs = {
          default = '',
          symlink = '',
          git = {
            deleted = '',
            ignored = '◌',
            renamed = '➜',
            staged = '✓',
            unmerged = '',
            unstaged = '✗',
            untracked = '★',
          },
          folder = {
            default = '',
            empty = '',
            empty_open = '',
            open = '',
            symlink = '',
            symlink_open = '',
          },
        },
      },
      indent_markers = {
        enable = true,
      },
    },
    filters = {
      dotfiles = false,
    },
    disable_netrw = true,
    hijack_netrw = true,
    -- ignore_ft_on_setup = { 'dashboard' },
    open_on_tab = false,
    hijack_cursor = true,
    hijack_unnamed_buffer_when_opening = false,
    update_cwd = true,
    update_focused_file = {
      enable = true,
      update_cwd = false,
      update_root = true,
    },
    diagnostics = {
      enable = true,
      icons = {
        hint = '',
        info = '',
        warning = '',
        error = '',
      },
    },
    git = {
      enable = true,
      ignore = true,
      timeout = 500,
    },
    view = {
      side = 'left',
      width = 30,
    },
    actions = {
      open_file = {
        resize_window = true,
      },
    },
  })
end

configs.toggleterm = function()
  local toggleterm = require('toggleterm')
  toggleterm.setup({
    size = function(term)
      if term.direction == 'horizontal' then
        return 17
      elseif term.direction == 'vertical' then
        return vim.o.columns * 0.4
      end
    end,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
    start_in_insert = true,
    insert_mappings = false, -- whether or not the open mapping applies in insert mode
    persist_size = false,
    direction = 'horizontal',
    close_on_exit = true,
    shell = vim.o.shell,
  })
end

configs.hop = function()
  local hop = require('hop')
  hop.setup({ keys = 'etovxqpdygfblzhckisuran' })
end

configs.leap = function()
  local leap = require('leap')
  leap.set_default_keymaps()
end

configs.numb = function()
  local numb = require('numb')
  numb.setup()
end

configs.spellsitter = function()
  local spellsitter = require('spellsitter')
  spellsitter.setup({
    enable = true,
  })
end

function configs.osc52()
  local function copy(lines, _)
    require('osc52').copy(table.concat(lines, '\n'))
  end

  local function paste()
    return { vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('') }
  end

  vim.g.clipboard = {
    name = 'osc52',
    copy = { ['+'] = copy, ['*'] = copy },
    paste = { ['+'] = paste, ['*'] = paste },
  }
  vim.opt.clipboard:append('unnamedplus')
end

function configs.auto_save()
  require('auto-save').setup()
end

function configs.window_picker()
  require('window-picker').setup({
    hint = 'floating-big-letter',
    show_prompt = false,
  })
end

function configs.guess_indent()
  require('guess-indent').setup()
end

function configs.telescope_fzf()
  require('telescope').load_extension('fzf')
end

function configs.telescope_frecency()
  require('telescope').load_extension('frecency')
end

function configs.telescope_media_files()
  require('telescope').load_extension('media_files')
end

function configs.telescope_file_browser()
  require('telescope').load_extension('file_browser')
end

function configs.telescope_zoxide()
  require('telescope').load_extension('zoxide')
end

function configs.telescope_dap()
  require('telescope').load_extension('dap')
end

function configs.telescope_ui_select()
  require('telescope').load_extension('ui-select')
end

function configs.comment()
  require('Comment').setup()
end

function configs.glance()
  local glance = require('glance')
  local actions = glance.actions
  glance.setup({
    mappings = {
      list = {
        ['j'] = actions.next, -- Bring the cursor to the next item in the list
        ['k'] = actions.previous, -- Bring the cursor to the previous item in the list
        ['<C-n>'] = actions.next_location, -- Bring the cursor to the next item in the list
        ['<C-p>'] = actions.previous_location, -- Bring the cursor to the previous item in the list
        ['<Down>'] = actions.next,
        ['<Up>'] = actions.previous,
        ['<Tab>'] = actions.next, -- Bring the cursor to the next location skipping groups in the list
        ['<S-Tab>'] = actions.previous, -- Bring the cursor to the previous location skipping groups in the list
        ['<C-u>'] = actions.preview_scroll_win(5),
        ['<C-d>'] = actions.preview_scroll_win(-5),
        ['v'] = actions.jump_vsplit,
        ['s'] = actions.jump_split,
        ['t'] = actions.jump_tab,
        ['<CR>'] = actions.jump,
        ['<C-m>'] = actions.jump,
        ['o'] = actions.jump,
        ['<leader>l'] = actions.enter_win('preview'), -- Focus preview window
        ['q'] = actions.close,
        ['Q'] = actions.close,
        ['<Esc>'] = actions.close,
        -- ['<Esc>'] = false -- disable a mapping
      },
      preview = {
        ['Q'] = actions.close,
        ['<Tab>'] = actions.next_location,
        ['<S-Tab>'] = actions.previous_location,
        ['<leader>l'] = actions.enter_win('list'), -- Focus list window
      },
    },
  })
end

function configs.readline()
  local readline = require('readline')
  vim.keymap.set('!', '<M-f>', readline.forward_word)
  vim.keymap.set('!', '<M-b>', readline.backward_word)
  vim.keymap.set('!', '<C-a>', readline.beginning_of_line)
  vim.keymap.set('!', '<C-e>', readline.end_of_line)
  vim.keymap.set('!', '<M-d>', readline.kill_word)
  vim.keymap.set('!', '<M-BS>', readline.backward_kill_word)
  vim.keymap.set('!', '<C-w>', readline.unix_word_rubout)
  vim.keymap.set('!', '<C-k>', readline.kill_line)
  vim.keymap.set('!', '<C-u>', readline.backward_kill_line)
end

function configs.inlay_hints()
  require('inlay-hints').setup()
end

function configs.bookmarks()
  require('bookmarks').setup({
    json_db_path = vim.fs.normalize(vim.fn.stdpath('config') .. '/bookmarks.db.json'),
  })
end

function configs.refactoring()
  require('refactoring').setup()
end

function configs.smart_open()
  require('telescope').load_extension('smart_open')
end

function configs.ts_context_commentstring()
  require('ts_context_commentstring').setup()
end

function configs.telescope_undo(_, opts)
  require('telescope').setup(opts)
  require('telescope').load_extension('undo')
end

function configs.surround()
  require('nvim-surround').setup()
end

return configs
