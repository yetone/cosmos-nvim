local cosmos = require('core.cosmos')
local options = require('layers.editor.options')
local configs = require('layers.editor.configs')

cosmos.add_plugin(
  'iamcco/markdown-preview.nvim',
  {
    run = ':call mkdp#util#install()',
  }
)

cosmos.add_plugin('ygm2/rooter.nvim')
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
  }
)
cosmos.add_plugin('tpope/vim-surround')
cosmos.add_plugin('tpope/vim-commentary')

cosmos.add_plugin(
  'phaazon/hop.nvim',
  {
    branch = 'v1',
    config = configs.hop,
  }
)

cosmos.add_plugin(
  'ggandor/lightspeed.nvim',
  {
    requires = { 'tpope/vim-repeat' },
  }
)

cosmos.add_plugin('wellle/targets.vim')
cosmos.add_plugin('editorconfig/editorconfig-vim')

cosmos.add_plugin(
  'nvim-treesitter/nvim-treesitter',
  {
    run = function()
      if #vim.api.nvim_list_uis() ~= 0 then
        vim.cmd 'TSUpdate'
      end
    end,
    config = configs.treesitter,
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

cosmos.add_plugin('neovim/nvim-lspconfig')

cosmos.add_plugin(
  'ojroques/nvim-lspfuzzy',
  {
    config = configs.lspfuzzy,
    after = { 'nvim-lspconfig' },
    requires = {
      {'junegunn/fzf'},
      {'junegunn/fzf.vim'},  -- to enable preview (optional)
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
  'nvim-telescope/telescope-file-browser.nvim',
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
      'tamago324/nlsp-settings.nvim',
      'neovim/nvim-lspconfig',
    },
    config = configs.lsp_installer,
  }
)

cosmos.add_plugin('dstein64/vim-startuptime')

cosmos.add_plugin('folke/lua-dev.nvim')

cosmos.add_plugin(
  'akinsho/toggleterm.nvim',
  {
    config = configs.toggleterm,
  }
)

cosmos.add_plugin('vim-scripts/AnsiEsc.vim')

cosmos.add_plugin(
  'mfussenegger/nvim-dap',
  {
    config = configs.dap,
  }
)

cosmos.add_plugin('Pocco81/DAPInstall.nvim')

cosmos.add_plugin(
  'rcarriga/nvim-dap-ui',
  {
    requires = { 'mfussenegger/nvim-dap' },
    config = configs.dapui,
  }
)

cosmos.add_plugin(
  'theHamsta/nvim-dap-virtual-text',
  {
    requires = { 'mfussenegger/nvim-dap', 'nvim-treesitter/nvim-treesitter' },
    config = configs.dap_virtual_text,
  }
)

cosmos.add_plugin(
  'folke/trouble.nvim',
  {
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = configs.trouble,
  }
)

