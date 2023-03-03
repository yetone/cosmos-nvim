<h1 align="center">🪐 My Neovim Configuration 🚀</h1>

<p align="center">A must-have configuration for Spacemacs users after defecting to Vim</p>

<p align="center">
    <a href="https://github.com/yetone/cosmos-nvim/actions/workflows/lint.yaml">
        <img alt="Build Status" src="https://github.com/yetone/cosmos-nvim/actions/workflows/lint.yaml/badge.svg">
    </a>
    <a href="https://github.com/yetone/cosmos-nvim/actions/workflows/build.yml">
        <img alt="Build Status" src="https://github.com/yetone/cosmos-nvim/actions/workflows/build.yml/badge.svg">
    </a>
</p>

If you want the power of **VSCode**, the interactivity of **Spacemacs**, and the text-objects of **Vim**, I highly recommend you try this configuration.

The <kbd>leader</kbd> key is the <kbd>spacebar</kbd>.

Each of our shortcut keys has a friendly text description and guide after you press the <kbd>spacebar</kbd>, so there is absolutely no need to memorize the shortcut keys, so the <kbd>spacebar</kbd> key is the key you can confidently press before everything you want to do.

<p align="center">
    <img width="800" src="https://rawcdn.githack.com/yetone/figure_bed/master/nvim_screenshots/dashboard6.gif" >
</p>

# Key Features

1. [LSP](https://microsoft.github.io/language-server-protocol/): [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig), [lspsaga](https://github.com/glepnir/lspsaga.nvim), [lspfuzzy](https://github.com/ojroques/nvim-lspfuzzy)

2. [Spacemacs](https://www.spacemacs.org/) operating experience:

    a. **shortcuts**: spacemacs style keyboard shortcuts with [which-key](https://github.com/folke/which-key.nvim),

    b. **ivy**: [Telescope](https://github.com/nvim-telescope/telescope.nvim) like [ivy](https://github.com/abo-abo/swiper) and [helm-swoop](https://github.com/emacsorphanage/helm-swoop)

    c. **layers**: spacemacs layer abstraction

    d. **customization**: like spacemacs, it can be easily customized by users in particular

    e. etc.

3. Looking forward to your continued exploration, [there are some screenshots](#some-screenshots)

# Get A Taste Of

If you're worried about breaking your current vim configuration but want to try it out for yourself, you can use docker to give it a quick try in an isolated environment:

```bash
docker run -it -w /root/.config/nvim yetone/cosmos-nvim nvim
```

# Install

## 1. Requirements

### Neovim 0.8+

**Only Neovim 0.8 and above are supported**, please refer to the official installation documentation of Neovim: [Install Neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim)

### Nerd Fonts

Go to [Nerd Fonts homepage](https://www.nerdfonts.com/) to download the patched fonts you are currently using.

### Chafa

My configuration use [Chafa](https://github.com/hpjansson/chafa) to render GIF, you can install it by homebrew: `brew install chafa`

### iTerm2 colorscheme [Optional]

If you are using iTerm2 and expect the iTerm colors to blend well with cosmos-nvim colors, it is highly recommended to install and use this [colorscheme](https://github.com/yetone/cosmos-nvim/blob/main/colorschemes/doomone-yetone.itermcolors) for iTerm2.

## 2. Install my configuration

```bash
rm -rf ~/.config/nvim.yetone-backup; mv ~/.config/nvim{,.yetone-backup} || true

git clone --depth 1 https://github.com/yetone/cosmos-nvim.git ~/.config/nvim
```

## 3. Install your language lsp server in your nvim

For example, if you are writing `Python`, you can start by opening a Python file and running the following command:

```bash
:MasonInstall pyright
```

And restart nvim.

# Custom Configuration

If you want to define your own configuration, you can create a file called `.cosmos-nvim.lua` in the `$HOME` root directory (the shortcut is <kbd>leader</kbd> - <kbd>f</kbd> - <kbd>e</kbd> - <kbd>d</kbd>), for example:

`~/.cosmos-nvim.lua`

```lua
local cosmos = require('core.cosmos')

return {
  layers = {
    'editor',
    'git',
    {
      'ui',
      enable_beacon = false,
      enable_smooth_scrolling = false,
    },
    {
      'completion',
      tab_complete_copilot_first = false,
    },
  },
  options = {
    -- python3_host_prog = '~/.pyenv/versions/nvim-py3/bin/python',
  },
  before_setup = function()
    -- cosmos.add_plugin('wakatime/vim-wakatime')
  end,
  after_setup = function()
    -- cosmos.add_leader_keymapping('n|aw', { '<cmd>WakaTimeToday<cr>', name = 'WakaTime Today' })
  end,
}
```

# Themes

cosmos-nvim theme colors and highlights are copied from [NvChad/base46](https://github.com/NvChad/base46) project, because [NvChad/base46](https://github.com/NvChad/base46) can't be used alone, so I can only copy the code, please tell me if there is something wrong with this way of using, many thanks to the author [siduck](https://github.com/siduck)! His [NvChad](https://github.com/NvChad/NvChad) neovim distribution is also very impressive!

All available themes are in this directory: [lua/layers/ui/themes](https://github.com/yetone/cosmos-nvim/tree/main/lua/layers/ui/themes).

You can preview themes by shortcut <kbd>leader</kbd> - <kbd>t</kbd> - <kbd>p</kbd>

You can switch themes in this way:

Change file `~/.cosmos-nvim.lua`(the shortcut is <kbd>leader</kbd> - <kbd>f</kbd> - <kbd>e</kbd> - <kbd>d</kbd>)

```lua
local cosmos = require('core.cosmos')

return {
  layers = {
    'editor',
    'git',
    {
      'ui',
      theme = 'tokyonight' -- <-- add or modify this option
    },
    'completion',
  },
  -- ...
}
```

# Some Screenshots

## Which Key like spacemacs

<p align="center">
  <img src="https://rawcdn.githack.com/yetone/figure_bed/master/nvim_screenshots/which-key2.gif" >
</p>

## Fuzzy search commands like spacemacs

<p align="center">
  <img src="https://rawcdn.githack.com/yetone/figure_bed/master/nvim_screenshots/fuzzy-search-commands3.gif" >
</p>

## Easymotion

<p align="center">
  <img src="https://rawcdn.githack.com/yetone/figure_bed/master/nvim_screenshots/easymotion3.gif" >
</p>

## Find recent files

<p align="center">
  <img src="https://rawcdn.githack.com/yetone/figure_bed/master/nvim_screenshots/recent-files2.png" >
</p>

## The status bar with lsp status

<p align="center">
  <img src="https://rawcdn.githack.com/yetone/figure_bed/master/nvim_screenshots/status-bar2.png" >
</p>

## Search current buffer like emacs [helm-swoop](https://github.com/emacsorphanage/helm-swoop)

<p align="center">
  <img src="https://rawcdn.githack.com/yetone/figure_bed/master/nvim_screenshots/swoop2.png" >
</p>

## List symbols

<p align="center">
  <img src="https://rawcdn.githack.com/yetone/figure_bed/master/nvim_screenshots/list-symbols2.png" >
</p>
