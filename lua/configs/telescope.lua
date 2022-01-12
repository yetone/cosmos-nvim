local utils = require('utils')

utils.safe_require('telescope', function(telescope)
  telescope.load_extension 'projects'
  telescope.load_extension 'file_browser'
  local theme = 'ivy'
  telescope.setup {
    defaults = {
      mappings = {
        i = {
          ["<C-a>"] = { "<esc>0i", type = "command" },
          ["<Esc>"] = require('telescope.actions').close
        },
      },
    },
    pickers = {
      buffers = {
        theme = theme,
      },
      find_files = {
        theme = theme,
      },
      oldfiles = {
        theme = theme,
      },
      live_grep = {
        theme = theme,
      },
      current_buffer_fuzzy_find = {
        theme = theme,
      },
      commands = {
        theme = theme,
      },
      lsp_document_symbols = {
        theme = theme,
      },
      diagnostics = {
        theme = theme,
        initial_mode = 'normal',
      },
      lsp_references = {
        theme = 'cursor',
        initial_mode = 'normal',
        layout_config = {
          width = 0.8,
          height = 0.4,
        },
      },
      lsp_code_actions = {
        theme = 'cursor',
        initial_mode = 'normal',
      },
    },
  }
end)
