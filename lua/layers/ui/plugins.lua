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

cosmos.add_plugin('lukas-reineke/indent-blankline.nvim', {
  config = configs.indent_blankline,
  main = 'ibl',
  opts = {},
  event = 'BufRead',
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

cosmos.add_plugin('danilamihailov/beacon.nvim', {
  enabled = options.enable_beacon,
  event = 'BufRead',
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
