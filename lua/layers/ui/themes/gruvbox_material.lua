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


-- ===== polish_hl：按 Treesitter/LSP 语义映射到 X 方案 =====
M.polish_hl = {

    treesitter = {

  ---------------------------------------------------------------------------
  -- 标识符（Identifier）
  ---------------------------------------------------------------------------
  ["@variable"]                     = { fg = color.fg0 },         -- 普通变量/标识符
  ["@variable.builtin"]             = { fg = color.blue },    -- 内置变量（如 this/self/arguments）
  ["@variable.parameter"]           = { fg = color.fg1 },        -- 函数/方法参数
  ["@variable.parameter.builtin"]   = { fg = color.purple },    -- 特殊参数（如 ...、_ 等）
  ["@variable.member"]              = { fg = color.blue },        -- 成员/字段（obj.field）

  ["@constant"]                     = { fg = color.bule },     -- 常量名（不可变标识符）
  ["@constant.builtin"]             = { fg = color.bule, bold = true },    -- 内置常量（nil/None/true/false 等）
  ["@constant.macro"]               = { fg = color.purple },        -- 宏常量（C/CPP 等宏）

  ["@module"]                       = { fg = color.purple, italic = true }, -- 模块/命名空间
  ["@module.builtin"]               = { fg = color.purple },              -- 内置模块/命名空间
  ["@label"]                        = { fg = color.orange },       -- 标签（如 C 的 label: 或 heredoc 标签）

  ---------------------------------------------------------------------------
  -- 字面量（Literals）
  ---------------------------------------------------------------------------
  ["@string"]                       = { fg = color.aqua },       -- 普通字符串
  -- ["@string.documentation"]         = { fg = X.c_doc },       -- 文档字符串（docstring）
  -- ["@string.regexp"]                = { fg = X.regex }, -- 正则字面量
  -- ["@string.escape"]                = { fg = X.attribute },       -- 字符串转义（\n、\t 等）
  -- ["@string.special"]               = { fg = X.c_string },       -- 其他特殊字符串（日期等）
  -- ["@string.special.symbol"]        = { fg = color.aqua },     -- 符号/原子（如 :atom）
  -- ["@string.special.url"]           = { fg = X.url, underline = true, italic = true }, -- URL/链接
  -- ["@string.special.path"]          = { fg = X.c_string },       -- 文件路径

  -- ["@character"]                    = { fg = X.char },       -- 字符字面量
  ["@character.special"]            = { fg = color.orange },       -- 特殊字符（通配符等）

  ["@boolean"]                      = { fg = color.aqua },      -- 布尔字面量
  ["@number"]                       = { fg = color.purple },       -- 数字
  ["@number.float"]                 = { fg = color.purple },       -- 浮点数

  ---------------------------------------------------------------------------
  -- 类型与属性（Types & Attributes）
  ---------------------------------------------------------------------------
  ["@type"]                         = { fg = color.yellow },         -- 类型/类定义与注解
  ["@type.builtin"]                 = { fg = color.aqua },    -- 内置类型（如 int/string）
  ["@type.definition"]              = { link = "@type", bold = true},         -- 类型定义中的标识符
  ["@attribute"]                    = { fg = color.orange },    -- 属性/注解（Python 装饰器、Rust lifetime）
  ["@attribute.builtin"]            = { fg = color.aqua },    -- 内置属性/注解
  ["@property"]                     = { fg = color.blue },     -- 键/值对中的键（JSON/YAML 等）

  ---------------------------------------------------------------------------
  -- 函数（Functions）
  ---------------------------------------------------------------------------
  ["@function"]                     = { fg = color.green },         -- 函数定义/引用
  ["@function.builtin"]             = { fg = color.green }, -- 内置函数  例如 python print list
  ["@function.call"]                = { fg = color.green },         -- 函数调用
  ["@function.macro"]               = { fg = color.purple },        -- 宏函数（定义与调用）

  ["@function.method"]              = { fg = color.green },         -- 方法定义
  ["@function.method.call"]         = { fg = color.green },         -- 方法调用
  ["@constructor"]                  = { fg = color.yellow, bold = true },         -- 构造器调用/定义
  ["@operator"]                     = { fg = color.orange },           -- 运算ß（+ - * / -> 等）

  ---------------------------------------------------------------------------
  -- 关键字（Keywords）
  ---------------------------------------------------------------------------
  ["@keyword"]                      = { fg = color.red },           -- 关键字（通用）
  ["@keyword.coroutine"]            = { fg = color.red, italic = true },           -- 协程相关（go/async/await）
  ["@keyword.function"]             = { fg = color.red },           -- 定义函数相关（def/func）
  ["@keyword.operator"]             = { fg = color.red },           -- 词法运算符（and/or/sizeof 等）
  ["@keyword.import"]               = { fg = color.red },           -- 导入/导出（import/from/use）
  ["@keyword.type"]                 = { fg = color.red },           -- 类型/结构定义（struct/enum）
  ["@keyword.modifier"]             = { fg = color.red, italic = true },           -- 修饰符（const/static/public 等）
  ["@keyword.repeat"]               = { fg = color.red },           -- 循环（for/while）
  ["@keyword.return"]               = { fg = color.red },           -- 返回（return/yield）
  ["@keyword.debug"]                = { fg = color.red },           -- 调试相关
  ["@keyword.exception"]            = { fg = color.red },           -- 异常（try/throw/catch）
  ["@keyword.conditional"]          = { fg = color.red },           -- 条件（if/else/switch）
  ["@keyword.conditional.ternary"]  = { fg = color.red },           -- 三目（?:）
  ["@keyword.directive"]            = { fg = color.red },           -- 预处理/指令（#if/#include/#!/usr/bin/env）
  ["@keyword.directive.define"]     = { fg = color.red },           -- 预处理定义（#define）

  ---------------------------------------------------------------------------
  -- 标点（Punctuation）
  ---------------------------------------------------------------------------
  ["@punctuation.delimiter"]        = { fg = color.fg0 },        -- 分隔符（, . ; : 等）
  ["@punctuation.bracket"]          = { fg = color.fg0 },        -- 括号（() {} []）
  ["@punctuation.special"]          = { fg = color.orange },        -- 特殊标点（内插花括号等）

  ---------------------------------------------------------------------------
  -- 注释（Comments）
  ---------------------------------------------------------------------------
  -- ["@comment"]                      = { fg = X.comment, italic = true }, -- 普通注释
  -- ["@comment.documentation"]        = { fg = X.comment, italic = true }, -- 文档注释
  -- ["@comment.error"]                = { fg = X.error, bold = true },     -- 标注错误类注释（ERROR/FIXME）
  -- ["@comment.warning"]              = { fg = X.git_change, bold = true },   -- 标注警告类注释（WARNING/HACK）
  -- ["@comment.todo"]                 = { fg = X.git_add, bold = true },     -- TODO/WIP
  -- ["@comment.note"]                 = { fg = X.main_function, bold = true },      -- NOTE/INFO/XXX

  ---------------------------------------------------------------------------
  -- Markup / 文本标记（Markdown/LaTeX 等）
  ---------------------------------------------------------------------------
  -- ["@markup.strong"]                = { fg = X.strong, bold = true },       -- 粗体
  -- ["@markup.italic"]                = { fg = X.emphasis, italic = true },     -- 斜体
  -- ["@markup.strikethrough"]         = { fg = X.git_delete, strikethrough = true }, -- 删除线
  -- ["@markup.underline"]             = { fg = X.url, underline = true },      -- 下划线（仅文字下划线）
  -- ["@markup.heading"]               = { fg = X.heading, bold = true },       -- 标题（总类）
  -- ["@markup.quote"]                 = { fg = X.other_type, italic = true },                              -- 引用块
  -- ["@markup.math"]                  = { fg = X.attribute },                               -- 数学环境
  -- ["@markup.link"]                  = { fg = X.url, underline = true },      -- 链接（引用文本）
  -- ["@markup.link.label"]            = { fg = X.attribute },                                -- 链接描述/脚注
  -- ["@markup.link.url"]              = { fg = X.url, italic = true, underline = true }, -- URL
  -- ["@markup.raw"]                   = { fg = X.raw, italic = true },        -- 行内代码/原文
  -- ["@markup.raw.block"]             = { fg = X.raw },                               -- 代码块

  ---------------------------------------------------------------------------
  -- Diff（差异）
  ---------------------------------------------------------------------------
  -- ["@diff.plus"]                    = { fg = X.diff_add },      -- 新增
  -- ["@diff.minus"]                   = { fg = X.git_delete },      -- 删除
  -- ["@diff.delta"]                   = { fg = X.git_change },    -- 变更

  ---------------------------------------------------------------------------
  -- 标签/HTML/XML
  ---------------------------------------------------------------------------
  -- ["@tag"]                          = { link = "@type" },           -- 标签名
  -- ["@tag.builtin"]                  = { link = "@type" },           -- 内置标签名（如 HTML5 标签）
  -- ["@tag.attribute"]                = { fg = X.attribute },      -- 标签属性名
  -- ["@tag.delimiter"]                = { fg = X.punctuation },         -- 标签分隔符（< > /）

  ---------------------------------------------------------------------------
  -- LSP 语义对齐
  ---------------------------------------------------------------------------
  -- PATCH #5: 命名空间当模块处理，便于统一风格
  ["@lsp.type.namespace"]           = { link = "@module" },
  -- 用 LSP 语义令牌区分“声明的键”和“被访问的成员”
  -- ["@lsp.typemod.property.declaration"] = { link = "@property" }, -- 声明的键
  -- ["@lsp.type.property"]                 = { link = "@variable.member" }, -- 被访问的成员

  ["@lsp.typemod.namespace.defaultLibrary"] = { link = "@module.builtin" }, -- 标准库命名空间（如 window/document）按内置模块配色,
  ["@lsp.typemod.variable.defaultLibrary"]  = { link = "@variable.builtin" }, -- 标准库变量（如 console）按内置变量配色,
  ["@lsp.typemod.method.defaultLibrary"]    = { link = "@function.builtin" }, -- 标准库方法（如 console.log）按内置函数配色,
  ["@lsp.typemod.property.defaultLibrary"]  = { link = "@variable.member" }, -- 标准库属性（如 document.body）按成员配色,

  ["@lsp.type.method"]   = { link = "@function" }, -- LSP 方法类型回退到函数色,
  ---------------------------------------------------------------------------
  -- 非高亮捕获（控制用）
  ---------------------------------------------------------------------------
  ["@none"]                         = { },                      -- 关闭此捕获的高亮
  ["@conceal"]                      = { },                      -- 仅用于隐藏/遮蔽
  ["@spell"]                        = { },                      -- 拼写检查开启区
  ["@nospell"]                      = { },                      -- 拼写检查关闭区
  ---------------------------------------------------------------------------
},
}

M.type = 'dark'

M = require('base46').override_theme(M, 'gruvbox_material')

return M
