local options = require('layers.ui.options')
local g = vim.g
local opt = vim.opt

opt.termguicolors = true
g.Illuminate_delay = options.illuminate_delay
g.Illuminate_ftblacklist = options.illuminate_filetype_exclude

opt.cursorline = true
vim.cmd [[
autocmd WinEnter * if (&filetype != "alpha" && &filetype != "dashboard") | setlocal cursorline | endif
autocmd WinLeave * setlocal nocursorline
]]

vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("illuminate_augroup", { clear = true }),
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "illuminatedWord", {
      link = "Visual",
    })
    vim.api.nvim_set_hl(0, "illuminatedCurWord", {
      underline = true,
    })
  end,
})

vim.api.nvim_create_autocmd({
    "BufEnter",
    "BufRead",
    "BufWinEnter",
    "FileType",
    "WinEnter",
  }, {
    pattern = "*",
    callback = function()
      require("layers.ui.utils").hide_statusline()
    end,
  })

require("layers.ui.colors").init()

