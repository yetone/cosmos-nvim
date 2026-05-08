local M = {}
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local Previewer = require('telescope.previewers').Previewer
local previous_theme

function M.apply_theme(theme)
  if not theme or theme == vim.g.colors_name then
    return
  end

  vim.api.nvim_exec_autocmds('ColorSchemePre', { modeline = false, pattern = theme })

  local options = require('layers.ui.options')
  options.theme = theme
  require('layers.ui.colors').setup()
  vim.api.nvim_exec_autocmds('ColorScheme', { modeline = false, pattern = theme })
end

function M.preview_theme(theme)
  M.apply_theme(theme)
end

function M.toggle_theme_preview(theme)
  local current_theme = vim.g.colors_name

  if current_theme == theme and previous_theme then
    M.preview_theme(previous_theme)
    previous_theme = nil
    return
  end

  if current_theme ~= theme then
    previous_theme = current_theme
  end

  M.preview_theme(theme)
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
