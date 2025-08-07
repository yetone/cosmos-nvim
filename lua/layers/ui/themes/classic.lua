-- Credits to original https://github.com/arcticicestudio/nord-vim
-- This is modified version of it

local M = {}

M.base_30 = {
  white = '#F9F9FA',
  darker_black = '#292A30', --  nvim bg
  black = '#292A30',        -- 标签高亮组
  black2 = '#393A42',       --tree文件 选中行
  one_bg = '#303138',       -- 第一层内容背景（选中行、代码块）
  one_bg2 = '#43454F',      -- 状态栏 StatusBar (filename)
  one_bg3 = '#A5A9C2',
  grey = '#51525E',  --行号
  grey_fg = '#5B5D6B', -- 代码注释加上 treefold 箭头折叠
  grey_fg2 = '#FF645A',
  light_grey = '#A5A9C2',
  red = '#FF645A',
  baby_pink = '#F29AB5',
  pink = '#d57780',
  line = '#414753', -- for lines like vertsplit
  green = '#98C379',-- StatusBar (file percentage)
  vibrant_green = '#afca98',
  blue = '#95B7FF',
  nord_blue = '#5BF7FF',
  yellow = '#E0BB36',
  sun = '#e1c181',
  purple = '#FF9BBD',
  dark_purple = '#BE8A70',
  teal = '#5EC8D6',
  orange = '#E8AB72',
  cyan = '#5EC8D6',
 -- UI 特殊元素
  statusline_bg = "#333945",        -- 派生 base01/02 中间值
  lightbg       = "#75798A",        -- 弹窗背景（base01 再亮一点）
  pmenu_bg      = "#98C379",        -- 补全选中（与字符串同色）
  folder_bg     = "#95B7FF",        -- 文件夹图标颜色（函数蓝）,
}

M.base_16 = {
  base00 = '#292A30',
  base01 = '#3C3D47',
  base02 = '#4F5057',
  base03 = '#75798A', -- 注释
  base04 = '#8D91A6', -- 次级文本
  base05 = '#D9D9DB', -- 正文/变量（AAA）
  base06 = '#E8E9EC',
  base07 = '#F9F9FA',
  base08 = '#FF645A', -- Red    - 错误/删除
  base09 = '#E8AB72', -- ßOrange - 数字/布尔/字面量
  base0A = '#E0BB36', -- Yellow - 常量/宏/标签
  base0B = '#98C379', -- Green  - 字符串/成功
  base0C = '#5EC8D6', -- Cyan   - 类型/结构/构造器
  base0D = '#95B7FF', -- Blue   - 函数/方法/链接
  base0E = '#FF9BBD', -- Purple - 关键字/控制流
  base0F = '#BE8A70', -- Brown  - 分隔符/杂项
}
-- M.base_16 = {
--   base00 = '#292A30', -- 主背景色
--   base01 = '#33343B', -- 轻微提升背景（选中行）
--   base02 = '#3E3F47', -- UI 元素背景
--   base03 = '#55565F', -- 注释、不可见字符
--   base04 = '#9B9CA6', -- 深色前景（行号等）
--   base05 = '#D4D5DD', -- 默认前景文本（对比度 10.2:1）
--   base06 = '#E8E9F0', -- 浅色前景
--   base07 = '#F5F6FA', -- 最亮前景
--   base08 = '#FF9CA3', -- 变量、错误
--   base09 = '#FFAA57', -- 数字、常量
--   base0A = '#FFD580', -- 类、函数名
--   base0B = '#95E6A1', -- 字符串
--   base0C = '#79E2E6', -- 正则、转义
--   base0D = '#95B7FF', -- 函数、方法
--   base0E = '#D4A9F7', -- 关键字
--   base0F = '#FFA5B4', -- 删除、废弃
-- }
-- M.base_16 = {
--   base00 = '#292A30',
--   base01 = '#3C3D42',
--   base02 = '#4F5057',
--   base03 = '#7C7D82',
--   base04 = '#A2A3A8',
--   base05 = '#D4D5D9',
--   base06 = '#E8E9EC',
--   base07 = '#F9F9FA',
--   base08 = '#E6A09A',
--   base09 = '#E6BF9A',
--   base0A = '#E5D4A1',
--   base0B = '#A4D9B0',
--   base0C = '#9AD9D9',
--   base0D = '#B1C2E6',
--   base0E = '#D1BDE6',
--   base0F = '#C7B09E',
-- }

-- M.polish_hl = {
--   treesitter = {
--     ['@punctuation.bracket'] = { fg = M.base_30.white },
--     ['@punctuation.delimiter'] = { fg = M.base_30.white },
--   },
-- }
M.type = 'dark'

M = require('base46').override_theme(M, 'nord')

return M
