local utils = require('utils')

utils.safe_require('telescope', function(telescope)
  telescope.load_extension 'projects'
  telescope.load_extension 'file_browser'
  local fb_actions = require "telescope".extensions.file_browser.actions

  local theme = 'ivy'
  telescope.setup {
    defaults = {
      mappings = {
        i = {
          ["<C-a>"] = { "<esc>0i", type = "command" },
          ["<Esc>"] = require('telescope.actions').close
        },
      },
      file_ignore_patterns = { "node_modules", ".git" },
    },
    extensions = {
      file_browser = {
        theme = theme,
        mappings = {
          ["i"] = {
            -- your custom insert mode mappings
            ["<C-h>"] = fb_actions.goto_parent_dir,
            ["<C-e>"] = fb_actions.rename,
            ["<C-c>"] = fb_actions.create,
          },
          ["n"] = {
            -- your custom normal mode mappings
          },
        },
      },
    },
    pickers = {
      buffers = {
        theme = theme,
      },
      find_files = {
        theme = theme,
        hidden = true,
      },
      oldfiles = {
        theme = theme,
        hidden = true,
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
