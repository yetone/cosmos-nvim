local cmd = vim.cmd

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

-- functions for setting highlights
local fg = require("core.utils").fg
local fg_bg = require("core.utils").fg_bg
local bg = require("core.utils").bg

-- Comments
if ui.italic_comments then
  fg("Comment", grey_fg .. " gui=italic")
else
  fg("Comment", grey_fg)
end

-- Disable cursor line
-- cmd "hi clear CursorLine"
-- Line number
fg("cursorlinenr", white)

-- same it bg, so it doesn't appear
fg("EndOfBuffer", black)

-- For floating windows
fg("FloatBorder", blue)
bg("NormalFloat", darker_black)

-- Pmenu
bg("Pmenu", one_bg)
bg("PmenuSbar", one_bg2)
bg("PmenuSel", pmenu_bg)
bg("PmenuThumb", nord_blue)
fg("CmpItemAbbr", white)
fg("CmpItemAbbrMatch", white)
fg("CmpItemKind", white)
fg("CmpItemMenu", white)

-- misc

-- inactive statuslines as thin lines
fg("StatusLineNC", one_bg3 .. " gui=underline")

fg("LineNr", grey)
fg("NvimInternalError", red)
fg("VertSplit", one_bg2)

if ui.transparency then
   bg("Normal", "NONE")
   bg("Folded", "NONE")
   fg("Folded", "NONE")
   fg("Comment", grey)
end

-- [[ Plugin Highlights

-- Dashboard
fg("AlphaHeader", grey_fg)
fg("AlphaButtons", light_grey)

-- Git signs
fg_bg("DiffAdd", blue, "NONE")
fg_bg("DiffChange", grey_fg, "NONE")
fg_bg("DiffChangeDelete", red, "NONE")
fg_bg("DiffModified", red, "NONE")
fg_bg("DiffDelete", red, "NONE")

-- Indent blankline plugin
fg("IndentBlanklineChar", line)
fg("IndentBlanklineSpaceChar", line)

-- Lsp diagnostics

fg("DiagnosticHint", purple)
fg("DiagnosticError", red)
fg("DiagnosticWarn", yellow)
fg("DiagnosticInformation", green)

-- NvimTree
fg("NvimTreeEmptyFolderName", folder_bg)
fg("NvimTreeEndOfBuffer", darker_black)
fg("NvimTreeFolderIcon", folder_bg)
fg("NvimTreeFolderName", folder_bg)
fg("NvimTreeGitDirty", red)
fg("NvimTreeIndentMarker", one_bg2)
-- bg("NvimTreeNormal", darker_black)
-- bg("NvimTreeNormalNC", darker_black)
fg("NvimTreeOpenedFolderName", folder_bg)
fg("NvimTreeRootFolder", red .. " gui=underline") -- enable underline for root folder in nvim tree
fg_bg("NvimTreeStatusLine", darker_black, darker_black)
fg_bg("NvimTreeStatusLineNC", darker_black, darker_black)
fg_bg("NvimTreeVertSplit", darker_black, darker_black)
fg_bg("NvimTreeWindowPicker", red, black2)

-- Telescope
fg_bg("TelescopeBorder", darker_black, darker_black)
fg_bg("TelescopePromptBorder", black2, black2)
fg_bg("TelescopeResultsBorder", darker_black, darker_black)
fg_bg("TelescopePreviewBorder", darker_black, darker_black)

fg_bg("TelescopePromptNormal", white, black2)
fg_bg("TelescopePromptPrefix", red, black2)

bg("TelescopeNormal", darker_black)

fg_bg("TelescopePreviewTitle", black, green)
fg_bg("TelescopePromptTitle", black, red)
fg_bg("TelescopeResultsTitle", darker_black, darker_black)

bg("TelescopeSelection", black2)

-- LspSaga
fg_bg("LspSagaDiagnosticBorder", darker_black, darker_black)
fg_bg("LspSagaDiagnosticTruncateLine", darker_black, darker_black)
fg_bg("LspSagaRenameBorder", darker_black, darker_black)
fg_bg("LspSagaHoverBorder", darker_black, darker_black)
fg_bg("LspSagaDefPreviewBorder", darker_black, darker_black)

-- keybinds cheatsheet

fg_bg("CheatsheetBorder", black, black)
bg("CheatsheetSectionContent", black)
fg("CheatsheetHeading", white)

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
   vim.cmd("highlight CheatsheetTitle" .. i .. " guibg = " .. color .. " guifg=" .. black)
end

-- Disable some highlight in nvim tree if transparency enabled
if ui.transparency then
   bg("NormalFloat", "NONE")
   bg("NvimTreeNormal", "NONE")
   bg("NvimTreeNormalNC", "NONE")
   bg("NvimTreeStatusLineNC", "NONE")
   fg_bg("NvimTreeVertSplit", grey, "NONE")

   -- telescope
   bg("TelescopeBorder", "NONE")
   bg("TelescopePrompt", "NONE")
   bg("TelescopeResults", "NONE")
   bg("TelescopePromptBorder", "NONE")
   bg("TelescopePromptNormal", "NONE")
   bg("TelescopeNormal", "NONE")
   bg("TelescopePromptPrefix", "NONE")
   fg("TelescopeBorder", one_bg)
   fg_bg("TelescopeResultsTitle", black, blue)
end

local highlights = {

   BufferLineBackground = {
      fg = colors.grey_fg,
      bg = colors.black2,
   },

   -- buffers
   BufferLineBufferSelected = {
      fg = colors.white,
      bg = colors.black,
      bold = true,
   },

   BufferLineBufferVisible = {
      fg = colors.light_grey,
      bg = colors.black2,
   },

   -- for diagnostics = "nvim_lsp"
   BufferLineError = {
      fg = colors.light_grey,
      bg = colors.black2,
   },
   BufferLineErrorDiagnostic = {
      fg = colors.light_grey,
      bg = colors.black2,
   },

   -- close buttons
   BufferLineCloseButton = {
      fg = colors.light_grey,
      bg = colors.black2,
   },
   BufferLineCloseButtonVisible = {
      fg = colors.light_grey,
      bg = colors.black2,
   },
   BufferLineCloseButtonSelected = {
      fg = colors.red,
      bg = colors.black,
   },
   BufferLineFill = {
      fg = colors.grey_fg,
      bg = colors.black2,
   },
   BufferlineIndicatorSelected = {
      fg = colors.black,
      bg = colors.black,
   },

   -- modified
   BufferLineModified = {
      fg = colors.red,
      bg = colors.black2,
   },
   BufferLineModifiedVisible = {
      fg = colors.red,
      bg = colors.black2,
   },
   BufferLineModifiedSelected = {
      fg = colors.green,
      bg = colors.black,
   },

   -- separators
   BufferLineSeparator = {
      fg = colors.black2,
      bg = colors.black2,
   },
   BufferLineSeparatorVisible = {
      fg = colors.black2,
      bg = colors.black2,
   },
   BufferLineSeparatorSelected = {
      fg = colors.black2,
      bg = colors.black2,
   },

   -- tabs
   BufferLineTab = {
      fg = colors.light_grey,
      bg = colors.one_bg3,
   },
   BufferLineTabSelected = {
      fg = colors.black2,
      bg = colors.nord_blue,
   },
   BufferLineTabClose = {
      fg = colors.red,
      bg = colors.black,
   },

   BufferLineDevIconDefaultInactive = {
      bg = "NONE",
   },

   BufferLineDevIconDefaultSelected = {
      bg = "NONE",
   },

   BufferLineDuplicate = {
      fg = "NONE",
      bg = colors.black2,
   },
   BufferLineDuplicateSelected = {
      fg = colors.red,
      bg = colors.black,
   },
   BufferLineDuplicateVisible = {
      fg = colors.blue,
      bg = colors.black2,
   },

   -- custom area
   BufferLineRightCustomAreaText1 = {
      bg = colors.grey,
      fg = colors.white,
   },
   BufferLineRightCustomAreaText2 = {
      fg = colors.red,
   },

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

for hl, col in pairs(highlights) do
   vim.api.nvim_set_hl(0, hl, col)
end

if #override ~= 0 then
   require(override)
end
