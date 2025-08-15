-- layers/ui/themes/xcode_xoce.lua
local M = {}

-- ===== Xcode 风格的语义色（使用颜色的层级来突出代码） =====
local X = {
  main_keyword  = "#FC5FA3", --start point
  main_literals = "#FCED60",
  main_function = "#41A1C0", -- main color

  c_type = "#60E4FC", -- 设计原理是类型、构造器与函数保持同色相或近邻色、靠明度/样式区分(与函数相近)
  c_string = "#73A74E", -- ? 存疑 与keyword 补色是绿,与function补色是棕色
  c_macro = "#FD8F3F",
  c_constructor = "#60E4FC", -- 构造器/类名
  c_property = "#FC6A5D", -- 键值对 属性
  c_doc = "#A2E474", -- 文档
  c_function = "#50C4EB", -- 函数

  string           = "#FC6A5D",
  char             = "#D0BF69",
  number           = "#D0BF69",
  regex            = "#FC6A5D",
  regex_number     = "#D0BF69",
  regex_capture    = "#67B7A4",
  regex_class      = "#A167E6",
  regex_op         = "#DEDEE1",
  keyword          = "#FC5FA3",
  preproc          = "#FD8F3F",
  url              = "#5482FF",
  attribute        = "#BF8555",
  type_decl        = "#5DD8FF",
  other_decl       = "#41A1C0",

  proj_class       = "#9EF1DD",
  proj_func        = "#67B7A4",
  proj_const       = "#67B7A4",
  proj_type        = "#9EF1DD",
  proj_prop        = "#67B7A4",
  proj_macro       = "#FD8F3F",

  other_class      = "#D0A8FF",
  other_func       = "#A167E6",
  other_const      = "#A167E6",
  other_type       = "#D0A8FF",
  other_prop       = "#A167E6",
  other_macro      = "#FD8F3F",

  heading          = "#AA0D91",
    -- 这些是高亮表需要补齐的语义键（先放占位，按需替换）
  text        = "#C9C9C9", -- 默认前景
  comment     = "#6C7986", -- 注释
  punctuation = "#D4D5D9", -- 括号/逗号等
  operator    = "#DEDEE1", -- 常规运算符（也可等于 regex_op）
  emphasis    = "#FC5FA3", -- 斜体强调
  strong      = "#FC5FA3", -- 粗体强调
  raw         = "#FC6A5D", -- 行内代码/原始文本
  selection   = "#3C3D47", -- 选区/Visual 背景
  git_add     = "#98C379",
  git_change  = "#E0BB36",
  git_delete  = "#FC6860",
  error       = "#FF645A",
}

-- ===== UI: base_30（保留你当前深色 UI，插件友好） =====
M.base_30 = {
  white = '#C9C9C9',
  darker_black = '#292A30', -- Normal.bg
  black = '#292A30',        -- nvim bg
  black2 = '#303138',       --tree文件 选中行 buffer
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
  folder_bg     = "#9EF1DD",        -- 文件夹图标颜色（函数蓝）,
}


-- ===== Base16：做 UI/插件“稳态”底色 =====
M.base_16 = {
  base00 = '#292A30',
  base01 = '#3C3D47',
  base02 = '#4F5057',
  base03 = '#6C7986', -- 注释 git
  base04 = '#8D91A6', -- 次级文本
  -- base05 = '#D9D9DB', -- 正文/变量（AAA）
  base05 = X.text, -- 正文/变量（AAA）
  base06 = '#E8E9EC',
  base07 = '#F9F9FA',
  base08 = X.error,    -- Red    - 错误/删除
  base09 = X.main_literals,  -- Orange - 数字/布尔/字面量
  base0A = X.c_macro,  -- Yellow - 常量/宏/标签
  base0B = X.c_string,  -- Green  - 字符串/成功
  base0C = X.c_type,  -- Cyan   - 类型/结构/构造器
  base0D = X.main_function,  -- Blue   - 函数/方法/链接
  base0E = X.main_keyword,   -- Purple - 关键字/控制流
  base0F = '#BE8A70',     -- Brown  - 分隔符/杂项
}

M.type = 'dark'

-- ===== polish_hl：按 Treesitter/LSP 语义映射到 X 方案 =====
M.polish_hl = {

    treesitter = {
  ---------------------------------------------------------------------------
  -- 标识符（Identifier）
  ---------------------------------------------------------------------------
  ["@variable"]                     = { fg = X.text },         -- 普通变量/标识符
  ["@variable.builtin"]             = { fg = X.other_func },    -- 内置变量（如 this/self/arguments）
  ["@variable.parameter"]           = { fg = X.proj_func },        -- 函数/方法参数
  ["@variable.parameter.builtin"]   = { fg = X.other_const },    -- 特殊参数（如 ...、_ 等）
  ["@variable.member"]              = { fg = X.proj_prop },        -- 成员/字段（obj.field）

  ["@constant"]                     = { fg = X.proj_const },     -- 常量名（不可变标识符）
  ["@constant.builtin"]             = { fg = X.other_const, bold = true },    -- 内置常量（nil/None/true/false 等）
  ["@constant.macro"]               = { fg = X.macro },        -- 宏常量（C/CPP 等宏）

  ["@module"]                       = { fg = X.type_decl, italic = true }, -- 模块/命名空间
  ["@module.builtin"]               = { fg = X.type_decl },              -- 内置模块/命名空间
  ["@label"]                        = { fg = X.attribute },       -- 标签（如 C 的 label: 或 heredoc 标签）

  ---------------------------------------------------------------------------
  -- 字面量（Literals）
  ---------------------------------------------------------------------------
  ["@string"]                       = { fg = X.c_string },       -- 普通字符串
  ["@string.documentation"]         = { fg = X.c_doc },       -- 文档字符串（docstring）
  ["@string.regexp"]                = { fg = X.regex }, -- 正则字面量
  ["@string.escape"]                = { fg = X.attribute },       -- 字符串转义（\n、\t 等）
  ["@string.special"]               = { fg = X.c_string },       -- 其他特殊字符串（日期等）
  ["@string.special.symbol"]        = { fg = X.main_literals },     -- 符号/原子（如 :atom）
  ["@string.special.url"]           = { fg = X.url, underline = true, italic = true }, -- URL/链接
  ["@string.special.path"]          = { fg = X.c_string },       -- 文件路径

  ["@character"]                    = { fg = X.char },       -- 字符字面量
  ["@character.special"]            = { fg = X.attribute },       -- 特殊字符（通配符等）

  ["@boolean"]                      = { fg = X.main_literals },      -- 布尔字面量
  ["@number"]                       = { fg = X.number },       -- 数字
  ["@number.float"]                 = { fg = X.number },       -- 浮点数

  ---------------------------------------------------------------------------
  -- 类型与属性（Types & Attributes）
  ---------------------------------------------------------------------------
  ["@type"]                         = { fg = X.type_decl },         -- 类型/类定义与注解
  ["@type.builtin"]                 = { fg = X.other_type },    -- 内置类型（如 int/string）
  ["@type.definition"]              = { link = "@type", bold = true},         -- 类型定义中的标识符
  ["@attribute"]                    = { fg = X.attribute },    -- 属性/注解（Python 装饰器、Rust lifetime）
  ["@attribute.builtin"]            = { fg = X.other_type },    -- 内置属性/注解
  ["@property"]                     = { fg = X.c_property },     -- 键/值对中的键（JSON/YAML 等）

  ---------------------------------------------------------------------------
  -- 函数（Functions）
  ---------------------------------------------------------------------------
  ["@function"]                     = { fg = X.other_decl },         -- 函数定义/引用
  ["@function.builtin"]             = { fg = X.other_func }, -- 内置函数  例如 python print list
  ["@function.call"]                = { fg = X.heading },         -- 函数调用
  ["@function.macro"]               = { fg = X.preproc },        -- 宏函数（定义与调用）

  ["@function.method"]              = { fg = X.c_function },         -- 方法定义
  ["@function.method.call"]         = { fg = X.c_function },         -- 方法调用
  ["@constructor"]                  = { fg = X.proj_type, bold = true },         -- 构造器调用/定义
  ["@operator"]                     = { fg = X.operator },           -- 运算符（+ - * / -> 等）

  ---------------------------------------------------------------------------
  -- 关键字（Keywords）
  ---------------------------------------------------------------------------
  ["@keyword"]                      = { fg = X.keyword },           -- 关键字（通用）
  ["@keyword.coroutine"]            = { fg = X.keyword, italic = true },           -- 协程相关（go/async/await）
  ["@keyword.function"]             = { fg = X.keyword },           -- 定义函数相关（def/func）
  ["@keyword.operator"]             = { fg = X.keyword },           -- 词法运算符（and/or/sizeof 等）
  ["@keyword.import"]               = { fg = X.keyword },           -- 导入/导出（import/from/use）
  ["@keyword.type"]                 = { fg = X.keyword },           -- 类型/结构定义（struct/enum）
  ["@keyword.modifier"]             = { fg = X.keyword, italic = true },           -- 修饰符（const/static/public 等）
  ["@keyword.repeat"]               = { fg = X.keyword },           -- 循环（for/while）
  ["@keyword.return"]               = { fg = X.keyword },           -- 返回（return/yield）
  ["@keyword.debug"]                = { fg = X.keyword },           -- 调试相关
  ["@keyword.exception"]            = { fg = X.keyword },           -- 异常（try/throw/catch）
  ["@keyword.conditional"]          = { fg = X.keyword },           -- 条件（if/else/switch）
  ["@keyword.conditional.ternary"]  = { fg = X.keyword },           -- 三目（?:）
  ["@keyword.directive"]            = { fg = X.keyword },           -- 预处理/指令（#if/#include/#!/usr/bin/env）
  ["@keyword.directive.define"]     = { fg = X.keyword },           -- 预处理定义（#define）

  ---------------------------------------------------------------------------
  -- 标点（Punctuation）
  ---------------------------------------------------------------------------
  ["@punctuation.delimiter"]        = { fg = X.punctuation },        -- 分隔符（, . ; : 等）
  ["@punctuation.bracket"]          = { fg = X.punctuation },        -- 括号（() {} []）
  ["@punctuation.special"]          = { fg = X.punctuation },        -- 特殊标点（内插花括号等）

  ---------------------------------------------------------------------------
  -- 注释（Comments）
  ---------------------------------------------------------------------------
  ["@comment"]                      = { fg = X.comment, italic = true }, -- 普通注释
  ["@comment.documentation"]        = { fg = X.comment, italic = true }, -- 文档注释
  ["@comment.error"]                = { fg = X.error, bold = true },     -- 标注错误类注释（ERROR/FIXME）
  ["@comment.warning"]              = { fg = X.git_change, bold = true },   -- 标注警告类注释（WARNING/HACK）
  ["@comment.todo"]                 = { fg = X.git_add, bold = true },     -- TODO/WIP
  ["@comment.note"]                 = { fg = X.main_function, bold = true },      -- NOTE/INFO/XXX

  ---------------------------------------------------------------------------
  -- Markup / 文本标记（Markdown/LaTeX 等）
  ---------------------------------------------------------------------------
  ["@markup.strong"]                = { fg = X.strong, bold = true },       -- 粗体
  ["@markup.italic"]                = { fg = X.emphasis, italic = true },     -- 斜体
  ["@markup.strikethrough"]         = { fg = X.git_delete, strikethrough = true }, -- 删除线
  ["@markup.underline"]             = { fg = X.url, underline = true },      -- 下划线（仅文字下划线）
  ["@markup.heading"]               = { fg = X.heading, bold = true },       -- 标题（总类）
  ["@markup.quote"]                 = { fg = X.other_type, italic = true },                              -- 引用块
  ["@markup.math"]                  = { fg = X.attribute },                               -- 数学环境
  ["@markup.link"]                  = { fg = X.url, underline = true },      -- 链接（引用文本）
  ["@markup.link.label"]            = { fg = X.attribute },                                -- 链接描述/脚注
  ["@markup.link.url"]              = { fg = X.url, italic = true, underline = true }, -- URL
  ["@markup.raw"]                   = { fg = X.raw, italic = true },        -- 行内代码/原文
  ["@markup.raw.block"]             = { fg = X.raw },                               -- 代码块

  ---------------------------------------------------------------------------
  -- Diff（差异）
  ---------------------------------------------------------------------------
  ["@diff.plus"]                    = { fg = X.diff_add },      -- 新增
  ["@diff.minus"]                   = { fg = X.git_delete },      -- 删除
  ["@diff.delta"]                   = { fg = X.git_change },    -- 变更

  ---------------------------------------------------------------------------
  -- 标签/HTML/XML
  ---------------------------------------------------------------------------
  ["@tag"]                          = { link = "@type" },           -- 标签名
  ["@tag.builtin"]                  = { link = "@type" },           -- 内置标签名（如 HTML5 标签）
  ["@tag.attribute"]                = { fg = X.attribute },      -- 标签属性名
  ["@tag.delimiter"]                = { fg = X.punctuation },         -- 标签分隔符（< > /）

  ---------------------------------------------------------------------------
  -- LSP 语义对齐
  ---------------------------------------------------------------------------
  -- PATCH #5: 命名空间当模块处理，便于统一风格
  ["@lsp.type.namespace"]           = { link = "@module" },
  -- 用 LSP 语义令牌区分“声明的键”和“被访问的成员”
  ["@lsp.typemod.property.declaration"] = { link = "@property" }, -- 声明的键
  ["@lsp.type.property"]                 = { link = "@variable.member" }, -- 被访问的成员

  ["@lsp.typemod.namespace.defaultLibrary"] = { link = "@module.builtin" }, -- 标准库命名空间（如 window/document）按内置模块配色,
  ["@lsp.typemod.variable.defaultLibrary"]  = { link = "@variable.builtin" }, -- 标准库变量（如 console）按内置变量配色,
  ["@lsp.typemod.method.defaultLibrary"]    = { link = "@function.builtin" }, -- 标准库方法（如 console.log）按内置函数配色,
  ["@lsp.typemod.property.defaultLibrary"]  = { link = "@variable.member" }, -- 标准库属性（如 document.body）按成员配色,
  
  ["@lsp.type.method"]   = { link = "@function" }, -- LSP 方法类型回退到函数色,
  ["@lsp.type.property"] = { link = "@variable.member" }, -- LSP 属性类型回退到成员色,
  ---------------------------------------------------------------------------
  -- 非高亮捕获（控制用）
  ---------------------------------------------------------------------------
  ["@none"]                         = { },                      -- 关闭此捕获的高亮
  ["@conceal"]                      = { },                      -- 仅用于隐藏/遮蔽
  ["@spell"]                        = { },                      -- 拼写检查开启区
  ["@nospell"]                      = { },                      -- 拼写检查关闭区
  ---------------------------------------------------------------------------
  -- typescript 
  ---------------------------------------------------------------------------
  -- ["@variable.declaration"]              = { fg = X.other_decl },  --类型组件声明 一般为const SceneCard: React.FC<{ }
["@lsp.typemod.variable.declaration"]  = { fg = X.proj_type }, --类型组件声明 一般为const SceneCard: React.FC<{ }
-- ["@variable.parameter"] = { fg = X.c_doc } --参数名在声明位置”的着色——也就是函数/方法/箭头函数的形参名字
["@lsp.typemod.parameter.declaration"] = { link = "@variable.parameter" },  --参数名在声明位置”的着色——也就是函数/方法/箭头函数的形参名字
    -- ["@lsp.type.function"] = { link = "@function" },
    --   ["@lsp.type.variable"] = { link = "@variable" }, -- 基本回退


},
}


M = require('base46').override_theme(M, 'xcode')



return M
