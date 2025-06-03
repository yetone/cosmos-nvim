-- Credits to original https://github.com/antfu/vscode-theme-vitesse
-- This is a port of the Vitesse Light theme for Neovim

local M = {}

M.base_30 = {
  white = '#393a34',
  darker_black = '#ebebeb', -- darker than black (background)
  black = '#f5f5f5', -- background
  black2 = '#e8e8e8', -- lighter black
  one_bg = '#e1e1e1', -- slightly lighter than black2
  one_bg2 = '#d8d8d8', -- lighter than one_bg
  one_bg3 = '#d0d0d0', -- lighter than one_bg2
  grey = '#c0c0c0',
  grey_fg = '#b0b0b0',
  grey_fg2 = '#a0a0a0',
  light_grey = '#909090',
  red = '#cb7676',
  baby_pink = '#ce9696',
  pink = '#d9739f',
  line = '#e4e4e4', -- for lines like vertsplit
  green = '#4d9375',
  vibrant_green = '#80a665',
  blue = '#6394bf',
  nord_blue = '#5da9a7',
  yellow = '#c4a46e',
  sun = '#d4976c',
  purple = '#a377bf',
  dark_purple = '#9d609f',
  teal = '#5eaab5',
  orange = '#db9a6c',
  cyan = '#5eaab5',
  statusline_bg = '#e8e8e8',
  lightbg = '#d8d8d8',
  pmenu_bg = '#4d9375',
  folder_bg = '#6394bf',
}

M.base_16 = {
  base00 = '#f5f5f5', -- Default background
  base01 = '#e8e8e8', -- Lighter background (status bars, line number, folding marks)
  base02 = '#d8d8d8', -- Selection background
  base03 = '#c0c0c0', -- Comments, invisibles, line highlighting
  base04 = '#a0a0a0', -- Dark foreground (status bars)
  base05 = '#393a34', -- Default foreground
  base06 = '#242424', -- Light foreground
  base07 = '#121212', -- Light background
  base08 = '#cb7676', -- Variables, XML tags, markup link text, markup lists
  base09 = '#cb7676', -- Integers, boolean, constants, XML attributes, markup link url
  base0A = '#c4a46e', -- Classes, markup bold, search text background
  base0B = '#4d9375', -- Strings, inherited class, markup code, diff inserted
  base0C = '#5eaab5', -- Support, regular expressions, escape chars, markup quotes
  base0D = '#6394bf', -- Functions, methods, attribute IDs, headings
  base0E = '#d9739f', -- Keywords, storage, selector, markup italic, diff changed
  base0F = '#db9a6c', -- Deprecated, opening/closing embedded language tags
}

M.polish_hl = {
  treesitter = {
    ['@punctuation.bracket'] = { fg = M.base_30.light_grey },
    ['@punctuation.delimiter'] = { fg = M.base_30.light_grey },
  },

  -- Additional polish for specific languages or plugins
  ['@variable'] = { fg = M.base_30.orange },
  ['@function'] = { fg = M.base_30.vibrant_green },
  ['@keyword'] = { fg = M.base_30.green },
  ['@string'] = { fg = M.base_30.orange },
  ['@type'] = { fg = M.base_30.teal },
  ['@property'] = { fg = M.base_16.base0A },
  ['@parameter'] = { fg = M.base_30.white },
}

M.type = 'light'

M = require('base46').override_theme(M, 'vitesse_light')

return M
