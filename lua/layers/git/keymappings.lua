local cosmos = require('core.cosmos')

cosmos.add_leader_keymapping('n|gs', { ':lua require("neogit").open()<CR>', name = 'Magit status' })

