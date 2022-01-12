local utils = require('utils')

utils.safe_require('lspsaga', function(saga)
  saga.init_lsp_saga({
    code_action_keys = {
      quit = {"q", "<ESC>"},
    },
    rename_action_keys = {
      quit = {"q", "<ESC>"},
    },
  })
end)
