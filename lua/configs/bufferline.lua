local utils = require('utils')

utils.safe_require('bufferline', function(bufferline)
  bufferline.setup{
    options = {
      always_show_bufferline = false,
    },
  }
end)
