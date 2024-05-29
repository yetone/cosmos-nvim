local configs = {}

function configs.kubectl()
  require('kubectl').setup()
end

return configs
