local colors = require('base46').get_theme_tb('base_30')

return {

  BufferLineBackground = {
    fg = colors.grey_fg,
    bg = colors.black2,
  },

  -- buffers
  BufferLineBufferSelected = {
    fg = colors.white,
    bg = colors.black,
  },

  BufferLineBufferVisible = {
    fg = colors.light_grey,
    bg = colors.black2,
  },

  -- for diagnostics = "nvim_lsp"
  BufferLineHint = {
    fg = colors.light_grey,
    bg = colors.black2,
  },
  BufferLineHintVisible = {
    fg = colors.light_grey,
    bg = colors.black2,
  },
  BufferLineHintDiagnostic = {
    fg = colors.light_grey,
    bg = colors.black2,
  },
  BufferLineHintDiagnosticVisible = {
    fg = colors.light_grey,
    bg = colors.black2,
  },
  BufferLineInfo = {
    fg = colors.light_grey,
    bg = colors.black2,
  },
  BufferLineInfoDiagnostic = {
    fg = colors.light_grey,
    bg = colors.black2,
  },
  BufferLineInfoDiagnosticVisible = {
    fg = colors.light_grey,
    bg = colors.black2,
  },
  BufferLineError = {
    fg = colors.light_grey,
    bg = colors.black2,
  },
  BufferLineErrorDiagnostic = {
    fg = colors.light_grey,
    bg = colors.black2,
  },
  BufferLineErrorDiagnosticVisible = {
    fg = colors.light_grey,
    bg = colors.black2,
  },
  BufferLineWarning = {
    fg = colors.light_grey,
    bg = colors.black2,
  },
  BufferLineWarningDiagnostic = {
    fg = colors.light_grey,
    bg = colors.black2,
  },
  BufferLineWarningDiagnosticVisible = {
    fg = colors.light_grey,
    bg = colors.black2,
  },

  BufferLineDuplicate = {
    fg = colors.light_grey,
    bg = colors.black2,
  },
  -- BufferLineDuplicateSelected = {
  --   fg = colors.red,
  --   bg = colors.black,
  -- },
  BufferLineDuplicateVisible = {
    fg = colors.light_grey,
    bg = colors.black,
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
  BufferlineIndicatorVisible = {
    fg = colors.black2,
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

  BufferLineDevIconLua = {
    fg = colors.grey_fg,
    bg = colors.black2,
  },

  BufferLineDevIconLuaInactive = {
    fg = colors.grey_fg,
    bg = colors.black2,
  },

  BufferLineDevIconluaSelected = {
    bg = 'none',
  },

  -- BufferLineDevIconDefaultSelected = {
  --   bg = 'none',
  -- },

  -- BufferLineDevIconDefaultInactive = {
  --   bg = 'none',
  -- },

  -- -- custom area
  -- BufferLineRightCustomAreaText1 = {
  --   fg = colors.white,
  -- },

  -- BufferLineRightCustomAreaText2 = {
  --   fg = colors.red,
  -- },
}
