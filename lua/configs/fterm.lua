local utils = require 'utils'

utils.safe_require('FTerm', function(fterm)
  fterm.setup({
    ft = 'FTerm',
    cmd = 'TERM=xterm-256color ' .. os.getenv('SHELL'),
    border = 'double',
    dimensions  = {
      height = 0.9,
      width = 0.9,
    },
  })
end)
