local override = require("layers.ui.options").hl_override
local colors = require("layers.ui.colors").get().base_30
local theme = require("layers.ui.colors").get().base_16
local ui = require("layers.ui.options")

local black = colors.black
local black2 = colors.black2
local blue = colors.blue
local darker_black = colors.darker_black
local folder_bg = colors.folder_bg
local green = colors.green
local grey = colors.grey
local grey_fg = colors.grey_fg
local light_grey = colors.light_grey
local line = colors.line
local nord_blue = colors.nord_blue
local one_bg = colors.one_bg
local one_bg2 = colors.one_bg2
local pmenu_bg = colors.pmenu_bg
local purple = colors.purple
local red = colors.red
local white = colors.white
local yellow = colors.yellow
local orange = colors.orange
local one_bg3 = colors.one_bg3

local highlights = {
  -- syntax
  Boolean = {
    fg = theme.base09,
  },

  Character = {
    fg = theme.base08,
  },

  Conditional = {
    fg = theme.base0E,
  },

  Constant = {
    fg = theme.base08,
  },

  Define = {
    fg = theme.base0E,
    sp = "none",
  },

  Delimiter = {
    fg = theme.base0F,
  },

  Float = {
    fg = theme.base09,
  },

  Function = {
    fg = theme.base0D,
  },

  Identifier = {
    fg = theme.base08,
    sp = "none",
  },

  Include = {
    fg = theme.base0D,
  },

  Keyword = {
    fg = theme.base0E,
  },

  Label = {
    fg = theme.base0A,
  },

  Number = {
    fg = theme.base09,
  },

  Operator = {
    fg = theme.base05,
    sp = "none",
  },

  PreProc = {
    fg = theme.base0A,
  },

  Repeat = {
    fg = theme.base0A,
  },

  Special = {
    fg = theme.base0C,
  },

  SpecialChar = {
    fg = theme.base0F,
  },

  Statement = {
    fg = theme.base08,
  },

  StorageClass = {
    fg = theme.base0A,
  },

  String = {
    fg = theme.base0B,
  },

  Structure = {
    fg = theme.base0E,
  },

  Tag = {
    fg = theme.base0A,
  },

  Todo = {
    fg = theme.base0A,
    bg = theme.base01,
  },

  Type = {
    fg = theme.base0A,
    sp = "none",
  },

  Typedef = {
    fg = theme.base0A,
  },
  -- misc
  Normal = {
    fg = theme.base05,
    bg = theme.base00,
  },

  Bold = {
    bold = true,
  },

  Debug = {
    fg = theme.base08,
  },

  Directory = {
    fg = theme.base0D,
  },

  Error = {
    fg = theme.base00,
    bg = theme.base08,
  },

  ErrorMsg = {
    fg = theme.base08,
    bg = theme.base00,
  },

  Exception = {
    fg = theme.base08,
  },

  FoldColumn = {
    fg = theme.base0C,
    bg = theme.base01,
  },

  Folded = {
    fg = theme.base03,
    bg = theme.base01,
  },

  IncSearch = {
    fg = theme.base01,
    bg = theme.base09,
  },

  Italic = {
    italic = true,
  },

  Macro = {
    fg = theme.base08,
  },

  MatchParen = {
    bg = theme.base03,
  },

  ModeMsg = {
    fg = theme.base0B,
  },

  MoreMsg = {
    fg = theme.base0B,
  },

  Question = {
    fg = theme.base0D,
  },

  Search = {
    fg = theme.base01,
    bg = theme.base0A,
  },

  Substitute = {
    fg = theme.base01,
    bg = theme.base0A,
    sp = "none",
  },

  SpecialKey = {
    fg = theme.base03,
  },

  TooLong = {
    fg = theme.base08,
  },

  UnderLined = {
    fg = theme.base0B,
  },

  Visual = {
    bg = theme.base02,
  },

  VisualNOS = {
    fg = theme.base08,
  },

  WarningMsg = {
    fg = theme.base08,
  },

  WildMenu = {
    fg = theme.base08,
    bg = theme.base0A,
  },

  Title = {
    fg = theme.base0D,
    sp = "none",
  },

  Conceal = {
    bg = "NONE",
  },

  Cursor = {
    fg = theme.base00,
    bg = theme.base05,
  },

  NonText = {
    fg = theme.base03,
  },

  SignColumn = {
    fg = theme.base03,
    sp = "NONE",
  },

  ColorColumn = {
    bg = theme.base01,
    sp = "none",
  },

  CursorColumn = {
    bg = theme.base01,
    sp = "none",
  },

  CursorLine = {
    bg = black2,
    sp = "none",
  },

  CursorLineNr = {
    fg = white,
    bg = theme.base00,
    sp = "none",
  },

  QuickFixLine = {
    bg = theme.base01,
    sp = "none",
  },

  StatusLine = {
    bg = "NONE",
    sp = "none",
  },

  -- spell

  SpellBad = {
    undercurl = true,
    sp = theme.base08,
  },

  SpellLocal = {
    undercurl = true,
    sp = theme.base0C,
  },

  SpellCap = {
    undercurl = true,
    sp = theme.base0D,
  },

  SpellRare = {
    undercurl = true,
    sp = theme.base0E,
  },

  -- Comments
  Comment = {
    fg = grey_fg,
    italic = ui.italic_comments,
  },

  -- same it bg, so it doesn't appear
  EndOfBuffer = {
    fg = black
  },

  -- For floating windows
  FloatBorder = {
    fg = blue
  },
  NormalFloat = {
    bg = darker_black
  },

  -- Pmenu i.e completion menu
  Pmenu = { bg = one_bg },
  PmenuSbar = { bg = one_bg2 },
  PmenuSel = { bg = pmenu_bg, fg = black },
  PmenuThumb = { bg = grey },

  CmpItemAbbr = {
    fg = white
  },
  CmpItemAbbrMatch = {
    fg = white,
  },
  CmpItemKind = {
    fg = white
  },
  CmpItemMenu = {
    fg = white
  },

  -- inactive statuslines as thin lines
  StatusLineNC = {
    fg = one_bg3,
    underline = true,
  },
  LineNr = {
    fg = grey
  },
  NvimInternalError = {
    fg = red,
  },
  VertSplit = {
    fg = one_bg2,
  },

  -- Dashboard
  AlphaHeader = {
    fg = grey_fg,
  },
  AlphaButtons = {
    fg = light_grey,
  },

  -- Gitsigns.nvim
  DiffAdd = {
    fg = blue,
  },

  DiffAdded = {
    fg = green,
  },

  DiffChange = {
    fg = light_grey,
  },

  DiffChangeDelete = {
    fg = red,
  },

  DiffModified = {
    fg = orange,
  },

  DiffDelete = {
    fg = red,
  },

  DiffRemoved = {
    fg = red,
  },

  -- Indent blankline plugin
  IndentBlanklineChar = {
    fg = line,
  },
  IndentBlanklineSpaceChar = {
    fg = line,
  },
  IndentBlanklineIndent1 = {
    fg = red,
    nocombine = true,
  },
  IndentBlanklineIndent2 = {
    fg = yellow,
    nocombine = true,
  },
  IndentBlanklineIndent3 = {
    fg = green,
    nocombine = true,
  },
  IndentBlanklineIndent4 = {
    fg = colors.teal,
    nocombine = true,
  },
  IndentBlanklineIndent5 = {
    fg = blue,
    nocombine = true,
  },
  IndentBlanklineIndent6 = {
    fg = colors.dark_purple,
    nocombine = true,
  },

  -- Lsp diagnostics

  DiagnosticHint = {
    fg = purple,
  },
  DiagnosticError = {
    fg = red,
  },
  DiagnosticWarn = {
    fg = yellow,
  },
  DiagnosticInformation = {
    fg = green,
  },

  -- NvimTree
  NvimTreeEmptyFolderName = {
    fg = folder_bg,
  },
  NvimTreeEndOfBuffer = {
    fg = darker_black,
  },
  NvimTreeFolderIcon = {
    fg = folder_bg,
  },
  NvimTreeFolderName = {
    fg = folder_bg,
  },
  NvimTreeGitDirty = {
    fg = red,
  },
  NvimTreeIndentMarker = {
    fg = one_bg2,
  },
  -- bg("NvimTreeNormal", darker_black)
  -- bg("NvimTreeNormalNC", darker_black)
  NvimTreeOpenedFolderName = {
    fg = folder_bg,
  },
  NvimTreeRootFolder = {
    fg = red,
    underline = true,
  },
  NvimTreeStatusLine = {
    fg = darker_black,
    bg = darker_black,
  },
  NvimTreeStatusLineNC = {
    fg = darker_black,
    bg = darker_black,
  },
  NvimTreeVertSplit = {
    fg = darker_black,
    bg = darker_black,
  },
  NvimTreeWindowPicker = {
    fg = red,
    bg = black2,
  },

  -- Telescope
  TelescopeBorder = {
    fg = darker_black,
    bg = darker_black,
  },
  TelescopePromptBorder = {
    fg = black2,
    bg = black2,
  },
  TelescopeResultsBorder = {
    fg = darker_black,
    bg = darker_black,
  },
  TelescopePreviewBorder = {
    fg = darker_black,
    bg = darker_black,
  },

  TelescopePromptNormal = {
    fg = white,
    bg = black2,
  },
  TelescopePromptPrefix = {
    fg = red,
    bg = black2,
  },

  TelescopeNormal = {
    bg = darker_black,
  },

  TelescopePreviewTitle = {
    fg = black,
    bg = green,
  },
  TelescopePromptTitle = {
    fg = black,
    bg = red,
  },
  TelescopeResultsTitle = {
    fg = darker_black,
    bg = darker_black,
  },

  TelescopeSelection = {
    bg = black2,
  },

  -- LspSaga
  LspSagaDiagnosticBorder = {
    fg = darker_black,
    bg = darker_black,
  },
  LspSagaDiagnosticTruncateLine = {
    fg = darker_black,
    bg = darker_black,
  },
  LspSagaRenameBorder = {
    fg = darker_black,
    bg = darker_black,
  },
  LspSagaHoverBorder = {
    fg = darker_black,
    bg = darker_black,
  },
  LspSagaDefPreviewBorder = {
    fg = darker_black,
    bg = darker_black,
  },

  -- keybinds cheatsheet

  CheatsheetBorder = {
    fg = black,
    bg = black,
  },
  CheatsheetSectionContent = {
    bg = black,
  },
  CheatsheetHeading = {
    fg = white,
  },

  -- BufferLineBackground = {
  --   fg = colors.grey_fg,
  --   bg = colors.black2,
  -- },

  -- -- buffers
  -- BufferLineBufferSelected = {
  --   fg = colors.white,
  --   bg = colors.black,
  --   bold = true,
  -- },

  -- BufferLineBufferVisible = {
  --   fg = colors.light_grey,
  --   bg = colors.black2,
  -- },

  -- -- for diagnostics = "nvim_lsp"
  -- BufferLineError = {
  --   fg = colors.light_grey,
  --   bg = colors.black2,
  -- },
  -- BufferLineErrorDiagnostic = {
  --   fg = colors.light_grey,
  --   bg = colors.black2,
  -- },

  -- -- close buttons
  -- BufferLineCloseButton = {
  --   fg = colors.light_grey,
  --   bg = colors.black2,
  -- },
  -- BufferLineCloseButtonVisible = {
  --   fg = colors.light_grey,
  --   bg = colors.black2,
  -- },
  -- BufferLineCloseButtonSelected = {
  --   fg = colors.red,
  --   bg = colors.black,
  -- },
  -- BufferLineFill = {
  --   fg = colors.grey_fg,
  --   bg = colors.black2,
  -- },
  -- BufferlineIndicatorSelected = {
  --   fg = colors.black,
  --   bg = colors.black,
  -- },

  -- -- modified
  -- BufferLineModified = {
  --   fg = colors.red,
  --   bg = colors.black2,
  -- },
  -- BufferLineModifiedVisible = {
  --   fg = colors.red,
  --   bg = colors.black2,
  -- },
  -- BufferLineModifiedSelected = {
  --   fg = colors.green,
  --   bg = colors.black,
  -- },

  -- -- separators
  -- BufferLineSeparator = {
  --   fg = colors.black2,
  --   bg = colors.black2,
  -- },
  -- BufferLineSeparatorVisible = {
  --   fg = colors.black2,
  --   bg = colors.black2,
  -- },
  -- BufferLineSeparatorSelected = {
  --   fg = colors.black2,
  --   bg = colors.black2,
  -- },

  -- -- tabs
  -- BufferLineTab = {
  --   fg = colors.light_grey,
  --   bg = colors.one_bg3,
  -- },
  -- BufferLineTabSelected = {
  --   fg = colors.black2,
  --   bg = colors.nord_blue,
  -- },
  -- BufferLineTabClose = {
  --   fg = colors.red,
  --   bg = colors.black,
  -- },

  -- BufferLineDevIconDefaultInactive = {
  --   bg = "NONE",
  -- },

  -- BufferLineDevIconDefaultSelected = {
  --   bg = "NONE",
  -- },

  -- BufferLineDuplicate = {
  --   fg = "NONE",
  --   bg = colors.black2,
  -- },
  -- BufferLineDuplicateSelected = {
  --   fg = colors.red,
  --   bg = colors.black,
  -- },
  -- BufferLineDuplicateVisible = {
  --   fg = colors.blue,
  --   bg = colors.black2,
  -- },

  -- -- custom area
  -- BufferLineRightCustomAreaText1 = {
  --   bg = colors.grey,
  --   fg = colors.white,
  -- },
  -- BufferLineRightCustomAreaText2 = {
  --   fg = colors.red,
  -- },

  CmpItemKindConstant = { fg = theme.base09 },
  CmpItemKindFunction = { fg = theme.base0D },
  CmpItemKindIdentifier = { fg = theme.base08 },
  CmpItemKindField = { fg = theme.base08 },
  CmpItemKindVariable = { fg = theme.base0E },
  CmpItemKindSnippet = { fg = colors.red },
  CmpItemKindText = { fg = theme.base0B },
  CmpItemKindStructure = { fg = theme.base0E },
  CmpItemKindType = { fg = theme.base0A },
  CmpItemKindKeyword = { fg = theme.base07 },
  CmpItemKindMethod = { fg = theme.base0D },
  CmpItemKindConstructor = { fg = colors.blue },
  CmpItemKindFolder = { fg = theme.base07 },
  CmpItemKindModule = { fg = theme.base0A },
  CmpItemKindProperty = { fg = theme.base08 },
  -- CmpItemKindEnum = { fg = "" },
  CmpItemKindUnit = { fg = theme.base0E },
  -- CmpItemKindClass = { fg = "" },
  CmpItemKindFile = { fg = theme.base07 },
  -- CmpItemKindInterface = { fg = "" },
  CmpItemKindColor = { fg = colors.red },
  CmpItemKindReference = { fg = theme.base05 },
  -- CmpItemKindEnumMember = { fg = "" },
  CmpItemKindStruct = { fg = theme.base0E },
  -- CmpItemKindValue = { fg = "" },
  -- CmpItemKindEvent = { fg = "" },
  CmpItemKindOperator = { fg = theme.base05 },
  CmpItemKindTypeParameter = { fg = theme.base08 },

  DevIconc = { bg = "NONE", fg = colors.blue },
  DevIconcss = { bg = "NONE", fg = colors.blue },
  DevIcondeb = { bg = "NONE", fg = colors.cyan },
  DevIconDockerfile = { bg = "NONE", fg = colors.cyan },
  DevIconhtml = { bg = "NONE", fg = colors.baby_pink },
  DevIconjpeg = { bg = "NONE", fg = colors.dark_purple },
  DevIconjpg = { bg = "NONE", fg = colors.dark_purple },
  DevIconjs = { bg = "NONE", fg = colors.sun },
  DevIconkt = { bg = "NONE", fg = colors.orange },
  DevIconlock = { bg = "NONE", fg = colors.red },
  DevIconlua = { bg = "NONE", fg = colors.blue },
  DevIconmp3 = { bg = "NONE", fg = colors.white },
  DevIconmp4 = { bg = "NONE", fg = colors.white },
  DevIconout = { bg = "NONE", fg = colors.white },
  DevIconpng = { bg = "NONE", fg = colors.dark_purple },
  DevIconpy = { bg = "NONE", fg = colors.cyan },
  DevIcontoml = { bg = "NONE", fg = colors.blue },
  DevIconts = { bg = "NONE", fg = colors.teal },
  DevIconttf = { bg = "NONE", fg = colors.white },
  DevIconrb = { bg = "NONE", fg = colors.pink },
  DevIconrpm = { bg = "NONE", fg = colors.orange },
  DevIconvue = { bg = "NONE", fg = colors.vibrant_green },
  DevIconwoff = { bg = "NONE", fg = colors.white },
  DevIconwoff2 = { bg = "NONE", fg = colors.white },
  DevIconxz = { bg = "NONE", fg = colors.sun },
  DevIconzip = { bg = "NONE", fg = colors.sun },

  -- git commits
  gitcommitOverflow = {
    fg = theme.base08,
  },

  gitcommitSummary = {
    fg = theme.base08,
  },

  gitcommitComment = {
    fg = theme.base03,
  },

  gitcommitUntracked = {
    fg = theme.base03,
  },

  gitcommitDiscarded = {
    fg = theme.base03,
  },

  gitcommitSelected = {
    fg = theme.base03,
  },

  gitcommitHeader = {
    fg = theme.base0E,
  },

  gitcommitSelectedType = {
    fg = theme.base0D,
  },

  gitcommitUnmergedType = {
    fg = theme.base0D,
  },

  gitcommitDiscardedType = {
    fg = theme.base0D,
  },

  gitcommitBranch = {
    fg = theme.base09,
    bold = true,
  },

  gitcommitUntrackedFile = {
    fg = theme.base0A,
  },

  gitcommitUnmergedFile = {
    fg = theme.base08,
    bold = true,
  },

  gitcommitDiscardedFile = {
    fg = theme.base08,
    bold = true,
  },

  gitcommitSelectedFile = {
    fg = theme.base0B,
    bold = true,
  },

  mailQuoted1 = {
    fg = theme.base0A,
  },

  mailQuoted2 = {
    fg = theme.base0B,
  },

  mailQuoted3 = {
    fg = theme.base0E,
  },

  mailQuoted4 = {
    fg = theme.base0C,
  },

  mailQuoted5 = {
    fg = theme.base0D,
  },

  mailQuoted6 = {
    fg = theme.base0A,
  },

  mailURL = {
    fg = theme.base0D,
  },

  mailEmail = {
    fg = theme.base0D,
  },


  TSAnnotation = {
    fg = theme.base0F,
    sp = "none",
  },

  TSAttribute = {
    fg = theme.base0A,
    sp = "none",
  },

  TSCharacter = {
    fg = theme.base08,
    sp = "none",
  },

  TSConstBuiltin = {
    fg = theme.base09,
    sp = "none",
  },

  TSConstMacro = {
    fg = theme.base08,
    sp = "none",
  },

  TSError = {
    fg = theme.base08,
    sp = "none",
  },

  TSException = {
    fg = theme.base08,
    sp = "none",
  },

  TSFloat = {
    fg = theme.base09,
    sp = "none",
  },

  TSFuncBuiltin = {
    fg = theme.base0D,
    sp = "none",
  },

  TSFuncMacro = {
    fg = theme.base08,
    sp = "none",
  },

  TSKeywordOperator = {
    fg = theme.base0E,
    sp = "none",
  },

  TSMethod = {
    fg = theme.base0D,
    sp = "none",
  },

  TSNamespace = {
    fg = theme.base08,
    sp = "none",
  },

  TSNone = {
    fg = theme.base05,
    sp = "none",
  },

  TSParameter = {
    fg = theme.base08,
    sp = "none",
  },

  TSParameterReference = {
    fg = theme.base05,
    sp = "none",
  },

  TSPunctDelimiter = {
    fg = theme.base0F,
    sp = "none",
  },

  TSPunctSpecial = {
    fg = theme.base05,
    sp = "none",
  },

  TSStringRegex = {
    fg = theme.base0C,
    sp = "none",
  },

  TSStringEscape = {
    fg = theme.base0C,
    sp = "none",
  },

  TSSymbol = {
    fg = theme.base0B,
    sp = "none",
  },

  TSTagDelimiter = {
    fg = theme.base0F,
    sp = "none",
  },

  TSText = {
    fg = theme.base05,
    sp = "none",
  },

  TSStrong = {
    bold = true,
  },

  TSEmphasis = {
    fg = theme.base09,
    sp = "none",
  },

  TSStrike = {
    fg = theme.base00,
    sp = "none",
    strikethrough = true,
  },

  TSLiteral = {
    fg = theme.base09,
    sp = "none",
  },

  TSURI = {
    fg = theme.base09,
    sp = "none",
    underline = true,
  },

  TSTypeBuiltin = {
    fg = theme.base0A,
    sp = "none",
  },

  TSVariableBuiltin = {
    fg = theme.base09,
    sp = "none",
  },

  TSDefinition = {
    sp = theme.base04,
    underline = true,
  },

  TSDefinitionUsage = {
    sp = theme.base04,
    underline = true,
  },

  TSCurrentScope = {
    bold = true,
  },
}

if ui.transparency then
  highlights["Normal"] = {
    bg = "NONE",
  }
  highlights["Folded"] = {
    fg = "NONE",
    bg = "NONE",
  }
  highlights["Comment"] = {
    fg = grey,
  }
end

local section_title_colors = {
  white,
  blue,
  red,
  green,
  yellow,
  purple,
  orange,
}
for i, color in ipairs(section_title_colors) do
  highlights["CheatsheetTitle" .. i] = {
    fg = black,
    bg = color,
  }
end

-- Disable some highlight in nvim tree if transparency enabled
if ui.transparency then
  highlights["NormalFloat"] = {
    bg = "NONE",
  }
  highlights["NvimTreeNormal"] = {
    bg = "NONE",
  }
  highlights["NvimTreeNormalNC"] = {
    bg = "NONE",
  }
  highlights["NvimTreeStatusLineNC"] = {
    bg = "NONE",
  }
  highlights["NvimTreeVertSplit"] = {
    fg = grey,
    bg = "NONE",
  }

  -- telescope
  highlights["TelescopeBorder"] = {
    bg = "NONE",
  }
  highlights["TelescopePrompt"] = {
    bg = "NONE",
  }
  highlights["TelescopeResults"] = {
    bg = "NONE",
  }
  highlights["TelescopePromptBorder"] = {
    bg = "NONE",
  }
  highlights["TelescopePromptNormal"] = {
    bg = "NONE",
  }
  highlights["TelescopeNormal"] = {
    bg = "NONE",
  }
  highlights["TelescopePromptPrefix"] = {
    bg = "NONE",
  }
  highlights["TelescopeBorder"] = {
    fg = one_bg,
  }
  highlights["TelescopeResultsTitle"] = {
    fg = black,
    bg = blue,
  }
end

for hl, col in pairs(highlights) do
  vim.api.nvim_set_hl(0, hl, col)
end

vim.g.terminal_color_0 = "#" .. theme.base00
vim.g.terminal_color_1 = "#" .. theme.base08
vim.g.terminal_color_2 = "#" .. theme.base0B
vim.g.terminal_color_3 = "#" .. theme.base0A
vim.g.terminal_color_4 = "#" .. theme.base0D
vim.g.terminal_color_5 = "#" .. theme.base0E
vim.g.terminal_color_6 = "#" .. theme.base0C
vim.g.terminal_color_7 = "#" .. theme.base05
vim.g.terminal_color_8 = "#" .. theme.base03
vim.g.terminal_color_9 = "#" .. theme.base08
vim.g.terminal_color_10 = "#" .. theme.base0B
vim.g.terminal_color_11 = "#" .. theme.base0A
vim.g.terminal_color_12 = "#" .. theme.base0D
vim.g.terminal_color_13 = "#" .. theme.base0E
vim.g.terminal_color_14 = "#" .. theme.base0C
vim.g.terminal_color_15 = "#" .. theme.base07

if #override ~= 0 then
  require(override)
end
