<h1 align="center">🪐 My Neovim Configuration 🚀</h1>

<p align="center">A must-have configuration for Spacemacs users after defecting to Vim</p>

<p align="center">
    <a href="https://github.com/yetone/nvim/actions/workflows/build.yml">
        <img alt="Build Status" src="https://github.com/yetone/nvim/actions/workflows/build.yml/badge.svg">
    </a>
</p>

If you want the power of **VSCode**, the interactivity of **Spacemacs**, and the text-objects of **Vim**, I highly recommend you try this configuration.

<p align="center">
    <img src="https://rawcdn.githack.com/yetone/figure_bed/master/nvim_screenshots/dashboard2.png" >
</p>

# Key Features

1. [LSP](https://microsoft.github.io/language-server-protocol/): [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig), [lspsaga](https://github.com/glepnir/lspsaga.nvim), [lspfuzzy](https://github.com/ojroques/nvim-lspfuzzy)

2. [Spacemacs](https://www.spacemacs.org/) operating experience: spacemacs style keyboard shortcuts with [which-key](https://github.com/folke/which-key.nvim), [Telescope](https://github.com/nvim-telescope/telescope.nvim) like [ivy](https://github.com/abo-abo/swiper) and [helm-swoop](https://github.com/emacsorphanage/helm-swoop), etc.

3. Looking forward to your continued exploration, [there are some screenshots](#some-screenshots)

# Get A Taste Of

If you're worried about breaking your current vim configuration but want to try it out for yourself, you can use docker to give it a quick try in an isolated environment:

```bash
docker run -it -w /root/.config/nvim yetone/cosmos-nvim nvim
```

# Install

## 1. Requirements

### Neovim 6+

**Only Neovim 6.0 and above are supported**, please refer to the official installation documentation of Neovim: [Install Neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim)

### Nerd Fonts

Go to [Nerd Fonts homepage](https://www.nerdfonts.com/) to download the patched fonts you are currently using.

## 2. Install my configuration

```bash
mv ~/.config/nvim{,.yetone-backup} || true

git clone https://github.com/yetone/cosmos-nvim.git ~/.config/nvim
```

## 3. Install your language lsp server in your nvim

For example, if you are writing `Python`, you will need to open nvim and run the following command:

```bash
:LspInstall python
```

# Custom Configuration

If you want to define your own configuration, you can create a file called `.cosmos-nvim.lua` in the `$HOME` root directory, for example:

`~/.cosmos-nvim.lua`

```lua
return {
  setup_settings = function()
    -- Put your settings here
  end,
  setup_mappings = function(wk)
    -- Put your key mappings here and where you can group and name shortcuts with `which-key`
  end,
  setup_plugins = function(use)
    -- Put the plugins you want to add here, where you can use the `use` function of `packer.nvim`
    use 'wakatime/vim-wakatime'
  end,
}
```

# Some Screenshots

## Which Key like spacemacs

<p align="center">
  <img src="https://rawcdn.githack.com/yetone/figure_bed/master/nvim_screenshots/which_key.gif" >
</p>

## Fuzzy search commands like spacemacs

<p align="center">
  <img src="https://rawcdn.githack.com/yetone/figure_bed/master/nvim_screenshots/fuzzy_search_commands2.gif" >
</p>

## Find recent files

<p align="center">
  <img src="https://rawcdn.githack.com/yetone/figure_bed/master/nvim_screenshots/recent_files.png" >
</p>

## The status bar with lsp status

<p align="center">
  <img src="https://rawcdn.githack.com/yetone/figure_bed/master/nvim_screenshots/status_bar.png" >
</p>

## Search current buffer like emacs [helm-swoop](https://github.com/emacsorphanage/helm-swoop)

<p align="center">
  <img src="https://rawcdn.githack.com/yetone/figure_bed/master/nvim_screenshots/swoop.png" >
</p>

## List symbols

<p align="center">
  <img src="https://rawcdn.githack.com/yetone/figure_bed/master/nvim_screenshots/list_symbols.png" >
</p>
