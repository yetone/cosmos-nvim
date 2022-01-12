local utils = require('utils')

utils.safe_require('nvim-autopairs', function(autopairs)
  autopairs.setup({
    disable_filetype = { "TelescopePrompt" },
  })
end)
