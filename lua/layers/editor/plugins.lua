local cosmos = require('core.cosmos')
local options = require('layers.editor.options')
local configs = require('layers.editor.configs')

cosmos.add_plugin(
  'iamcco/markdown-preview.nvim',
  {
    run = ':call mkdp#util#install()',
    event = 'BufRead',
    config = function()
      vim.g.mkdp_open_to_the_world = 1
    end,
  }
)

cosmos.add_plugin(
  'ygm2/rooter.nvim',
  {
    event = 'BufRead',
  }
)

cosmos.add_plugin(
  'ahmedkhalf/project.nvim',
  {
    config = configs.project,
  }
)

cosmos.add_plugin(
  'kyazdani42/nvim-tree.lua',
  {
    config = configs.nvimtree,
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    after = {
      'nvim-web-devicons', -- optional, for file icon
    },
  }
)
cosmos.add_plugin(
  'tpope/vim-surround',
  {
    event = 'BufRead',
  }
)
cosmos.add_plugin(
  'tpope/vim-commentary',
  {
    event = 'BufRead',
  }
)

cosmos.add_plugin(
  'phaazon/hop.nvim',
  {
    branch = 'v1',
    config = configs.hop,
    event = 'BufRead',
  }
)

cosmos.add_plugin(
  'ggandor/leap.nvim',
  {
    requires = { 'tpope/vim-repeat' },
    config = configs.leap,
    event = 'BufRead',
  }
)

cosmos.add_plugin(
  'wellle/targets.vim',
  {
    event = 'BufRead',
  }
)

cosmos.add_plugin(
  'editorconfig/editorconfig-vim',
  {
    event = 'BufRead',
  }
)

cosmos.add_plugin(
  'nvim-treesitter/nvim-treesitter',
  {
    run = function()
      if #vim.api.nvim_list_uis() ~= 0 then
        vim.cmd 'TSUpdate'
      end
    end,
    config = configs.treesitter,
    event = { "BufRead", "BufNewFile" },
  }
)
cosmos.add_plugin(
  'nvim-treesitter/playground',
  {
    after = { 'nvim-treesitter' }
  }
)
cosmos.add_plugin(
  'nvim-treesitter/nvim-treesitter-textobjects',
  {
    after = { 'nvim-treesitter' },
  }
)
cosmos.add_plugin(
  'RRethy/nvim-treesitter-textsubjects',
  {
    after = { 'nvim-treesitter' },
  }
)

cosmos.add_plugin(
  'JoosepAlviste/nvim-ts-context-commentstring',
  {
    after = { 'nvim-treesitter' },
  }
)

cosmos.add_plugin(
  'windwp/nvim-ts-autotag',
  {
    after = { 'nvim-treesitter' },
  }
)

cosmos.add_plugin(
  'sheerun/vim-polyglot',
  {
    event = 'BufRead',
  }
)

cosmos.add_plugin(
  'tpope/vim-sleuth',
  {
    event = 'BufRead',
  }
)

cosmos.add_plugin(
  'nacro90/numb.nvim',
  {
    config = configs.numb,
    event = 'BufRead',
  }
)

cosmos.add_plugin(
  'lewis6991/spellsitter.nvim',
  {
    after = { 'nvim-treesitter' },
    config = configs.spellsitter,
  }
)

cosmos.add_plugin(
  'neovim/nvim-lspconfig',
  {
    event = 'BufRead',
  }
)

cosmos.add_plugin(
  'ojroques/nvim-lspfuzzy',
  {
    config = configs.lspfuzzy,
    after = { 'nvim-lspconfig' },
    event = 'BufRead',
    requires = {
      {'junegunn/fzf', event = 'BufRead' },
      {'junegunn/fzf.vim', event = 'BufRead' },  -- to enable preview (optional)
    },
  }
)

cosmos.add_plugin(
  'tami5/lspsaga.nvim',
  {
    config = configs.lspsaga,
    after = { 'nvim-lspconfig' },
  }
)

cosmos.add_plugin(
  'nvim-telescope/telescope.nvim',
  {
    requires = { 'nvim-lua/plenary.nvim' },
    config = configs.telescope,
  }
)

cosmos.add_plugin(
  'nvim-telescope/telescope-fzf-native.nvim',
  {
    run = 'make',
    requires = { 'nvim-telescope/telescope.nvim' },
  }
)

cosmos.add_plugin(
  'nvim-telescope/telescope-file-browser.nvim',
  {
    requires = { 'nvim-telescope/telescope.nvim' },
  }
)

cosmos.add_plugin(
  'nvim-telescope/telescope-media-files.nvim',
  {
    requires = { 'nvim-telescope/telescope.nvim' },
  }
)

cosmos.add_plugin(
  'nvim-telescope/telescope-dap.nvim',
  {
    requires = { 'nvim-telescope/telescope.nvim' },
  }
)

cosmos.add_plugin(
  'nvim-telescope/telescope-ui-select.nvim',
  {
    requires = { 'nvim-telescope/telescope.nvim' },
  }
)

cosmos.add_plugin(
  'williamboman/nvim-lsp-installer',
  {
    requires = {
      {
        'tamago324/nlsp-settings.nvim',
        after = { 'nvim-lspconfig' },
      },
    },
    after = { 'nvim-lspconfig' },
    config = configs.lsp_installer,
  }
)

cosmos.add_plugin(
  'dstein64/vim-startuptime',
  {
    event = 'BufRead',
  }
)

cosmos.add_plugin('folke/lua-dev.nvim')

cosmos.add_plugin(
  'akinsho/toggleterm.nvim',
  {
    branch = 'main',
    config = configs.toggleterm,
    event = 'BufRead',
  }
)

cosmos.add_plugin(
  'vim-scripts/AnsiEsc.vim',
  {
    event = 'BufRead',
  }
)

cosmos.add_plugin(
  'mfussenegger/nvim-dap',
  {
    config = configs.dap,
  }
)

cosmos.add_plugin(
  'Pocco81/DAPInstall.nvim',
  {
    requires = { 'mfussenegger/nvim-dap' },
    config = configs.dap_install,
    event = 'BufRead',
  }
)

cosmos.add_plugin(
  'rcarriga/nvim-dap-ui',
  {
    requires = { 'mfussenegger/nvim-dap' },
    config = configs.dapui,
    event = 'BufRead',
  }
)

cosmos.add_plugin(
  'theHamsta/nvim-dap-virtual-text',
  {
    requires = { 'mfussenegger/nvim-dap', 'nvim-treesitter/nvim-treesitter' },
    after = { 'nvim-dap', 'nvim-treesitter' },
    config = configs.dap_virtual_text,
  }
)

cosmos.add_plugin(
  'folke/trouble.nvim',
  {
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = configs.trouble,
    event = 'BufRead',
  }
)

