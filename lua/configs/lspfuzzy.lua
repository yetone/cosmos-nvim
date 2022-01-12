local utils = require('utils')

utils.safe_require('lspfuzzy', function(lspfuzzy)
  lspfuzzy.setup {}
end)
