-- layers/ui/themes/xcode_xoce.lua
local M = {}

-- ===== Xcode 风格的语义色（供 polish_hl 使用）=====
local X = {
  main_keyword  = "#FC5FA3", --start point
  main_literals = "#FCED60",
  main_function = "#60E4FC", -- main color

  type1 = "#FCA760", -- 设计原理是函数的补色(与函数相近)
  string1 = "#A2E474", -- ? 存疑 与keyword 补色是绿,与function补色是棕色

  string = "#FC6A5D",
  char   = "#D0BF69",
  number = "#D0BF69",

  regex         = "#FC6A5D",
  regex_number  = "#D0BF69",
  regex_capture = "#67B7A4",
  regex_class   = "#A167E6",
  regex_op      = "#FFFFFF",

  keyword   = "#FC5FA3",
  preproc   = "#FD8F3F",
  url       = "#5482FF",
  attr      = "#BF8555",
  type_decl = "#5DD8FF",
  other_decl= "#41A1C0",

  proj_class = "#9EF1DD",
  proj_func  = "#67B7A4",
  proj_const = "#67B7A4",
  proj_type  = "#9EF1DD",
  proj_prop  = "#67B7A4",
  proj_macro = "#FD8F3F",

  lib_class = "#D0A8FF",
  lib_func  = "#A167E6",
  lib_const = "#A167E6",
  lib_type  = "#D0A8FF",
  lib_prop  = "#A167E6",

  heading = "#AA0D91",
    -- 这些是高亮表需要补齐的语义键（先放占位，按需替换）
  text        = "#D4D5D9", -- 默认前景
  comment     = "#75798A", -- 注释
  punctuation = "#D4D5D9", -- 括号/逗号等
  operator    = "#FFFFFF", -- 常规运算符（也可等于 regex_op）
  emphasis    = "#FC5FA3", -- 斜体强调
  strong      = "#FC5FA3", -- 粗体强调
  raw         = "#FC6A5D", -- 行内代码/原始文本
  selection   = "#3C3D47", -- 选区/Visual 背景
  git_add     = "#98C379",
  git_change  = "#E0BB36",
  git_delete  = "#FF645A",
  error       = "#FC6860",
}

-- ===== UI: base_30（保留你当前深色 UI，插件友好） =====
M.base_30 = {
  white = '#F9F9FA',
  darker_black = '#292A30', -- Normal.bg
  black = '#292A30',        -- nvim bg
  black2 = '#393A42',       --tree文件 选中行
  one_bg = '#303138',       -- 第一层内容背景（选中行、代码块）
  one_bg2 = '#43454F',      -- 状态栏 StatusBar (filename)
  one_bg3 = '#5B5D6B',
  grey = '#51525E',  --行号
  grey_fg = '#5B5D6B', -- 代码注释加上 treefold 箭头折叠
  grey_fg2 = '#8D91A6',
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
  statusline_bg = "#303138",        -- 派生 base01/02 中间值
  lightbg       = "#75798A",        -- 弹窗背景（base01 再亮一点）
  pmenu_bg      = "#98C379",        -- 补全选中（与字符串同色）
  folder_bg     = "#ACDFFA",        -- 文件夹图标颜色（函数蓝）,
}


-- ===== Base16：做 UI/插件“稳态”底色 =====
M.base_16 = {
  base00 = '#292A30',
  base01 = '#3C3D47',
  base02 = '#4F5057',
  base03 = '#75798A', -- 注释
  base04 = '#8D91A6', -- 次级文本
  base05 = '#D9D9DB', -- 正文/变量（AAA）
  base06 = '#E8E9EC',
  base07 = '#F9F9FA',
  base08 = X.error,    -- Red    - 错误/删除
  base09 = X.main_literals,  -- Orange - 数字/布尔/字面量
  base0A = X.operator,  -- Yellow - 常量/宏/标签
  base0B = X.string1,  -- Green  - 字符串/成功
  base0C = X.type1,  -- Cyan   - 类型/结构/构造器
  base0D = X.main_function,  -- Blue   - 函数/方法/链接
  base0E = X.main_keyword,   -- Purple - 关键字/控制流
  base0F = '#BE8A70',     -- Brown  - 分隔符/杂项
}

M.type = 'dark'

-- ===== polish_hl：按 Treesitter/LSP 语义映射到 X 方案 =====
-- M.polish_hl = {

--     treesitter = {
--   -- Treesitter groups (Treesitter 语法高亮)
--   -- Strings / numbers
--     -- ===== Tree-sitter: 通用 =====
--
--   -- ===== Tree-sitter: 通用 =====
--   ["@boolean"]                      = { fg = X.number },
--   ["@define"]                       = { fg = X.preproc },
--   ["@keyword.directive"]            = { fg = X.preproc },
--   ["@comment"]                      = { fg = X.comment, italic = true },
--   ["@error"]                        = { fg = X.error },
--   ["@punctuation.delimiter"]        = { fg = X.punctuation },
--   ["@punctuation.bracket"]          = { fg = X.punctuation },
--   ["@punctuation.special"]          = { fg = X.punctuation },
--
--   ["@markup.list"]                  = { fg = X.text },
--
--   ["@constant"]                     = { fg = X.other_decl, bold = true },
--   ["@definition.constant"]          = { fg = X.other_decl, bold = true },
--   ["@constant.builtin"]             = { fg = X.lib_const },
--
--   ["@string"]                       = { fg = X.string },
--   ["@character"]                    = { fg = X.char },
--   ["@number"]                       = { fg = X.number },
--
--   ["@namespace"]                    = { fg = X.type_decl },
--   ["@module"]                       = { fg = X.type_decl },
--
--   ["@func.builtin"]                 = { fg = X.lib_func },
--   ["@function"]                     = { fg = X.proj_func },
--   ["@function.call"]                = { fg = X.proj_func },
--   ["@function.builtin"]             = { fg = X.lib_func },
--   ["@func.macro"]                   = { fg = X.proj_macro },
--
--   ["@parameter"]                    = { fg = X.other_decl, nocombine = true },
--   ["@variable.parameter"]           = { fg = X.other_decl, nocombine = true },
--   ["@parameter.reference"]          = { fg = X.other_decl },
--
--   ["@method"]                       = { fg = X.proj_func },
--   ["@function.method"]              = { fg = X.proj_func },
--   ["@method.call"]                  = { fg = X.proj_func },
--   ["@function.method.call"]         = { fg = X.proj_func },
--
--   ["@field"]                        = { fg = X.proj_prop },
--   ["@variable.member"]              = { fg = X.proj_prop },
--   ["@property"]                     = { fg = X.proj_prop },
--
--   ["@constructor"]                  = { fg = X.proj_type, nocombine = true },
--
--   ["@conditional"]                  = { fg = X.keyword },
--   ["@keyword.conditional"]          = { fg = X.keyword },
--   ["@repeat"]                       = { fg = X.keyword },
--   ["@keyword.repeat"]               = { fg = X.keyword },
--   ["@label"]                        = { fg = X.other_decl },
--
--   ["@keyword"]                      = { fg = X.keyword },
--   ["@keyword.return"]               = { fg = X.keyword },
--   ["@keyword.function"]             = { fg = X.keyword },
--   ["@keyword.operator"]             = { fg = X.keyword },
--
--   ["@operator"]                     = { fg = X.operator },
--
--   ["@exception"]                    = { fg = X.keyword },
--   ["@keyword.exception"]            = { fg = X.keyword },
--
--   ["@type"]                         = { fg = X.type_decl },
--   ["@type.builtin"]                 = { fg = X.lib_type },
--   ["@type.qualifier"]               = { fg = X.keyword },
--
--   ["@storageclass.lifetime"]        = { fg = X.keyword },
--   ["@keyword.storage.lifetime"]     = { fg = X.keyword },
--   ["@structure"]                    = { fg = X.other_decl },
--
--   ["@variable"]                     = { fg = X.char },
--   ["@variable.builtin"]             = { fg = X.lib_const },
--
--   -- ===== 文本/标记 =====
--   ["@text"]                         = { fg = X.text },
--   ["@text.strong"]                  = { fg = X.text, bold = true },
--   ["@text.emphasis"]                = { fg = X.text, italic = true },
--   ["@text.underline"]               = { fg = X.text, underline = true },
--   ["@text.strike"]                  = { fg = X.comment, strikethrough = true },
--   ["@text.title"]                   = { fg = X.heading },
--   ["@text.literal"]                 = { fg = X.string },
--
--   ["@markup"]                       = { fg = X.text },
--   ["@markup.strong"]                = { fg = X.text, bold = true },
--   ["@markup.emphasis"]              = { fg = X.text, italic = true },
--   ["@markup.underline"]             = { fg = X.text, underline = true },
--   ["@markup.strike"]                = { fg = X.comment, strikethrough = true },
--   ["@markup.heading"]               = { fg = X.heading },
--   ["@markup.raw"]                   = { fg = X.string },
--
--   ["@uri"]                          = { fg = X.url, underline = true },
--
--   ["@tag"]                          = { fg = X.type_decl },
--   ["@tag.delimiter"]                = { fg = X.comment },
--   ["@tag.attribute"]                = { fg = X.attr },
--
--   -- ===== per-language =====
--   ["@variable.python"]              = { fg = X.char },
--   ["@attribute.python"]             = { fg = X.attr, bold = true },
--   ["@decorator"]                    = { fg = X.attr, bold = true },
--
--   ["@variable.rust"]                = { fg = X.char },
--
--   ["@conditional.javascript"]       = { fg = X.keyword },
--   ["@keyword.conditional.javascript"]= { fg = X.keyword },
--   ["@variable.javascript"]          = { fg = X.char },
--
--   -- ===== LSP 语义令牌 =====
--   ["@lsp.type.class"]               = { fg = X.proj_class },
--   ["@lsp.type.decorator"]           = { fg = X.attr },
--   ["@lsp.type.enum"]                = { fg = X.type_decl },
--   ["@lsp.type.enumMember"]          = { fg = X.other_decl },
--   ["@lsp.type.function"]            = { fg = X.proj_func },
--   ["@lsp.type.interface"]           = { fg = X.type_decl },
--   ["@lsp.type.macro"]               = { fg = X.preproc },
--   ["@lsp.type.method"]              = { fg = X.proj_func },
--   ["@lsp.type.namespace"]           = { fg = X.type_decl },
--   ["@lsp.type.parameter"]           = { fg = X.other_decl },
--   ["@lsp.type.property"]            = { fg = X.proj_prop },
--   ["@lsp.type.struct"]              = { fg = X.type_decl },
--   ["@lsp.type.type"]                = { fg = X.type_decl },
--   ["@lsp.type.typeParameter"]       = { fg = X.type_decl },
--   ["@lsp.type.variable"]            = { fg = X.char },
--
--   -- ===== HTML =====
--   htmlArg                           = { fg = X.attr },
--   htmlBold                          = { fg = X.text, bold = true },
--   htmlEndTag                        = { fg = X.punctuation },
--   htmlH1                            = { fg = X.heading },
--   htmlH2                            = { fg = X.heading },
--   htmlH3                            = { fg = X.heading },
--   htmlH4                            = { fg = X.heading },
--   htmlH5                            = { fg = X.heading },
--   htmlH6                            = { fg = X.heading },
--   htmlItalic                        = { fg = X.keyword, italic = true },
--   htmlLink                          = { fg = X.url, underline = true },
--   htmlSpecialChar                   = { fg = X.other_decl },
--   htmlSpecialTagName                = { fg = X.type_decl },
--   htmlTag                           = { fg = X.punctuation },
--   htmlTagN                          = { fg = X.type_decl },
--   htmlTagName                       = { fg = X.type_decl },
--   htmlTitle                         = { fg = X.heading },
--
--   -- ===== Markdown =====
--   markdownBlockquote                = { fg = X.comment },
--   markdownBold                      = { fg = X.text, bold = true },
--   markdownCode                      = { fg = X.string },
--   markdownCodeBlock                 = { fg = X.comment },
--   markdownCodeDelimiter             = { fg = X.comment },
--   markdownH1                        = { fg = X.heading },
--   markdownH2                        = { fg = X.heading },
--   markdownH3                        = { fg = X.heading },
--   markdownH4                        = { fg = X.heading },
--   markdownH5                        = { fg = X.heading },
--   markdownH6                        = { fg = X.heading },
--   markdownHeadingDelimiter          = { fg = X.punctuation },
--   markdownHeadingRule               = { fg = X.comment },
--   markdownId                        = { fg = X.other_decl },
--   markdownIdDeclaration             = { fg = X.other_decl },
--   markdownIdDelimiter               = { fg = X.other_decl },
--   markdownItalic                    = { fg = X.keyword, italic = true },
--   markdownLinkDelimiter             = { fg = X.punctuation },
--   markdownLinkText                  = { fg = X.text },
--   markdownListMarker                = { fg = X.punctuation },
--   markdownOrderedListMarker         = { fg = X.punctuation },
--   markdownRule                      = { fg = X.comment },
--   markdownUrl                       = { fg = X.url, underline = true },
--
--   -- ===== PHP =====
--   phpInclude                        = { fg = X.preproc },
--   phpClass                          = { fg = X.type_decl },
--   phpClasses                        = { fg = X.type_decl },
--   phpFunction                       = { fg = X.proj_func },
--   phpType                           = { fg = X.type_decl },
--   phpKeyword                        = { fg = X.keyword },
--   phpVarSelector                    = { fg = X.text },
--   phpIdentifier                     = { fg = X.text },
--   phpMethod                         = { fg = X.proj_func },
--   phpBoolean                        = { fg = X.number },
--   phpParent                         = { fg = X.punctuation },
--   phpOperator                       = { fg = X.operator },
--   phpRegion                         = { fg = X.preproc },
--   phpUseNamespaceSeparator          = { fg = X.punctuation },
--   phpClassNamespaceSeparator        = { fg = X.punctuation },
--   phpDocTags                        = { fg = X.comment },
--   phpDocParam                       = { fg = X.comment },
--
--   -- ===== Coc Explorer / UI（语义近似） =====
--   CocExplorerIndentLine             = { fg = X.comment },
--   CocExplorerBufferRoot             = { fg = X.heading },
--   CocExplorerFileRoot               = { fg = X.heading },
--   CocExplorerBufferFullPath         = { fg = X.comment },
--   CocExplorerFileFullPath           = { fg = X.comment },
--   CocExplorerBufferReadonly         = { fg = X.keyword },
--   CocExplorerBufferModified         = { fg = X.preproc },
--   CocExplorerBufferNameVisible      = { fg = X.heading },
--   CocExplorerFileReadonly           = { fg = X.keyword },
--   CocExplorerFileModified           = { fg = X.preproc },
--   CocExplorerFileHidden             = { fg = X.comment },
--   CocExplorerHelpLine               = { fg = X.other_decl },
--   CocHighlightText                  = { bg = X.selection },
--
--   -- ===== EasyMotion =====
--   EasyMotionTarget                  = { fg = X.keyword, bold = true },
--   EasyMotionTarget2First            = { fg = X.keyword, bold = true },
--   EasyMotionTarget2Second           = { fg = X.keyword, bold = true },
--   EasyMotionShade                   = {},
--
--   -- ===== Startify =====
--   StartifyNumber                    = { fg = X.text },
--   StartifySelect                    = { fg = X.other_decl },
--   StartifyBracket                   = { fg = X.other_decl },
--   StartifySpecial                   = { fg = X.keyword },
--   StartifyVar                       = { fg = X.other_decl },
--   StartifyPath                      = { fg = X.url },
--   StartifyFile                      = { fg = X.text },
--   StartifySlash                     = { fg = X.text },
--   StartifyHeader                    = { fg = X.comment },
--   StartifySection                   = { fg = X.heading },
--   StartifyFooter                    = { fg = X.comment },
--
--   -- ===== WhichKey =====
--   WhichKey                          = { fg = X.keyword },
--   WhichKeySeperator                 = { fg = X.punctuation },
--   WhichKeyGroup                     = { fg = X.heading },
--   WhichKeyDesc                      = { fg = X.text },
--
--   -- ===== Diff / Git =====
--   diffAdded                         = { fg = X.git_add },
--   diffRemoved                       = { fg = X.git_delete },
--   diffFileId                        = { fg = X.other_decl },
--   diffFile                          = { fg = X.comment },
--   diffNewFile                       = { fg = X.heading },
--   diffOldFile                       = { fg = X.keyword },
--
--   SignifySignAdd                    = { fg = X.git_add },
--   SignifySignChange                 = { fg = X.git_change },
--   SignifySignDelete                 = { fg = X.git_delete },
--
--   GitGutterAdd                      = { fg = X.git_add },
--   GitGutterChange                   = { fg = X.git_change },
--   GitGutterDelete                   = { fg = X.git_delete },
--
--   GitSignsCurrentLineBlame          = { fg = X.comment },
--
--   debugBreakpoint                   = { fg = X.error, reverse = true },
--
--   -- ===== Vimwiki =====
--   VimwikiHeader1                    = { fg = X.heading, bold = true },
--   VimwikiHeader2                    = { fg = X.heading, bold = true },
--   VimwikiHeader3                    = { fg = X.heading, bold = true },
--   VimwikiHeader4                    = { fg = X.heading, bold = true },
--   VimwikiHeader5                    = { fg = X.heading, bold = true },
--   VimwikiHeader6                    = { fg = X.heading, bold = true },
--   VimwikiLink                       = { fg = X.url, underline = true },
--   VimwikiHeaderChar                 = { fg = X.comment },
--   VimwikiHR                         = { fg = X.comment },
--   VimwikiList                       = { fg = X.punctuation },
--   VimwikiTag                        = { fg = X.keyword },
--   VimwikiMarkers                    = { fg = X.comment },
--
--   -- ===== 常用 UI / 编辑态 =====
--   -- ColorColumn                       = { bg = X.selection },
--   -- SignColumn                        = { bg = X.selection },
--   -- CursorColumn                      = { bg = X.selection },
--   -- CursorLine                        = { bg = X.selection },
--   -- FoldColumn                        = { }, -- 留空等同默认
--   -- PmenuSbar                         = { bg = X.comment },
--   -- PmenuThumb                        = { bg = X.text },
--   -- Visual                            = { bg = X.selection },
--   -- MultiCursor                       = { bg = X.selection },
--   -- Cursor                            = { bg = X.comment },
--   --
--   -- ===== 其他 =====
--   Underlined                        = { fg = X.url, underline = true },
--   ["@variable.cpp"]                 = { fg = X.text },
--
-- },
-- }

-- 如果你使用 NvChad/base46，需要注册主题名：
M = require('base46').override_theme(M, 'xcode')

-- 不要在这里再手动 set_hl（会和加载顺序打架）
-- 如需临时调试，可在 after/ 或你的 config 里：
-- vim.api.nvim_set_hl(0, "@string", { fg = "#FC6A5D", italic = true })

return M
