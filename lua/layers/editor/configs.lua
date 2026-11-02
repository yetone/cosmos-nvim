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

  require('mason-registry'):on('package:install:success', function()
    vim.defer_fn(function()
      require('lazy.core.handler.event').trigger({
        event = 'FileType',
        buffer = vim.api.nvim_get_current_buf(),
      })
    end, 100)
  end)

  vim.lsp.config('*', {
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
  })

  local server_opts = {
    lua_ls = {
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
            special = { reload = 'require' },
          },
          workspace = { checkThirdParty = false },
          codeLens = { enable = true },
          completion = { callSnippet = 'Replace' },
          doc = { privateName = { '^_' } },
          hint = {
            enable = true,
            setType = false,
            paramType = true,
            paramName = 'Disable',
            semicolon = 'Disable',
            arrayIndex = 'Disable',
          },
        },
      },
    },
  }

  for server_name, server_opt in pairs(server_opts) do
    vim.lsp.config(server_name, server_opt)
  end

  require('mason-lspconfig').setup({
    automatic_enable = {
      exclude = {
        'rust_analyzer',
        'stylua',
      },
    },
  })

  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('cosmos_lsp_attach', { clear = true }),
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      local buf = args.buf
      if not client then
        return
      end
      if
        client:supports_method('textDocument/inlayHint', buf)
        and vim.bo[buf].buftype == ''
        and not vim.tbl_contains({ 'vue' }, vim.bo[buf].filetype)
      then
        vim.lsp.inlay_hint.enable(true, { bufnr = buf })
      end
    end,
  })
end

function configs.conform()
  -- https://biomejs.dev/internals/language-support/
  local biome_fts = {
    'astro',
    'css',
    'scss',
    'graphql',
    'javascript',
    'javascriptreact',
    'json',
    'jsonc',
    'svelte',
    'typescript',
    'typescriptreact',
    'vue',
  }

  local formatters_by_ft = {
    lua = { 'stylua' },
    sh = { 'shfmt' },
    bash = { 'shfmt' },
  }
  for _, ft in ipairs(biome_fts) do
    formatters_by_ft[ft] = { 'biome-check' }
  end

  require('conform').setup({
    default_format_opts = {
      timeout_ms = 3000,
      async = false,
      quiet = false,
      lsp_format = 'fallback',
    },
    formatters_by_ft = formatters_by_ft,
    formatters = {
      ['biome-check'] = { require_cwd = true },
      injected = { options = { ignore_errors = true } },
    },
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
      keys = {
        quit = '<ESC>',
        exec = '<CR>',
      },
    },
  })
end

function configs.treesitter()
  local treesitter = require('nvim-treesitter')
  local install_dir = vim.fn.stdpath('data') .. '/site'

  treesitter.setup({
    install_dir = install_dir,
  })

  local parsers = {
    'bash',
    'c',
    'cpp',
    'css',
    'go',
    'html',
    'javascript',
    'json',
    'lua',
    'luadoc',
    'markdown',
    'markdown_inline',
    'python',
    'query',
    'rust',
    'tsx',
    'typescript',
    'vim',
    'vimdoc',
    'yaml',
  }

  if vim.fn.executable('tree-sitter') == 1 then
    local installed = {}
    for _, parser in ipairs(treesitter.get_installed('parsers')) do
      installed[parser] = true
    end

    local missing = vim.tbl_filter(function(parser)
      return not installed[parser]
    end, parsers)

    if #missing > 0 then
      treesitter.install(missing, { summary = false })
    end
  end

  vim.treesitter.language.register('bash', 'sh')
  vim.treesitter.language.register('tsx', 'typescriptreact')
  vim.treesitter.language.register('javascript', 'javascriptreact')

  local function parser_available(lang)
    return #vim.api.nvim_get_runtime_file('parser/' .. lang .. '.*', false) > 0
  end

  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('cosmos_treesitter', { clear = true }),
    callback = function(args)
      local ft = vim.bo[args.buf].filetype
      local lang = vim.treesitter.language.get_lang(ft)

      if not lang or not parser_available(lang) then
        return
      end

      vim.treesitter.language.add(lang)
      vim.treesitter.start(args.buf, lang)
    end,
  })
end

function configs.treesitter_textobjects()
  require('nvim-treesitter-textobjects').setup({
    select = {
      lookahead = true,
    },
    move = {
      set_jumps = true,
    },
  })

  local select = require('nvim-treesitter-textobjects.select')
  local swap = require('nvim-treesitter-textobjects.swap')
  local move = require('nvim-treesitter-textobjects.move')

  local function map(modes, lhs, rhs, desc)
    vim.keymap.set(modes, lhs, rhs, {
      desc = desc,
      silent = true,
    })
  end

  local select_keymaps = {
    { 'af', '@function.outer', 'Select outer function' },
    { 'if', '@function.inner', 'Select inner function' },
    { 'ac', '@conditional.outer', 'Select outer conditional' },
    { 'ic', '@conditional.inner', 'Select inner conditional' },
    { 'ai', '@call.outer', 'Select outer call' },
    { 'ii', '@call.inner', 'Select inner call' },
    { 'ab', '@block.outer', 'Select outer block' },
    { 'ib', '@block.inner', 'Select inner block' },
    { 'is', '@statement.inner', 'Select inner statement' },
    { 'as', '@statement.outer', 'Select outer statement' },
    { 'aC', '@class.outer', 'Select outer class' },
    { 'iC', '@class.inner', 'Select inner class' },
    { 'al', '@loop.outer', 'Select outer loop' },
    { 'il', '@loop.inner', 'Select inner loop' },
  }

  for _, keymap in ipairs(select_keymaps) do
    local lhs, query, desc = keymap[1], keymap[2], keymap[3]
    map({ 'x', 'o' }, lhs, function()
      select.select_textobject(query, 'textobjects')
    end, desc)
  end

  map('n', '<leader>a', function()
    swap.swap_next('@parameter.inner')
  end, 'Swap with next parameter')
  map('n', '<leader>A', function()
    swap.swap_previous('@parameter.inner')
  end, 'Swap with previous parameter')

  local move_keymaps = {
    { ']m', move.goto_next_start, '@function.outer', 'textobjects', 'Next function start' },
    { ']]', move.goto_next_start, '@class.outer', 'textobjects', 'Next class start' },
    { ']o', move.goto_next_start, { '@loop.inner', '@loop.outer' }, 'textobjects', 'Next loop start' },
    { ']s', move.goto_next_start, '@local.scope', 'locals', 'Next scope' },
    { ']z', move.goto_next_start, '@fold', 'folds', 'Next fold' },
    { ']M', move.goto_next_end, '@function.outer', 'textobjects', 'Next function end' },
    { '][', move.goto_next_end, '@class.outer', 'textobjects', 'Next class end' },
    { '[m', move.goto_previous_start, '@function.outer', 'textobjects', 'Previous function start' },
    { '[[', move.goto_previous_start, '@class.outer', 'textobjects', 'Previous class start' },
    { '[M', move.goto_previous_end, '@function.outer', 'textobjects', 'Previous function end' },
    { '[]', move.goto_previous_end, '@class.outer', 'textobjects', 'Previous class end' },
    { ']d', move.goto_next, '@conditional.outer', 'textobjects', 'Next conditional' },
    { '[d', move.goto_previous, '@conditional.outer', 'textobjects', 'Previous conditional' },
  }

  for _, keymap in ipairs(move_keymaps) do
    local lhs, fn, query, query_group, desc = keymap[1], keymap[2], keymap[3], keymap[4], keymap[5]
    map({ 'n', 'x', 'o' }, lhs, function()
      fn(query, query_group)
    end, desc)
  end
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

  -- telescope.load_extension('projects')
  telescope.load_extension('cmdline')
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
  require('trouble').setup({})
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

function configs.autotag()
  require('nvim-ts-autotag').setup()
end

function configs.telescope_undo(_, opts)
  require('telescope').setup(opts)
  require('telescope').load_extension('undo')
end

function configs.surround()
  require('nvim-surround').setup()
end

return configs
