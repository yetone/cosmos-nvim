-- Credits to original https://github.com/antfu/vscode-theme-vitesse
-- This is a port of the Vitesse Dark theme for Neovim

local M = {}

M.base_30 = {
  white = '#dbd7ca',
  darker_black = '#121212', -- should be darker than black
  black = '#181818', -- nvim bg
  black2 = '#202020', -- lighter black
  one_bg = '#222222', -- slightly lighter than black2
  one_bg2 = '#292929', -- lighter than one_bg
  one_bg3 = '#353535', -- lighter than one_bg2
  grey = '#444444',
  grey_fg = '#4e4e4e',
  grey_fg2 = '#5a5a5a',
  light_grey = '#666666',
  red = '#cb7676',
  baby_pink = '#e5a0a0',
  pink = '#d9739f',
  line = '#282828', -- for lines like vertsplit
  green = '#4d9375',
  vibrant_green = '#80a665',
  blue = '#6394bf',
  nord_blue = '#5da994',
  yellow = '#e6cc77',
  sun = '#d4976c',
  purple = '#bd83b8',
  dark_purple = '#9d609f',
  teal = '#5eaab5',
  orange = '#c99076',
  cyan = '#5da994',
  statusline_bg = '#202020',
  lightbg = '#292929',
  pmenu_bg = '#4d9375',
  folder_bg = '#6394bf',
}

M.base_16 = {
  base00 = '#121212', -- Default background
  base01 = '#181818', -- Lighter background (status bars, line number, folding marks)
  base02 = '#292929', -- Selection background
  base03 = '#444444', -- Comments, invisibles, line highlighting
  base04 = '#666666', -- Dark foreground (status bars)
  base05 = '#dbd7ca', -- Default foreground
  base06 = '#e6e6e6', -- Light foreground
  base07 = '#ffffff', -- Light background
  base08 = '#cb7676', -- Variables, XML tags, markup link text, markup lists
  base09 = '#c99076', -- Integers, boolean, constants, XML attributes, markup link url
  base0A = '#e6cc77', -- Classes, markup bold, search text background
  base0B = '#4d9375', -- Strings, inherited class, markup code, diff inserted
  base0C = '#5eaab5', -- Support, regular expressions, escape chars, markup quotes
  base0D = '#6394bf', -- Functions, methods, attribute IDs, headings
  base0E = '#d9739f', -- Keywords, storage, selector, markup italic, diff changed
  base0F = '#bd976a', -- Deprecated, opening/closing embedded language tags
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

M.type = 'dark'

M = require('base46').override_theme(M, 'vitesse_dark')

return M
