local configs = {}

function configs.gitsigns()
  local gitsigns = require('gitsigns')
  gitsigns.setup({
    current_line_blame = true,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
      delay = 100,
      ignore_whitespace = false,
    },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  })
end

function configs.telescope_github()
  require('telescope').load_extension('gh')
end

return configs
