local cosmos = require('core.cosmos')
local options = require('layers.editor.options')
local configs = require('layers.editor.configs')

cosmos.add_plugin('ojroques/nvim-osc52', {
  config = configs.osc52,
  event = 'BufRead',
})

cosmos.add_plugin('iamcco/markdown-preview.nvim', {
  build = ':call mkdp#util#install()',
  event = 'BufRead',
  config = function()
    vim.g.mkdp_open_to_the_world = 1
  end,
})

cosmos.add_plugin('ahmedkhalf/project.nvim', {
  config = configs.project,
})

cosmos.add_plugin('kyazdani42/nvim-tree.lua', {
  config = configs.nvimtree,
  dependencies = {
    'kyazdani42/nvim-web-devicons', -- optional, for file icon
  },
})
cosmos.add_plugin('tpope/vim-surround', {
  event = 'BufRead',
})
cosmos.add_plugin('tpope/vim-commentary', {
  event = 'BufRead',
})

cosmos.add_plugin('phaazon/hop.nvim', {
  branch = 'v1',
  config = configs.hop,
  event = 'BufRead',
})

cosmos.add_plugin('ggandor/leap.nvim', {
  dependencies = { 'tpope/vim-repeat' },
  config = configs.leap,
  event = 'BufRead',
})

cosmos.add_plugin('wellle/targets.vim', {
  event = 'BufRead',
})

cosmos.add_plugin('editorconfig/editorconfig-vim', {
  event = 'BufRead',
})

cosmos.add_plugin('nvim-treesitter/nvim-treesitter', {
  build = function()
    if #vim.api.nvim_list_uis() ~= 0 then
      vim.cmd('TSUpdate')
    end
  end,
  config = configs.treesitter,
  event = { 'BufRead', 'BufNewFile' },
})
cosmos.add_plugin('nvim-treesitter/playground', {
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  event = 'BufRead',
})
cosmos.add_plugin('nvim-treesitter/nvim-treesitter-textobjects', {
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  event = 'BufRead',
})
cosmos.add_plugin('RRethy/nvim-treesitter-textsubjects', {
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  event = 'BufRead',
})

cosmos.add_plugin('JoosepAlviste/nvim-ts-context-commentstring', {
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  event = 'BufRead',
})

cosmos.add_plugin('windwp/nvim-ts-autotag', {
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  event = 'BufRead',
})

cosmos.add_plugin('sheerun/vim-polyglot', {
  enabled = false,
  event = 'BufRead',
})

cosmos.add_plugin('NMAC427/guess-indent.nvim', {
  config = configs.guess_indent,
  event = 'BufReadPost',
})

cosmos.add_plugin('nacro90/numb.nvim', {
  config = configs.numb,
  event = 'BufRead',
})

cosmos.add_plugin('lewis6991/spellsitter.nvim', {
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = configs.spellsitter,
  event = 'BufRead',
})

cosmos.add_plugin('williamboman/mason.nvim', {
  dependencies = {
    { 'williamboman/mason-lspconfig.nvim', lazy = true },
    { 'neovim/nvim-lspconfig', lazy = true },
    { 'hrsh7th/cmp-nvim-lsp', lazy = true, dependencies = { 'hrsh7th/nvim-cmp' } },
    { 'folke/neodev.nvim', lazy = true },
    { 'jose-elias-alvarez/null-ls.nvim', lazy = true, event = { 'BufReadPost', 'BufNewFile' } },
    { 'jay-babu/mason-null-ls.nvim', lazy = true },
  },
  config = configs.mason,
})

cosmos.add_plugin('ojroques/nvim-lspfuzzy', {
  config = configs.lspfuzzy,
  event = 'BufRead',
  dependencies = {
    { 'neovim/nvim-lspconfig' },
    { 'junegunn/fzf', event = 'BufRead' },
    { 'junegunn/fzf.vim', event = 'BufRead' }, -- to enable preview (optional)
  },
})

cosmos.add_plugin('tami5/lspsaga.nvim', {
  config = configs.lspsaga,
  dependencies = { 'neovim/nvim-lspconfig' },
  event = 'BufRead',
})

cosmos.add_plugin('nvim-telescope/telescope.nvim', {
  dependencies = { { 'nvim-lua/plenary.nvim', lazy = true } },
  config = configs.telescope,
})

cosmos.add_plugin('nvim-telescope/telescope-fzf-native.nvim', {
  build = 'make',
})

cosmos.add_plugin('nvim-telescope/telescope-file-browser.nvim', {
  dependencies = { 'nvim-telescope/telescope.nvim' },
})

cosmos.add_plugin('nvim-telescope/telescope-media-files.nvim', {
  dependencies = { 'nvim-telescope/telescope.nvim' },
})

cosmos.add_plugin('nvim-telescope/telescope-dap.nvim', {
  dependencies = { 'nvim-telescope/telescope.nvim' },
  event = 'BufRead',
})

cosmos.add_plugin('nvim-telescope/telescope-ui-select.nvim', {
  dependencies = { 'nvim-telescope/telescope.nvim' },
})

cosmos.add_plugin('dstein64/vim-startuptime')

cosmos.add_plugin('akinsho/toggleterm.nvim', {
  branch = 'main',
  config = configs.toggleterm,
  event = 'BufRead',
})

cosmos.add_plugin('vim-scripts/AnsiEsc.vim', {
  event = 'BufRead',
})

cosmos.add_plugin('mfussenegger/nvim-dap', {
  config = configs.dap,
  event = 'BufRead',
})

cosmos.add_plugin('leoluz/nvim-dap-go', {
  dependencies = { 'mfussenegger/nvim-dap' },
  config = configs.dap_go,
  event = 'BufRead',
})

cosmos.add_plugin('rcarriga/nvim-dap-ui', {
  dependencies = { 'mfussenegger/nvim-dap' },
  config = configs.dapui,
  event = 'BufRead',
})

cosmos.add_plugin('theHamsta/nvim-dap-virtual-text', {
  dependencies = { 'mfussenegger/nvim-dap', 'nvim-treesitter/nvim-treesitter' },
  config = configs.dap_virtual_text,
  event = 'BufRead',
})

cosmos.add_plugin('folke/trouble.nvim', {
  dependencies = { 'kyazdani42/nvim-web-devicons' },
  config = configs.trouble,
  event = 'BufRead',
})

cosmos.add_plugin('Pocco81/auto-save.nvim', {
  config = configs.auto_save,
  event = 'BufRead',
  enabled = options.enable_autosave,
})

cosmos.add_plugin('yorickpeterse/nvim-window', {
  url = 'https://gitlab.com/yorickpeterse/nvim-window.git',
  config = configs.nvim_window,
})
