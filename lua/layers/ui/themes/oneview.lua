local M = {}

-- UI
M.base_30 = {
  white = '#C9CBD3',
  black = '#292A30', -- usually your theme bg
  darker_black = '#25262C', -- 6% darker than black
  black2 = '#2D2E36', -- 6% lighter than black
  one_bg = '#36373F', -- 10% lighter than black
  one_bg2 = '#44454F', -- 6% lighter than one_bg
  one_bg3 = '#525460', -- 6% lighter than one_bg2
  grey = '#606270', -- 40% lighter than black
  grey_fg = '#6D7080', -- 10% lighter than grey
  grey_fg2 = '#7C7F90', -- 5% lighter than grey
  light_grey = '#8D8F9E',

  red = '#E87870',
  baby_pink = '#E4938C',
  pink = '#ff75a0',

  line = '#33353D',

  green = '#6EA66F',
  vibrant_green = '#71B874',

  nord_blue = '#81A1C1',
  blue = '#679DD4',
  seablue = '#46A6B0',

  yellow = '#AC984B',
  sun = '#D1A047',

  purple = '#B489C7',
  dark_purple = '#AB81BE',

  teal = '#55A6A0',
  orange = '#CD8962',
  cyan = '#59A3B9',

  statusline_bg = '#2d2e34',
  lightbg = '#45464D',
  pmenu_bg = '#99c366',
  folder_bg = '#679DD4',
}

-- check https://github.com/chriskempson/base16/blob/master/styling.md for more info
M.base_16 = {
  base00 = '#292A30',
  base01 = '#36373F',
  base02 = '#4B4C51',
  base03 = '#5D5D62',
  base04 = '#6D6E6F',
  base05 = '#BEBFC7',
  base06 = '#CECFD5',
  base07 = '#DEDFE3',

  base08 = '#FC6A5D', -- strings / regex literals
  base09 = '#D0BF69', -- literals / numbers / booleans / constants
  base0A = '#55CAED', -- types / declarations / classes
  base0B = '#D1C44F', -- other funcs / methods / external symbols
  base0C = '#1AC8FF', -- support / regex / escape / 属性类
  base0D = '#73DFA5', --  function / method / heading
  base0E = '#FC5FA3', -- keywords / primary accent
  base0F = '#FD8F3F', -- preprocessor / macros
}
M.polish_hl = {
  treesitter = {

    ['@punctuation.bracket'] = { fg = M.base_16.base05 },
    ['@punctuation.delimiter'] = { fg = M.base_16.base06 },
    ['@comment'] = { fg = '#29D330', italic = false },
  },

  syntax = {
    -- Comment = { fg = '#29D330', italic = false },
  },

  -- ['@variable'] = { fg = '#C8CBD4' },
  -- ['@parameter'] = { fg = '#A9AEBB' },
  -- ['@property'] = { fg = '#BAA44D' },
  -- ['@field'] = { fg = '#BAA44D' },
  -- ['@function'] = { fg = '#619DDA' },
  -- ['@method'] = { fg = '#619DDA' },
  -- ['@keyword'] = { fg = '#BF85CD' },
  -- ['@string'] = { fg = '#66AC69' },
  -- ['@type'] = { fg = '#58B4C4' },
  -- ['@constructor'] = { fg = '#76BAFE' },
  -- ['@constant'] = { fg = '#DEC358' },
  -- ['@number'] = { fg = '#BAA44D' },
  -- ['@boolean'] = { fg = '#BAA44D' },
}
M.type = 'dark'

M = require('base46').override_theme(M, 'oneview')

return M
