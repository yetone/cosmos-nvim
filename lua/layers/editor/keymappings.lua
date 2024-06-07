local utils = require('core.utils')
local cosmos = require('core.cosmos')
local options = require('layers.editor.options')
local core_options = require('core.options')
local functions = require('layers.editor.functions')

cosmos.add_leader_keymapping(
  'n|bb',
  { "<cmd>lua require('telescope.builtin').buffers { sort_mru = true }<cr>", name = 'List buffers' }
)
cosmos.add_leader_keymapping('n|bn', { ':BufferLineCycleNext<CR>', name = 'Next buffer' })
cosmos.add_leader_keymapping('n|bp', { ':BufferLineCyclePrev<CR>', name = 'Previous buffer' })
cosmos.add_leader_keymapping('n|bd', { ':bw<CR>', name = 'Delete buffer' })

cosmos.add_leader_keymapping('n|ff', {
  "<cmd>lua require('layers.editor.functions').find_current_directory_files()<CR>",
  name = 'Find file in current directory',
})
cosmos.add_leader_keymapping('n|fb', { ':Telescope file_browser<CR>', name = 'File browser' })
cosmos.add_leader_keymapping('n|fr', { '<cmd>Telescope oldfiles<cr>', name = 'Open recent file', noremap = false })
cosmos.add_leader_keymapping('n|ft', { '<cmd>NvimTreeToggle<cr>', name = 'File tree', noremap = false })

cosmos.add_leader_keymapping(
  'n|wp',
  { "<cmd>lua require('nvim-window').pick()<cr>", name = 'Pick Window', noremap = true }
)

cosmos.add_leader_keymapping('n|fed', { '<cmd>e ~/.cosmos-nvim.lua<CR>', name = 'Open cosmos configuration file' })
cosmos.add_leader_keymapping(
  'n|feD',
  { "<cmd>lua require('layers.editor.functions').edit_neovim()<CR>", name = 'Open cosmos source files' }
)
cosmos.add_leader_keymapping(
  'n|feR',
  { "<cmd>lua require('layers.editor.functions').reload_configuration()<CR>", name = 'Reload configuration' }
)

cosmos.add_leader_keymapping(
  'n|pp',
  { '<cmd>Telescope projects theme=' .. options.telescope_theme .. '<cr>', name = 'Switch project' }
)
cosmos.add_leader_keymapping('n|pf', { '<cmd>Telescope find_files<CR>', name = 'Find project files' })

cosmos.add_leader_keymapping('n|jj', { '<cmd>lua require("flash").remote()<cr>', name = 'Jump to a char' })
utils.set_keymap('v', '<leader>jj', '<cmd>lua require("flash").remote()<cr>', {})
cosmos.add_leader_keymapping('n|jl', {
  '<cmd>lua require("flash").jump({ search = { mode = "search", max_length = 0 }, label = { after = { 0, 0 } }, pattern = "^" })<cr>',
  name = 'Jump to a line',
})
cosmos.add_leader_keymapping(
  'n|ji',
  { "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", name = 'Jump to a symbol' }
)

cosmos.add_leader_keymapping('n|se', { ':Lspsaga rename ++project<CR>', name = 'Edit symbol' })
cosmos.add_leader_keymapping('n|ss', {
  "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find { fuzzy = false, case_mode = 'ignore_case' }<cr>",
  name = 'Search current buffer',
})
cosmos.add_leader_keymapping('n|sh', { '<cmd>Lspsaga hover_doc<CR>', name = 'Hover symbol' })
cosmos.add_leader_keymapping('n|sp', { '<cmd>Lspsaga peek_definition<CR>', name = 'Peek symbol definition' })
cosmos.add_leader_keymapping('n|sH', { '<cmd>lua vim.lsp.buf.signature_help()<CR>', name = 'Show symbol signature' })

cosmos.add_leader_keymapping('n|el', {
  function()
    require('trouble').toggle({
      mode = 'diagnostics',
      focus = true,
      filter = {
        buf = 0,
      },
    })
  end,
  name = 'List errors',
})
cosmos.add_leader_keymapping('n|eL', {
  function()
    require('trouble').toggle({
      mode = 'diagnostics',
      focus = true,
    })
  end,
  name = 'List workspace errors',
})
cosmos.add_leader_keymapping('n|en', { ':Lspsaga diagnostic_jump_next<CR>', name = 'Next error' })
cosmos.add_leader_keymapping('n|ep', { ':Lspsaga diagnostic_jump_prev<CR>', name = 'Previous error' })
cosmos.add_leader_keymapping('n|ef', { ':lua vim.lsp.buf.code_action()<CR>', name = 'Fix error' })
-- cosmos.add_leader_keymapping('n|ef', { ':Lspsaga code_action<CR>', name = 'Fix error' })

cosmos.add_leader_keymapping(
  'n|db',
  { "<CMD>lua require('dap').toggle_breakpoint()<CR>", name = 'Toggle breakpoint', silent = true, noremap = true }
)
cosmos.add_leader_keymapping(
  'n|dP',
  { "<CMD>lua require('dap').pause()<CR>", name = 'Pause', silent = true, noremap = true }
)
cosmos.add_leader_keymapping(
  'n|dK',
  { "<CMD>lua require('dapui').float_element()<CR>", name = 'Float element', silent = true, noremap = true }
)
cosmos.add_leader_keymapping(
  'n|dR',
  { "<CMD>lua require('dapui').float_element('repl')<CR>", name = 'REPL', silent = true, noremap = true }
)
cosmos.add_leader_keymapping(
  'n|dn',
  { "<CMD>lua require('dap').step_over()<CR>", name = 'Step over', silent = true, noremap = true }
)
cosmos.add_leader_keymapping(
  'n|ds',
  { "<CMD>lua require('dap').step_into()<CR>", name = 'Step into', silent = true, noremap = true }
)
cosmos.add_leader_keymapping(
  'n|do',
  { "<CMD>lua require('dap').step_out()<CR>", name = 'Step out', silent = true, noremap = true }
)
cosmos.add_leader_keymapping(
  'n|dl',
  { "<CMD>lua require('dap.ext.vscode').load_launchjs()<CR>", name = 'Load launch.json', silent = true, noremap = true }
)
cosmos.add_leader_keymapping(
  'n|dc',
  { "<CMD>lua require('dap').continue()<CR>", name = 'Continue', silent = true, noremap = true }
)
cosmos.add_leader_keymapping(
  'n|dr',
  { "<CMD>lua require('layers.editor.functions').run_dap()<CR>", name = 'Run', silent = true, noremap = true }
)
cosmos.add_leader_keymapping(
  'n|dS',
  { "<CMD>lua require('layers.editor.functions').stop_dap()<CR>", name = 'Stop', silent = true, noremap = true }
)
cosmos.add_leader_keymapping(
  'n|dt',
  { "<CMD>lua require('dapui').toggle()<CR>", name = 'Toggle', silent = true, noremap = true }
)
cosmos.add_leader_keymapping(
  'n|dC',
  { "<CMD>lua require('dapui').close()<CR>", name = 'Close', silent = true, noremap = true }
)

cosmos.add_leader_keymapping(
  'n|rl',
  { "<CMD>lua require('telescope.builtin').resume()<CR>", name = 'Resume popup window', silent = true, noremap = true }
)

cosmos.add_leader_keymapping('v|;;', { 'gcc<Esc>', name = 'Comment line', noremap = false })

cosmos.add_leader_keymapping("n|'", { '<Cmd>exe v:count1 . "ToggleTerm"<CR>', name = 'Open shell' })
cosmos.add_leader_keymapping('n|*', { '<CMD>Glance references<CR>', name = 'Search reference in current project' })
cosmos.add_leader_keymapping('n|/', { ':Telescope live_grep<CR>', name = 'Search text in current project' })
cosmos.add_leader_keymapping('n|<Tab>', { ':b#<CR>', name = 'Last buffer' })
cosmos.add_leader_keymapping('n|<Space>', {
  ':Telescope smart_open<CR>',
  name = 'Smart Open',
})

cosmos.add_leader_keymapping(
  'n|lr',
  { ':lua require("layers.editor.functions").open_lua_repl()<CR>', name = 'Open Lua REPL' }
)

utils.nmap('gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
utils.nmap('gD', ':Lspsaga peek_definition<CR>')
utils.set_keymap('n', '<leader>;;', 'gcc', {})
utils.set_keymap('v', '<leader>;', 'gcc<esc>', {})
utils.set_keymap('t', '<A-d>', '<Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>', {})

local keyopts = { noremap = true, silent = true }

if core_options.helix_mode then
  vim.keymap.set({ 'n', 'v', 'o', 'i' }, '<A-o>', functions.goto_parent_node, keyopts)
  vim.keymap.set({ 'n', 'v', 'o', 'i' }, '<A-i>', functions.goto_child_node, keyopts)
  vim.keymap.set({ 'n', 'v', 'o', 'i' }, '<A-n>', functions.goto_next_node, keyopts)
  vim.keymap.set({ 'n', 'v', 'o', 'i' }, '<A-p>', functions.goto_prev_node, keyopts)
end

cosmos.add_leader_keymapping('n|mm', { '<cmd>BookmarksMark<cr>', name = 'Mark current line', noremap = false })
cosmos.add_leader_keymapping('n|mo', { '<cmd>BookmarksGoto<cr>', name = 'Go to bookmark', noremap = false })
cosmos.add_leader_keymapping(
  'n|ma',
  { '<cmd>BookmarksCommands<cr>', name = 'Find and trigger a bookmark command', noremap = false }
)

cosmos.add_leader_keymapping('x|ref', { ':Refactor extract', name = 'Refactor extract to function', noremap = false })
cosmos.add_leader_keymapping(
  'x|reF',
  { ':Refactor extract_to_file', name = 'Refactor extract to file', noremap = false }
)
cosmos.add_leader_keymapping('x|rev', { ':Refactor extract_var', name = 'Refactor extract variable', noremap = false })
cosmos.add_leader_keymapping(
  'n|rebf',
  { ':Refactor extract_block', name = 'Refactor extract block to function', noremap = false }
)
cosmos.add_leader_keymapping(
  'n|rebF',
  { ':Refactor extract_block_to_file', name = 'Refactor extract block to file', noremap = false }
)
cosmos.add_leader_keymapping('n,x|riv', { ':Refactor inline_var', name = 'Refactor inline variable', noremap = false })
cosmos.add_leader_keymapping('n|rif', { ':Refactor inline_func', name = 'Refactor inline function', noremap = false })
