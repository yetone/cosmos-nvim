local cosmos = require('core.cosmos')

cosmos.add_leader_keymapping('n|ak', { ':lua require("kubectl").open()<CR>', name = 'Kubectl' })
