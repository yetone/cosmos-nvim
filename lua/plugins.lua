local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])
local packer_bootstrap = nil

if not packer_exists then
  if vim.fn.input("Download Packer? (y for yes) ") ~= "y" then
    print('Please install Packer first!')
    return
  end

  local directory = string.format("%s/site/pack/packer/opt/", vim.fn.stdpath("data"))

  vim.fn.mkdir(directory, "p")

  print(" Downloading packer.nvim...")
  local install_path = directory .. "/packer.nvim"
  packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  print(packer_bootstrap)

  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
  use {
    'lewis6991/impatient.nvim',
    -- rocks = 'mpack'
  }

  use 'wbthomason/packer.nvim'

  use {
    'kyazdani42/nvim-web-devicons',
    config = function()
      require('configs.web-devicons')
    end
  }

  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require('configs.alpha')
    end
  }

  use {
    'iamcco/markdown-preview.nvim',
    run = ':call mkdp#util#install()',
  }

  use 'nvim-lua/plenary.nvim'

  use 'ygm2/rooter.nvim'
  use {
    'ahmedkhalf/project.nvim',
    config = function()
      require('configs.project')
    end,
  }
  use 'ryanoasis/vim-devicons'
  use {
    'folke/which-key.nvim',
    config = function()
      require('configs.which-key')
    end,
  }
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'
  use { 'junegunn/fzf', dir = '~/.fzf', run = ':call fzf#install()' }

  use 'easymotion/vim-easymotion'
  use 'justinmk/vim-sneak'
  use 'wellle/targets.vim'
  use 'rafamadriz/neon'
  use 'github/copilot.vim'
  use 'jreybert/vimagit'
  use 'editorconfig/editorconfig-vim'

  use 'Yggdroot/indentLine'

  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('configs.gitsigns')
    end,
  }

  use 'mattn/emmet-vim'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      if #vim.api.nvim_list_uis() ~= 0 then
        vim.cmd 'TSUpdate'
      end
    end,
  }
  use { 'nvim-treesitter/playground', after = { 'nvim-treesitter' }}
  use { 'nvim-treesitter/nvim-treesitter-textobjects', after = { 'nvim-treesitter' }}
  use { 'p00f/nvim-ts-rainbow', after = { 'nvim-treesitter' }}
  use {
    'JoosepAlviste/nvim-ts-context-commentstring',
    requires = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('configs.tree-sitter')
    end,
  }

  use {
    'ojroques/nvim-lspfuzzy',
    config = function()
      require('configs.lspfuzzy')
    end,
  }
  use {
    'tami5/lspsaga.nvim',
    config = function()
      require('configs.lspsaga')
    end,
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = {
      'arkav/lualine-lsp-progress',
    },
    config = function()
      require('configs.lualine')
    end,
  }

  use {
    'akinsho/bufferline.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('configs.bufferline')
    end,
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {
    'nvim-telescope/telescope-file-browser.nvim',
    requires = { 'nvim-telescope/telescope.nvim' },
    config = function()
      require('configs.telescope')
    end,
  }

  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use {
    'hrsh7th/nvim-cmp',
    config = function()
      require('configs.cmp')
    end,
  }
  use 'onsails/lspkind-nvim'

  use { 'hrsh7th/cmp-vsnip', after = 'nvim-cmp', requires = { 'hrsh7th/nvim-cmp' } }
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'

  use {
    'windwp/nvim-autopairs',
    requires = { 'hrsh7th/nvim-cmp', 'onsails/lspkind-nvim' },
    config = function()
      require('configs.autopairs')
    end,
  }

  use {
    'williamboman/nvim-lsp-installer',
    requires = {
      'tamago324/nlsp-settings.nvim',
      'neovim/nvim-lspconfig',
    },
    config = function()
      require('configs.lsp')
    end,
  }

  use 'dstein64/vim-startuptime'

  use 'folke/lua-dev.nvim'

  use {
    'karb94/neoscroll.nvim',
    config = function()
      require('configs.neoscroll')
    end,
  }

  require('utils').setup_user_plugins(use)

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

vim.cmd([[
augroup packer_user_config
  autocmd!
  autocmd BufWritePost .cosmos-nvim.lua source <afile> | PackerCompile
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
]])
