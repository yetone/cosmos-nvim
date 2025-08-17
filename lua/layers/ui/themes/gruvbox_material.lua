local M = {}
local color = {
  -- 背景类
  bg_dim = "#1B1B1B",
  bg0 = "#282828",
  bg1 = "#32302F",
  bg2 = "#32302F",
  bg3 = "#45403D",
  bg4 = "#45403D",
  bg5 = "#5A524C",

  -- 状态栏 & 当前单词
  bg_statusline1 = "#32302F",
  bg_statusline2 = "#3A3735",
  bg_statusline3 = "#504945",
  bg_current_word = "#3C3836",

  -- diff (版本对比)
  bg_diff_red = "#402120",
  bg_diff_green = "#34381B",
  bg_diff_blue = "#0E363E",

  -- Visual 模式
  bg_visual_red = "#4C3432",
  bg_visual_green = "#3B4439",
  bg_visual_blue = "#374141",
  bg_visual_yellow = "#4F422E",
  bg_visual_purple = "#443840",

  -- 前景
  fg0 = "#D4BE98",
  fg1 = "#DDC7A1",

  -- 语义色
  red = "#EA6962",
  green = "#A9B665",
  blue = "#7DAEA3",
  yellow = "#D8A657",
  purple = "#D3869B",
  orange = "#E78A4E",
  aqua = "#89B482",

  -- 背景语义色
  bg_red = "#EA6962",
  bg_green = "#A9B665",
  bg_yellow = "#D8A657",

  -- 灰度
  grey0 = "#7C6F64",
  grey1 = "#928374",
  grey2 = "#A89984",
}

M.base_30 = {
  white = '#ebdbb2',
  darker_black = color.bg0,
  black = color.bg0, --  nvim bg
  black2 = color.bg1,
  one_bg = color.bg2,
  one_bg2 = color.bg2,
  one_bg3 = color.bg5,
  grey = color.grey0,
  grey_fg = color.grey1,
  grey_fg2 = color.grey2,
  light_grey = color.grey2,
  red = color.red,
  baby_pink = '#ce8196',
  pink = '#ff75a0',
  line = '#373737', -- for lines like vertsplit
  green = color.green,
  vibrant_green = color.bg_visual_green,
  nord_blue = '#6f8faf',
  blue = color.blue,
  yellow = color.yellow,
  sun = '#eab869',
  purple = color.purple,
  dark_purple = '#d3869b',
  teal = '#749689',
  orange = color.orange,
  cyan = color.aqua,
  statusline_bg = color.bg_statusline1,
  lightbg = '#393939',
  pmenu_bg = '#89b482',
  folder_bg = color.orange,
}
-- ===== Base16：做 UI/插件“稳态”底色 =====
M.base_16 = {
  base00 = color.bg0,
  base01 = color.bg1,
  base02 = color.bg2,
  base03 = color.bg3,
  base04 = color.bg4,
  base05 = color.fg0,
  base06 = color.fg1,
  base07 = color.fg1,
  base08 = color.fg0,    --     - 错误/删除
  base09 = color.purple,  --  - 数字/布尔/字面量
  base0A = color.yellow,  --  - 常量/宏/标签
  base0B = color.aqua,  --   - 字符串/成功
  base0C = color.blue,  --    - 类型/结构/构造器
  base0D = color.green,  --    - 函数/方法/链接
  base0E = color.red,   --  - 关键字/控制流
  base0F = color.orange,     --  - 分隔符/杂项
}


M.polish_hl = {
  -- Include = { fg = M.base_16.base0E },
  -- Repeat = { fg = M.base_16.base0E },
  -- ['@variable'] = { fg = M.base_16.base08 },
  -- ['@property'] = { fg = M.base_16.base0C },
}

M.opt.bg = 'dark'

M = require('base46').override_theme(M, 'gruvbox_material1')

return M
