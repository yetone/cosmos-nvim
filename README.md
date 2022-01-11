<h1 align="center">🪐 My Neovim Configuration 🚀</h1>

<p align="center">A must-have configuration for Spacemacs users after defecting to Vim</p>

If you want the power of **VSCode**, the interactivity of **Spacemacs**, and the text-objects of **Vim**, I highly recommend you try this configuration.

<p align="center">
    <img src="https://rawcdn.githack.com/yetone/figure_bed/master/nvim_screenshots/dashboard2.png" >
</p>

# Key features

1. [LSP](https://microsoft.github.io/language-server-protocol/): [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig), [lspsaga](https://github.com/glepnir/lspsaga.nvim), [lspfuzzy](https://github.com/ojroques/nvim-lspfuzzy)

2. [Spacemacs](https://www.spacemacs.org/) operating experience: spacemacs style keyboard shortcuts with [which-key](https://github.com/folke/which-key.nvim), [Telescope](https://github.com/nvim-telescope/telescope.nvim) like [ivy](https://github.com/abo-abo/swiper) and [helm-swoop](https://github.com/emacsorphanage/helm-swoop), etc.

3. Looking forward to your continued exploration, [there are some screenshots](#some-screenshots)

# Install

## 1. Install Neovim 6+

**Only Neovim 6.0 and above are supported**, please refer to the official installation documentation of Neovim: [Install Neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim)

## 2. Install my configuration

```bash
mv ~/.config/nvim{,.yetone-backup} || true

git clone https://github.com/yetone/nvim.git ~/.config/nvim
```

## 3. Install your language lsp server in your nvim

For example, if you are writing `Python`, you will need to open nvim and run the following command:

```bash
:LspInstall python
```

# Some screenshots

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
