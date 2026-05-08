local M = {}

M.base_30 = {
  white = '#C8CBD4',
  darker_black = '#25262C',
  black = '#292A30',
  black2 = '#33343B',
  one_bg = '#33343B',
  one_bg2 = '#3A3C45',
  one_bg3 = '#4A4C55',

  grey = '#4A4C55',
  grey_fg = '#5B606C',
  grey_fg2 = '#6B7280',
  light_grey = '#7B8190',

  red = '#D8625C',
  baby_pink = '#FD736D',
  pink = '#BF85CD',

  line = '#33343B',

  green = '#66AC69',
  vibrant_green = '#7ACF7E',

  blue = '#619DDA',
  nord_blue = '#58B4C4',

  yellow = '#BAA44D',
  sun = '#DEC358',

  purple = '#BF85CD',
  dark_purple = '#92669D',

  teal = '#58B4C4',
  orange = '#BAA44D',
  cyan = '#58B4C4',

  statusline_bg = '#2d2e34',
  lightbg = '#3A3C45',
  pmenu_bg = '#619DDA',
  folder_bg = '#619DDA',
}

M.base_16 = {
  base00 = '#292A30', -- bg
  base01 = '#33343B', -- raised surface
  base02 = '#3A3C45', -- selection / active bg
  base03 = '#4A4C55', -- comments / invisibles / line highlight
  base04 = '#7B8190', -- muted foreground
  base05 = '#C8CBD4', -- default foreground
  base06 = '#E1E4EB', -- stronger foreground
  base07 = '#F3F4F7', -- strongest foreground

  base08 = '#FF756E', -- red
  base09 = '#CFB655', -- yellow/orange
  base0A = '#EBCE5E', -- bright yellow
  base0B = '#77C97C', -- green
  base0C = '#60C5D6', -- cyan
  base0D = '#70B8FF', -- blue
  base0E = '#E49DF2', -- magenta / keyword
  base0F = '#CFB655', -- darker amber
}

M.polish_hl = {
  treesitter = {
    ['@punctuation.bracket'] = { fg = M.base_30.white },
    ['@punctuation.delimiter'] = { fg = M.base_30.white },
  },

  ['@variable'] = { fg = M.base_30.white },
  ['@function'] = { fg = M.base_30.blue },
  ['@keyword'] = { fg = M.base_30.purple },
  ['@string'] = { fg = M.base_30.green },
  ['@type'] = { fg = M.base_30.teal },
  ['@property'] = { fg = M.base_30.yellow },
  ['@parameter'] = { fg = '#A9AEBB' },
}

M.type = 'dark'

M = require('base46').override_theme(M, 'oneview_pro')

return M
