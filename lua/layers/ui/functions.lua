local M = {}
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local Previewer = require('telescope.previewers').Previewer

function M.preview_theme(theme)
  local options = require('layers.ui.options')
  options.theme = theme
  package.loaded['layers.ui.colors' or false] = nil
  require('layers.ui.colors').setup()
  require('lualine.highlight').create_highlight_groups(require('layers.ui.highlights').get_lualine_theme())
  require('bufferline.config').setup(require('layers.ui.configs').get_bufferline_options())
  require('bufferline.highlights').reset_icon_hl_cache()
  require('bufferline.highlights').set_all(require('bufferline.config').update_highlights())
  vim.opt.bg = require('layers.ui.colors').get().type
end

function M.pick_theme(opts)
  opts = opts or {}

  local themes = {}
  local theme_files = vim.fn.stdpath('config') .. '/lua/layers/ui/themes'
  for _, file in ipairs(vim.fn.readdir(theme_files)) do
    local theme = vim.fn.fnamemodify(file, ':r')
    if theme then
      table.insert(themes, theme)
    end
  end

  local default_selection_index = 1
  for i, theme in ipairs(themes) do
    if theme == vim.g.colors_name then
      default_selection_index = i
      break
    end
  end

  local current_theme = vim.g.colors_name

  pickers
    .new(opts, {
      prompt_title = 'Pick Theme',
      finder = finders.new_table({
        results = themes,
      }),
      default_selection_index = default_selection_index,
      sorter = conf.generic_sorter(opts),
      previewer = Previewer:new({
        setup = function(self)
          local selection = action_state.get_selected_entry()
          M.preview_theme(selection.value)
        end,
        teardown = function(self)
          M.preview_theme(current_theme)
        end,
        preview_fn = function(self, entry) end,
      }),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          M.preview_theme(selection.value)
        end)
        return true
      end,
    })
    :find()
end

return M
