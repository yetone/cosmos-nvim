local configs = {}

function configs.cmp()
  local icons = {
    Text = '',
    Method = '󰆧',
    Function = '󰊕',
    Constructor = '⌘',
    Field = '󰜢',
    Variable = '󰈜',
    Class = '󰠱',
    Interface = '',
    Module = '󰏗',
    Property = '󰜢',
    Unit = '󰑭',
    Value = '󰎠',
    Enum = '',
    Keyword = '󰔌',
    Snippet = '󰅱',
    Color = '󰏘',
    File = '󰈙',
    Reference = '󰈇',
    Folder = '',
    EnumMember = '',
    Constant = '󰐀',
    Struct = '󰙅',
    Event = '',
    Operator = '󰆕',
    TypeParameter = '',
  }

  local codicons = {
    Text = '  ',
    Method = '  ',
    Function = '  ',
    Constructor = '  ',
    Field = '  ',
    Variable = '  ',
    Class = '  ',
    Interface = '  ',
    Module = '  ',
    Property = '  ',
    Unit = '  ',
    Value = '  ',
    Enum = '  ',
    Keyword = '  ',
    Snippet = '  ',
    Color = '  ',
    File = '  ',
    Reference = '  ',
    Folder = '  ',
    EnumMember = '  ',
    Constant = '  ',
    Struct = '  ',
    Event = '  ',
    Operator = '  ',
    TypeParameter = '  ',
  }

  local cmp = require('cmp')
  local luasnip = require('luasnip')
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  local options = require('layers.completion.options')

  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
  end

  local function replace_termcodes(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
  end

  local function check_backspace()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
  end

  local tab_complete = function(fallback)
    local copilot_keys = vim.fn['copilot#Accept']()
    if options.tab_complete_copilot_first then
      if copilot_keys ~= '' then
        vim.api.nvim_feedkeys(copilot_keys, 'i', true)
      elseif cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(replace_termcodes('<Plug>luasnip-expand-or-jump'), '')
      elseif check_backspace() then
        vim.fn.feedkeys(replace_termcodes('<Tab>'), 'n')
      else
        fallback()
      end
    else
      if cmp.visible() then
        cmp.select_next_item()
      elseif copilot_keys ~= '' then
        vim.api.nvim_feedkeys(copilot_keys, 'i', true)
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(replace_termcodes('<Plug>luasnip-expand-or-jump'), '')
      elseif check_backspace() then
        vim.fn.feedkeys(replace_termcodes('<Tab>'), 'n')
      else
        fallback()
      end
    end
  end

  local s_tab_complete = function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
      vim.fn.feedkeys(replace_termcodes('<Plug>luasnip-jump-prev'), '')
    elseif has_words_before() then
      cmp.complete()
    else
      fallback()
    end
  end

  cmp.setup({
    preselect = cmp.PreselectMode.None,
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    mapping = {
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<Tab>'] = tab_complete,
      ['<S-Tab>'] = s_tab_complete,
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = function(fallback)
          local copilot_keys = vim.fn['copilot#Accept']()
          if copilot_keys ~= '' then
            vim.api.nvim_feedkeys(copilot_keys, 'i', true)
          else
            cmp.mapping.abort()(fallback)
          end
        end,
        c = cmp.mapping.close(),
      }),
      ['<C-c>'] = cmp.mapping.abort(),
      ['<C-g>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
      {
        name = 'lazydev',
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      },
      { name = 'nvim_lsp' },
      -- { name = 'vsnip' }, -- For vsnip users.
      { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'path' },
      { name = 'buffer' },
    }),
    formatting = {
      fields = { 'kind', 'abbr', 'menu' },
      format = function(idx, vim_item)
        local icons_ = options.cmp_kind_use_codicons and codicons or icons
        vim_item.menu = vim_item.kind
        vim_item.kind = icons_[vim_item.kind]

        vim_item = require('tailwind-tools.cmp').lspkind_format(idx, vim_item)

        return vim_item
      end,
    },
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' },
    },
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'cmdline_history' },
      { name = 'path' },
    },
  })
end

function configs.autopairs()
  local autopairs = require('nvim-autopairs')
  autopairs.setup({
    disable_filetype = { 'TelescopePrompt', 'vim' },
  })
end

function configs.luasnip()
  require('luasnip.loaders.from_vscode').lazy_load()
end

function configs.chatgpt()
  require('chatgpt').setup({
    openai_params = {
      -- NOTE: model can be a function returning the model name
      -- this is useful if you want to change the model on the fly
      -- using commands
      -- Example:
      -- model = function()
      --     if some_condition() then
      --         return "gpt-4-1106-preview"
      --     else
      --         return "gpt-3.5-turbo"
      --     end
      -- end,
      model = 'gpt-4-turbo',
      frequency_penalty = 0,
      presence_penalty = 0,
      max_tokens = 4095,
      temperature = 0.2,
      top_p = 0.1,
      n = 1,
    },
    chat = {
      keymaps = {
        close = '<C-c>',
        yank_last = '<C-y>',
        yank_last_code = '<C-k>',
        scroll_up = '<C-u>',
        scroll_down = '<C-d>',
        new_session = '<C-n>',
        cycle_windows = '<Tab>',
        cycle_modes = '<C-f>',
        next_message = '<C-j>',
        prev_message = '<C-k>',
        select_session = '<Space>',
        rename_session = 'r',
        delete_session = 'd',
        draft_message = '<C-r>',
        edit_message = 'e',
        delete_message = 'd',
        toggle_settings = '<C-o>',
        toggle_sessions = '<C-p>',
        toggle_help = '<C-h>',
        toggle_message_role = '<C-r>',
        toggle_system_role_open = '<C-s>',
        stop_generating = '<C-x>',
      },
    },
  })
end

return configs
