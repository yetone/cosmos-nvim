local M = {}

local function set_hl_merge(name, changes)
  local current = vim.api.nvim_get_hl(0, { name = name, link = false })
  vim.api.nvim_set_hl(0, name, vim.tbl_extend('force', current, changes))
end

function M.apply()
  local colors = require('layers.ui.colors').get().base_30
  local illuminate_bg = colors.one_bg2 or colors.one_bg or colors.black2

  set_hl_merge('PmenuSel', { blend = 0 })

  vim.api.nvim_set_hl(0, 'IlluminatedWordRead', { bg = illuminate_bg })
  vim.api.nvim_set_hl(0, 'IlluminatedWordText', { bg = illuminate_bg })
  vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', { bg = illuminate_bg })

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
end

return M
