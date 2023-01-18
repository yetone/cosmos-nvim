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
    local color = "#2d323e"
    vim.api.nvim_set_hl(0, "IlluminatedWordRead", {
      bg = color,
    })
    vim.api.nvim_set_hl(0, "IlluminatedWordText", {
      bg = color,
    })
    vim.api.nvim_set_hl(0, "IlluminatedWordWrite", {
      bg = color,
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

