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

return require('packer').startup(function(use)
  -- -_-_-_-_- META -_-_-_-_-
  -- IMPATIENT: faster startup time {{{
    use {
      'lewis6991/impatient.nvim',
      rocks = 'mpack'
    }
    -- }}}

    use 'wbthomason/packer.nvim'

    use {
      'goolord/alpha-nvim',
      requires = { 'kyazdani42/nvim-web-devicons' },
    }

    use {
      'iamcco/markdown-preview.nvim',
      run = ':call mkdp#util#install()',
    }

    use 'wakatime/vim-wakatime'

    use 'nvim-lua/plenary.nvim'

    use 'ygm2/rooter.nvim'
    use 'ahmedkhalf/project.nvim'
    use 'ryanoasis/vim-devicons'
    use 'folke/which-key.nvim'
    use 'tpope/vim-surround'
    use 'tpope/vim-commentary'
    use { 'junegunn/fzf', dir = '~/.fzf', run = ':call fzf#install()' }
    use 'coreyja/fzf.devicon.vim'

    use 'easymotion/vim-easymotion'
    use 'justinmk/vim-sneak'
    use 'wellle/targets.vim'
    use 'rafamadriz/neon'
    use 'github/copilot.vim'
    use 'jreybert/vimagit'
    use { 'liuchengxu/vim-clap', run = ':Clap install-binary!' }
    use { 'inside/vim-textobj-jsxattr', requires = {{ 'kana/vim-textobj-user' }}}
    use 'editorconfig/editorconfig-vim'

    use 'Yggdroot/indentLine'

    use { 'lewis6991/gitsigns.nvim', requires = {{ 'nvim-lua/plenary.nvim' }}}

    use 'mattn/emmet-vim'
    use 'f-person/git-blame.nvim'

    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { 'nvim-treesitter/playground', requires = {{ 'nvim-treesitter/nvim-treesitter' }}}
    use { 'nvim-treesitter/nvim-treesitter-textobjects', requires = {{ 'nvim-treesitter/nvim-treesitter' }}}
    use { 'p00f/nvim-ts-rainbow', requires = {{ 'nvim-treesitter/nvim-treesitter' }}}
    use { 'JoosepAlviste/nvim-ts-context-commentstring', requires = {{ 'nvim-treesitter/nvim-treesitter' }}}

    use 'neovim/nvim-lspconfig'
    use 'ojroques/nvim-lspfuzzy'
    use 'nvim-lualine/lualine.nvim'
    use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons'}

    use 'tami5/lspsaga.nvim'

    use {
      'nvim-telescope/telescope.nvim',
      requires = { {'nvim-lua/plenary.nvim'} }
    }
    use 'nvim-telescope/telescope-file-browser.nvim'

    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'onsails/lspkind-nvim'

    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/vim-vsnip-integ'

    use 'windwp/nvim-autopairs'

    use 'tamago324/nlsp-settings.nvim'
    use 'williamboman/nvim-lsp-installer'

    use 'arkav/lualine-lsp-progress'

    use 'dstein64/vim-startuptime'

    use 'folke/lua-dev.nvim'

    use {
      'pwntester/octo.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
        'kyazdani42/nvim-web-devicons',
      },
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
      require('packer').sync()
    end
  end)
