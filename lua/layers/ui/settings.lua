local options = require('layers.ui.options')
local g = vim.g
local opt = vim.opt

opt.pumblend = options.transparency

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

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
    if not package.loaded['bufferline.config'] then
      return
    end

    local ok_config, bufferline_config = pcall(require, 'bufferline.config')
    local ok_highlights, bufferline_highlights = pcall(require, 'bufferline.highlights')
    if not ok_config or not ok_highlights then
      return
    end

    bufferline_config.setup(require('layers.ui.configs').get_bufferline_options())
    bufferline_highlights.reset_icon_hl_cache()
    bufferline_highlights.set_all(bufferline_config.update_highlights())
  end,
})

require('layers.ui.colors').setup()
