local options = require('layers.ui.options')
local g = vim.g
local opt = vim.opt

opt.pumblend = options.transparency
vim.api.nvim_set_hl(0, 'PmenuSel', { blend = 0 })

opt.termguicolors = true
g.Illuminate_delay = options.illuminate_delay
g.Illuminate_ftblacklist = options.illuminate_filetype_exclude
g.neovide_floating_shadow = false

opt.cursorline = true

-- vim.api.nvim_create_autocmd('WinEnter', {
--   pattern = '*',
--   callback = function(_)
--     if not vim.bo.filetype ~= 'alpha' and not vim.bo.filetype ~= 'dashboard' then
--       vim.o.cursorline = true
--     end
--   end,
-- })
-- vim.api.nvim_create_autocmd('WinLeave', {
--   pattern = '*',
--   callback = function(_)
--     vim.o.cursorline = false
--   end,
-- })

vim.api.nvim_create_autocmd('VimEnter', {
  group = vim.api.nvim_create_augroup('illuminate_augroup', { clear = true }),
  pattern = '*',
  callback = function()
    local color = '#2d323e'
    vim.api.nvim_set_hl(0, 'IlluminatedWordRead', {
      bg = color,
    })
    vim.api.nvim_set_hl(0, 'IlluminatedWordText', {
      bg = color,
    })
    vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', {
      bg = color,
    })
  end,
})

vim.api.nvim_create_autocmd({
  'BufEnter',
  'BufRead',
  'BufWinEnter',
  'FileType',
  'WinEnter',
}, {
  pattern = '*',
  callback = function()
    require('layers.ui.utils').hide_statusline()
  end,
})

require('layers.ui.colors').setup()

vim.api.nvim_set_hl(0, 'MiniIndentscopeSymbol', { link = 'IndentBlanklineContextChar' })
vim.api.nvim_set_hl(0, 'MiniIndentscopeSymbolOff', { link = 'IndentBlanklineChar' })
vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupBorder', { link = 'FloatBorder' })
vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupTitle', { link = 'TelescopePreviewTitle' })
vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupTitleLua', { link = 'NoiceCmdlinePopupTitle' })
vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupTitleInput', { link = 'NoiceCmdlinePopupTitle' })
vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupTitleHelp', { link = 'NoiceCmdlinePopupTitle' })
vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupTitleCmdline', { link = 'NoiceCmdlinePopupTitle' })
vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupTitleFilter', { link = 'NoiceCmdlinePopupTitle' })
vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupTitleCalculator', { link = 'NoiceCmdlinePopupTitle' })
