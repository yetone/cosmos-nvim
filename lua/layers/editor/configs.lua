local configs = {}

function configs.mason()
  require("mason").setup({
      ui = {
        keymaps = {
          -- Keymap to expand a package
          toggle_package_expand = "<CR>",
          -- Keymap to install the package under the current cursor position
          install_package = "i",
          -- Keymap to reinstall/update the package under the current cursor position
          update_package = "u",
          -- Keymap to check for new version for the package under the current cursor position
          check_package_version = "c",
          -- Keymap to update all installed packages
          update_all_packages = "U",
          -- Keymap to check which installed packages are outdated
          check_outdated_packages = "C",
          -- Keymap to uninstall a package
          uninstall_package = "X",
          -- Keymap to cancel a package installation
          cancel_installation = "<C-c>",
          -- Keymap to apply language filter
          apply_language_filter = "/",
        },
      }
    })
  require("mason-lspconfig").setup()

  local lspconfig = require("lspconfig")
  local lspconfig_configs = require('lspconfig.configs')
  if not lspconfig_configs.ls_emmet then
    lspconfig_configs.ls_emmet = {
      default_config = {
        cmd = { 'ls_emmet', '--stdio' };
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
        };
        root_dir = function(fname)
          return vim.loop.cwd()
        end;
        settings = {};
      };
    }
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  ---@diagnostic disable-next-line: unused-local
  local on_attach = function(client, bufnr)
    -- local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- local opts = { noremap=true, silent=true }
    -- buf_set_keymap('n', '==', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    -- buf_set_keymap('v', '=', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

    local has_illuminate, illuminate = pcall(require, 'illuminate')
    if has_illuminate then
      illuminate.on_attach(client)
    end
  end

  local default_opt = {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }

  local format_config = require 'layers.editor.format'

  local servers = {
    tsserver = {
      root_dir = lspconfig.util.root_pattern("tsconfig.json", "package.json", ".git"),
    },
    pyright = {
      filetypes = {"python"},
      init_options = {
        formatters = {
          black = {
            command = "black",
            args = {"--quiet", "-"},
            rootPatterns = {"pyproject.toml"},
          },
          formatFiletypes = {
            python = {"black"}
          }
        }
      },
    },
    efm = {
      filetypes = vim.tbl_keys(format_config),
      init_options = { documentFormatting = true },
      root_dir = lspconfig.util.root_pattern { '.git/', '.' },
      settings = { languages = format_config },
    },
  }

  local luadev = require('lua-dev')
  servers.sumneko_lua = luadev.setup(default_opt)

  require("mason-lspconfig").setup_handlers({
      -- The first entry (without a key) will be the default handler
      -- and will be called for each installed server that doesn't have
      -- a dedicated handler.
      function (server_name) -- default handler (optional)
        local opt = servers[server_name] or {}
        opt = vim.tbl_deep_extend('force', {}, default_opt, opt)
        lspconfig[server_name].setup(opt)
      end,
  })
end

function configs.project()
  local project = require("project_nvim")
  project.setup {
    exclude_dirs = { "*//*" },
    detection_methods = { "pattern" },
    patterns = { ".git", },
  }
end

function configs.lspsaga()
  local saga = require('lspsaga')
  saga.init_lsp_saga({
    code_action_prompt = { enable = false, },
    code_action_keys = {
      quit = {"q", "<ESC>"},
    },
    rename_action_keys = {
      quit = {"q", "<ESC>"},
    },
  })
end

function configs.lspfuzzy()
  local lspfuzzy = require('lspfuzzy')
  lspfuzzy.setup()
end

function configs.treesitter()
  local treesitter = require("nvim-treesitter.configs")
  local ui_options = require('layers.ui.options')
  treesitter.setup {
    autotag = {
      enable = true,
    },

    indent = {
      enable = false,
    },

    -- One of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = "all",

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

    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
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
end

function configs.telescope()
  local telescope = require("telescope")
  local options = require('layers.editor.options')

  local fb_actions = require "telescope".extensions.file_browser.actions

  local previewers = require('telescope.previewers')

  local new_maker = function(filepath, bufnr, opts)
    opts = opts or {}

    filepath = vim.fn.expand(filepath)
    vim.loop.fs_stat(filepath, function(_, stat)
      if not stat then return end
      if stat.size > 100000 then
        return
      else
        previewers.buffer_previewer_maker(filepath, bufnr, opts)
      end
    end)
  end

  local theme = options.telescope_theme
  telescope.setup {
    defaults = {
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },
      mappings = {
        i = {
          ["<C-a>"] = { "<esc>0i", type = "command" },
          ["<Esc>"] = require('telescope.actions').close
        },
      },
      selection_caret = "  ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      layout_strategy = "horizontal",
      layout_config = {
         horizontal = {
            prompt_position = "top",
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
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      path_display = { "smart" },
      winblend = 0,
      border = {},
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      color_devicons = true,
      use_less = true,
      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
      -- Developer configurations: Not meant for general override
      buffer_previewer_maker = new_maker,
    },
    extensions = {
      ['ui-select'] = {
        -- TODO: specify the cursor theme for codeaction only
        require("telescope.themes").get_cursor {},
      },
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
      fzf = {
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true,  -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      },
      media_files = {
        -- filetypes whitelist
        -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
        filetypes = {"png", "webp", "jpg", "jpeg"},
        find_cmd = "rg" -- find command (defaults to `fd`)
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
          return { prompt = prompt:gsub("%s", ".*") }
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
  }

  telescope.load_extension 'projects'
  telescope.load_extension 'file_browser'
  telescope.load_extension 'dap'
  telescope.load_extension 'media_files'
  telescope.load_extension 'ui-select'
  telescope.load_extension 'fzf'
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
  vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})
  vim.fn.sign_define('DapStopped', {text='👉', texthl='', linehl='', numhl=''})
  local dapui = require('dapui')
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
    layouts = {
      {
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
      {
        elements = { "repl" },
        size = 10,
        position = "bottom", -- Can be "left", "right", "top", "bottom"
      },
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
end

configs.dap_virtual_text = function()
  local dap_virtual_text = require('nvim-dap-virtual-text')
  dap_virtual_text.setup({ enabled = true, enabled_commands = true, all_frames = true })
end

configs.trouble = function()
  local trouble = require('trouble')
  trouble.setup({
    position = "bottom", -- position of the list can be: bottom, top, left, right
    height = 10, -- height of the trouble list when position is top or bottom
    width = 50, -- width of the list when position is left or right
    icons = true, -- use devicons for filenames
    mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
    fold_open = "", -- icon used for open folds
    fold_closed = "", -- icon used for closed folds
    group = true, -- group results by file
    padding = true, -- add an extra new line on top of the list
    action_keys = { -- key mappings for actions in the trouble list
        -- map to {} to remove a mapping, for example:
        -- close = {},
        close = "<esc>", -- close the list
        cancel = "q", -- cancel the preview and get back to your last window / buffer / cursor
        refresh = "r", -- manually refresh
        jump = {"<cr>", "<tab>"}, -- jump to the diagnostic or open / close folds
        open_split = { "<c-x>" }, -- open buffer in new split
        open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
        open_tab = { "<c-t>" }, -- open buffer in new tab
        jump_close = {"o"}, -- jump to the diagnostic and close the list
        toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
        toggle_preview = "P", -- toggle auto_preview
        hover = "K", -- opens a small popup with the full multiline message
        preview = "p", -- preview the diagnostic location
        close_folds = {"zM", "zm"}, -- close all folds
        open_folds = {"zR", "zr"}, -- open all folds
        toggle_fold = {"zA", "za"}, -- toggle fold of current file
        previous = "k", -- preview item
        next = "j" -- next item
    },
    indent_lines = true, -- add an indent guide below the fold icons
    auto_open = false, -- automatically open the list when you have diagnostics
    auto_close = false, -- automatically close the list when you have no diagnostics
    auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
    auto_fold = false, -- automatically fold a file trouble list at creation
    auto_jump = {"lsp_definitions"}, -- for the given modes, automatically jump if there is only a single result
    signs = {
        -- icons / text used for a diagnostic
        error = "",
        warning = "",
        hint = "",
        information = "",
        other = "﫠"
    },
    use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
  })
end

configs.nvimtree = function()
  local nvimtree = require('nvim-tree')
  nvimtree.setup({
    renderer = {
      add_trailing = false,
      highlight_git = false,
      highlight_opened_files = "none",
      root_folder_modifier = table.concat { ":t:gs?$?/..", string.rep(" ", 1000), "?:gs?^??" },
      icons = {
        show = {
          folder = true,
          file = true,
          git = true,
        },
        glyphs = {
          default = "",
          symlink = "",
          git = {
            deleted = "",
            ignored = "◌",
            renamed = "➜",
            staged = "✓",
            unmerged = "",
            unstaged = "✗",
            untracked = "★",
          },
          folder = {
            default = "",
            empty = "",
            empty_open = "",
            open = "",
            symlink = "",
            symlink_open = "",
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
    ignore_ft_on_setup = { "dashboard" },
    open_on_tab = false,
    hijack_cursor = true,
    hijack_unnamed_buffer_when_opening = false,
    update_cwd = true,
    update_focused_file = {
      enable = true,
      update_cwd = false,
    },
    diagnostics = {
      enable = true,
      icons = {
        hint = "",
        info = "",
        warning = "",
        error = "",
      }
    },
    git = {
      enable = true,
      ignore = true,
      timeout = 500,
    },
    view = {
      side = "left",
      width = 30,
      hide_root_folder = true,
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
      if term.direction == "horizontal" then
        return 17
      elseif term.direction == "vertical" then
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
  hop.setup { keys = 'etovxqpdygfblzhckisuran' }
end

configs.leap = function()
  local leap = require('leap')
  leap.setup {
    case_insensitive = false,
    special_keys = {
      repeat_search = '<enter>',
      next_match    = '<enter>',
      prev_match    = '<tab>',
      next_group    = '<space>',
      prev_group    = '<tab>',
      eol           = '<space>',
    },
  }
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

return configs
