local cosmos = require('core.cosmos')
local options = require('layers.ui.options')
local configs = require('layers.ui.configs')

cosmos.add_plugin('kyazdani42/nvim-web-devicons', {
  config = configs.web_devicons,
})

cosmos.add_plugin('glepnir/dashboard-nvim', {
  dependencies = { 'kyazdani42/nvim-web-devicons' },
  config = configs.dashboard,
})

cosmos.add_plugin('lukas-reineke/indent-blankline.nvim', {
  config = configs.indent_blankline,
  event = 'BufRead',
})

cosmos.add_plugin('folke/todo-comments.nvim', {
  enabled = options.enable_todo_comments,
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = configs.todo_comments,
  event = 'BufRead',
})

cosmos.add_plugin('p00f/nvim-ts-rainbow', {
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  event = 'BufRead',
})

cosmos.add_plugin('nvim-lualine/lualine.nvim', {
  dependencies = { 'kyazdani42/nvim-web-devicons', 'SmiteshP/nvim-navic' },
  config = configs.lualine,
  event = { 'BufRead', 'VimEnter' },
})

cosmos.add_plugin('j-hui/fidget.nvim', {
  dependencies = { 'nvim-lualine/lualine.nvim' },
  config = configs.fidget,
  event = 'BufRead',
})

cosmos.add_plugin('akinsho/bufferline.nvim', {
  dependencies = { 'kyazdani42/nvim-web-devicons' },
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
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'kyazdani42/nvim-web-devicons' },
  config = configs.navic,
  event = 'BufRead',
})

cosmos.add_plugin('yamatsum/nvim-cursorline', {
  config = configs.cursorline,
})
