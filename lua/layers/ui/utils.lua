local M = {}

M.hide_statusline = function()
   local hidden = require("layers.ui.options").statusline_filetype_exclude
   local shown = require("layers.ui.options").statusline_filetype_include
   local api = vim.api
   local buftype = api.nvim_buf_get_option(0, "ft")

   -- shown table from config has the highest priority
   if vim.tbl_contains(shown, buftype) then
      api.nvim_set_option("laststatus", 3)
      return
   end

   if vim.tbl_contains(hidden, buftype) then
      api.nvim_set_option("laststatus", 0)
      return
   end

   api.nvim_set_option("laststatus", 3)
end

return M
