local cosmos = require('core.cosmos')
local options = require('layers.ui.options')
local configs = require('layers.ui.configs')

cosmos.add_plugin('nvim-tree/nvim-web-devicons', {
  config = configs.web_devicons,
})

cosmos.add_plugin('nvimdev/dashboard-nvim', {
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'VimEnter',
  config = configs.dashboard,
})

-- cosmos.add_plugin('lukas-reineke/indent-blankline.nvim', {
--   config = configs.indent_blankline,
--   main = 'ibl',
--   event = 'BufRead',
-- })

cosmos.add_plugin('echasnovski/mini.indentscope', {
  enabled = false,
  version = false,
  opts = {
    symbol = '│',
    -- symbol = '▎',
  },
})

cosmos.add_plugin('huy-hng/anyline.nvim', {
  enabled = true,
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  opts = {
    indent_char = '▎',
    highlight = 'IndentBlanklineChar',
    context_highlight = 'IndentBlanklineContextChar',
  },
  event = 'VeryLazy',
})

cosmos.add_plugin('folke/todo-comments.nvim', {
  enabled = options.enable_todo_comments,
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = configs.todo_comments,
  event = 'BufRead',
})

-- cosmos.add_plugin('p00f/nvim-ts-rainbow', {
--   dependencies = { 'nvim-treesitter/nvim-treesitter' },
--   event = 'BufRead',
-- })

cosmos.add_plugin('nvim-lualine/lualine.nvim', {
  dependencies = { 'nvim-tree/nvim-web-devicons', 'SmiteshP/nvim-navic' },
  config = configs.lualine,
  event = { 'BufRead', 'VimEnter' },
})

cosmos.add_plugin('j-hui/fidget.nvim', {
  dependencies = { 'nvim-lualine/lualine.nvim' },
  config = configs.fidget,
  event = 'BufRead',
})

cosmos.add_plugin('akinsho/bufferline.nvim', {
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  branch = 'main',
  config = configs.bufferline,
  event = 'BufRead',
})

cosmos.add_plugin('karb94/neoscroll.nvim', {
  enabled = options.enable_smooth_scrolling,
  config = configs.neoscroll,
  event = 'BufRead',
})

cosmos.add_plugin('sphamba/smear-cursor.nvim', {
  enabled = options.enable_beacon,
  event = 'BufRead',
  opts = {},
})

cosmos.add_plugin('RRethy/vim-illuminate', {
  enabled = options.enable_illuminate,
  event = 'BufRead',
})

cosmos.add_plugin('norcalli/nvim-colorizer.lua', {
  enabled = options.enable_colorizer,
  config = configs.colorizer,
  event = 'BufRead',
})

cosmos.add_plugin('petertriho/nvim-scrollbar', {
  enabled = options.enable_scrollbar,
  dependencies = {
    {
      'kevinhwang91/nvim-hlslens',
      config = configs.hlslens,
      event = 'BufRead',
    },
  },
  config = configs.scrollbar,
})

cosmos.add_plugin('SmiteshP/nvim-navic', {
  enabled = options.enable_navic,
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  config = configs.navic,
  event = 'BufRead',
})

cosmos.add_plugin('yamatsum/nvim-cursorline', {
  config = configs.cursorline,
})

cosmos.add_plugin('tzachar/highlight-undo.nvim', {
  config = configs.highlight_undo,
})

cosmos.add_plugin('luckasRanarison/tailwind-tools.nvim', {
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  opts = {},
})

cosmos.add_plugin('razak17/tailwind-fold.nvim', {
  opts = {},
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  ft = { 'html', 'svelte', 'astro', 'vue', 'typescriptreact', 'php', 'blade' },
  config = configs.tailwind_fold,
})

cosmos.add_plugin('nvchad/showkeys', { cmd = 'ShowkeysToggle' })

cosmos.add_plugin('jonahgoldwastaken/copilot-status.nvim', {
  dependencies = { 'copilot.lua' },
  lazy = true,
  event = 'BufReadPost',
})

cosmos.add_plugin('folke/noice.nvim', {
  event = 'VeryLazy',
  opts = {
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
      },
    },
    -- you can enable a preset for easier configuration
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = false, -- add a border to hover docs and signature help
    },
    messages = {
      enabled = false,
    },
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    'MunifTanjim/nui.nvim',
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    'rcarriga/nvim-notify',
  },
})
