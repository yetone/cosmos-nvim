local M = {}

function M.merge_highlights(base, overrides)
  local merged = vim.deepcopy(base or {})

  for group, override in pairs(overrides or {}) do
    local current = merged[group]

    if type(override) ~= 'table' then
      merged[group] = override
    elseif override.link ~= nil or (type(current) == 'table' and current.link ~= nil) then
      -- `link` cannot be merged with other attrs: replace the whole group.
      merged[group] = vim.deepcopy(override)
    else
      merged[group] = vim.tbl_extend('force', current or {}, override)
    end
  end

  return merged
end

M.hide_statusline = function()
  local hidden = require('layers.ui.options').statusline_filetype_exclude
  local shown = require('layers.ui.options').statusline_filetype_include
  local api = vim.api
  local buftype = api.nvim_buf_get_option(0, 'ft')

  -- shown table from config has the highest priority
  if vim.tbl_contains(shown, buftype) then
    api.nvim_set_option('laststatus', 3)
    return
  end

  if vim.tbl_contains(hidden, buftype) then
    api.nvim_set_option('laststatus', 0)
    return
  end

  api.nvim_set_option('laststatus', 3)
end

---Make a HTTP request to https://zenquotes.io to get a random quote
---@return string
M.get_quote = function()
  return 'xixi'
  -- local found_curl, curl = pcall(require, 'plenary.curl')
  -- if not found_curl then
  --   error('plenary not found')
  --   return ''
  -- end
  --
  -- local response = curl.get('https://zenquotes.io/api/random', {
  --   headers = {
  --     ['User-Agent'] = 'curl/7.68.0',
  --   },
  -- })
  --
  -- if response.status ~= 200 then
  --   error('Http failed with ' .. response.status, 1)
  --   return ''
  -- end
  --
  -- local json_data = vim.json.decode(response.body, {})
  -- if json_data == {} or json_data == nil then
  --   error('empty json from quotes API decoded')
  --   return ''
  -- end
  --
  -- return '󰟶 ' .. json_data[1].q .. ' - ' .. json_data[1].a
end

return M
