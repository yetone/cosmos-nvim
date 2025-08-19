-- 从 'base46' 库加载 'base_16' 主题的颜色配置
local theme = require('base46').get_theme_tb('base_16')

-- 返回一个包含 Tree-sitter 高亮组定义的表
return {
  -- `@annotation` (注解/装饰器) 不是默认的捕获组，但很有用。
  -- 比如 Java 的 @Override, Python 的 @decorator
  ['@annotation'] = {
    fg = theme.base0F,
  },

  -- 属性。比如 HTML 标签中的 class="...", 或者 C# 中的 [Serializable]
  ['@attribute'] = {
    fg = theme.base0A,
  },

  -- 🔧 修复：Character 应该与标准配置一致
  ['@character'] = {
    fg = theme.base08,  -- 从 base0B 改为 base08，与标准 Character 一致
  },

  ['@constructor'] = { fg = theme.base0A },

  -- 🔧 修复：常量应该统一
  ['@constant'] = {
    fg = theme.base08,  -- 添加通用常量，与标准 Constant 一致
  },
  ['@constant.builtin'] = {
    fg = theme.base08,  -- 从 base09 改为 base08，保持一致性
  },
  ['@constant.macro'] = {
    fg = theme.base0A,
  },

  -- 语法错误
  ['@error'] = {
    fg = theme.base08,
  },

  -- 异常处理关键字。比如 try, catch, throw
  ['@exception'] = {
    fg = theme.base0E,
  },

  -- 浮点数字面量。比如 3.14
  ['@float'] = {
    fg = theme.base09,
  },

  -- 关键字。比如 for, while, if
  ['@keyword'] = {
    fg = theme.base0E,
  },

  -- 定义函数的关键字。比如 function, def, fun
  ['@keyword.function'] = {
    fg = theme.base0E,
  },

  -- return 关键字
  ['@keyword.return'] = {
    fg = theme.base0E,
  },

  -- 函数调用或定义
  ['@function'] = {
    fg = theme.base0D,
  },

  -- 内置函数。比如 print(), len()
  ['@function.builtin'] = {
    fg = theme.base0D,
  },

  -- 宏函数
  ['@function.macro'] = {
    fg = theme.base0A,
  },

  -- 作为关键字的运算符。比如 and, or, not
  ['@keyword.operator'] = {
    fg = theme.base0E,
  },

  -- 方法调用 (对象的方法)
  ['@method'] = {
    fg = theme.base0D,
  },

  -- 命名空间或模块。比如 C++ 的 std::, C# 的 System
  ['@namespace'] = {
    fg = theme.base0C,
  },

  -- 无特定高亮的部分
  ['@none'] = {
    fg = theme.base05,
  },

  -- 函数参数
  ['@parameter'] = {
    fg = theme.base05,
  },

  -- 引用 (非标准捕获组)
  ['@reference'] = {
    fg = theme.base05,
  },

  -- 括号。 (), [], {}
  ['@punctuation.bracket'] = {
    fg = theme.base05,
  },

  -- 分隔符。比如 ,, ;, :
  ['@punctuation.delimiter'] = {
    fg = theme.base05,
  },

  -- 特殊标点。比如字符串模板中的 ${}
  ['@punctuation.special'] = {
    fg = theme.base0A,
  },

  -- 正则表达式
  ['@string.regex'] = {
    fg = theme.base0B,
  },

  -- 字符串中的转义字符。比如 \n, \t
  ['@string.escape'] = {
    fg = theme.base0B,
  },

  -- 符号 (Symbol)。比如 Lisp 或 Ruby 中的符号
  ['@symbol'] = {
    fg = theme.base0B,
  },

  -- 标签。比如 HTML/XML 的 <div>
  ['@tag'] = {
    link = 'Tag', -- 链接到 Vim 内置的 Tag 高亮组
  },

  -- 标签属性名。比如 <div class="..."> 中的 "class"
  ['@tag.attribute'] = {
    link = '@property', -- 链接到 @property 高亮组
  },

  -- 标签的分隔符。比如 <, >, />
  ['@tag.delimiter'] = {
    fg = theme.base0F,
  },

  -- 普通文本
  ['@text'] = {
    fg = theme.base05,
  },

  -- 加粗文本 (常用于 Markdown)
  ['@text.strong'] = {
    bold = true,
  },

  -- 强调文本 (通常是斜体，常用于 Markdown)
  ['@text.emphasis'] = {
    fg = theme.base09,
    italic = true,
  },

  -- 删除线文本 (常用于 Markdown)
  ['@text.strike'] = {
    fg = theme.base00,
    strikethrough = true,
  },

  -- 行内代码块或字面量文本 (常用于 Markdown)
  ['@text.literal'] = {
    fg = theme.base09,
  },

  -- URI 或链接
  ['@text.uri'] = {
    fg = theme.base0D,
    underline = true,
  },

  -- 内置类型。比如 int, string, bool
  ['@type.builtin'] = {
    fg = theme.base0C,
  },

  -- 变量
  ['@variable'] = {
    fg = theme.base05,
  },

  -- 内置变量。比如 this, self
  ['@variable.builtin'] = {
    fg = theme.base09,
  },

  -- 🔧 添加：identifier 映射
  ['@identifier'] = {
    fg = theme.base08,  -- 与标准 Identifier 一致
  },

  -- 全局变量 (这里未定义，作为注释占位符)
  -- ['variable.global']

  -- 变量/函数的定义处
  ['@definition'] = {
    sp = theme.base04, -- 设置下划线颜色
    underline = true,
  },

  -- (LSP) 光标下符号的定义处高亮
  TSDefinitionUsage = {
    sp = theme.base04, -- 设置下划线颜色
    underline = true,
  },

  -- 作用域界定符。比如 {}
  ['@scope'] = {
    bold = true,
  },

  -- 结构体/对象的字段 (Field)
  ['@field'] = {
    fg = theme.base08,
  },
  --
  -- 键值对中的键 (Key) (这里被注释掉了)
  -- ["@field.key"] = {
  --   fg = theme.base0D,
  -- },

  -- 对象的属性 (Property)
  ['@property'] = {
    fg = theme.base0E,
  },

  -- 包含/导入语句。比如 #include, import
  ['@include'] = {
    link = 'Include', -- 链接到 Vim 内置的 Include 高亮组
  },

  -- 条件语句关键字。比如 if, else, switch
  ['@conditional'] = {
    link = 'Conditional', -- 链接到 Vim 内置的 Conditional 高亮组
  },
}
