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

cosmos.add_plugin('numToStr/Comment.nvim', {
  event = 'BufRead',
  config = configs.comment,
})

cosmos.add_plugin('folke/flash.nvim', {
  event = 'VeryLazy',
  ---@type Flash.Config
  opts = {},
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
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
    { 'simrat39/inlay-hints.nvim', lazy = true, config = configs.inlay_hints },
    { 'simrat39/rust-tools.nvim', lazy = true },
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

cosmos.add_plugin('glepnir/lspsaga.nvim', {
  config = configs.lspsaga,
  dependencies = {
    { 'kyazdani42/nvim-web-devicons' },
    --Please make sure you install markdown and markdown_inline parser
    { 'nvim-treesitter/nvim-treesitter' },
  },
  event = 'BufRead',
})

cosmos.add_plugin('nvim-telescope/telescope.nvim', {
  dependencies = {
    {
      'nvim-telescope/telescope-dap.nvim',
      dependencies = { 'mfussenegger/nvim-dap' },
      event = 'BufRead',
      config = configs.telescope_dap,
    },
    { 'nvim-lua/plenary.nvim', lazy = true },
  },
  config = configs.telescope,
})

cosmos.add_plugin('nvim-telescope/telescope-fzf-native.nvim', {
  build = 'make -C ~/.local/share/nvim/lazy/telescope-fzf-native.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  config = configs.telescope_fzf,
})

-- cosmos.add_plugin('nvim-telescope/telescope-frecency.nvim', {
--   dependencies = { 'nvim-telescope/telescope.nvim', 'kkharji/sqlite.lua' },
--   config = configs.telescope_frecency,
-- })

cosmos.add_plugin('nvim-telescope/telescope-file-browser.nvim', {
  dependencies = { 'nvim-telescope/telescope.nvim' },
  config = configs.telescope_file_browser,
})

cosmos.add_plugin('nvim-telescope/telescope-media-files.nvim', {
  dependencies = { 'nvim-telescope/telescope.nvim' },
  config = configs.telescope_media_files,
})

cosmos.add_plugin('nvim-telescope/telescope-ui-select.nvim', {
  dependencies = { 'nvim-telescope/telescope.nvim' },
  event = 'BufRead',
  config = configs.telescope_ui_select,
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

cosmos.add_plugin('ii14/neorepl.nvim')

cosmos.add_plugin('dnlhc/glance.nvim', {
  config = configs.glance,
  event = 'BufRead',
})

cosmos.add_plugin('sysedwinistrator/readline.nvim', {
  config = configs.readline,
})

cosmos.add_plugin('LintaoAmons/bookmarks.nvim', {
  dependencies = { 'stevearc/dressing.nvim' },
  config = configs.bookmarks,
})

cosmos.add_plugin('ThePrimeagen/refactoring.nvim', {
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter' },
  config = configs.refactoring,
})
