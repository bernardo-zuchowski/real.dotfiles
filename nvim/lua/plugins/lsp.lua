return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v2.x',
  dependencies = {
    -- LSP Support
    { 'neovim/nvim-lspconfig' }, -- Required
    {
      'williamboman/mason.nvim', -- Optional
      build = function()
        pcall(vim.cmd, 'MasonUpdate')
      end,
    },
    { 'williamboman/mason-lspconfig.nvim' }, -- Optional

    -- Autocompletion
    { 'hrsh7th/nvim-cmp' },     -- Required
    { 'hrsh7th/cmp-nvim-lsp' }, -- Required
    { 'L3MON4D3/LuaSnip' },     -- Required
    { 'rafamadriz/friendly-snippets' },
    { 'saadparwaiz1/cmp_luasnip' },

    -- Useful status updates for LSP
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    { 'j-hui/fidget.nvim',                opts = {} },

    -- Additional lua configuration, makes nvim stuff amazing!
    'folke/neodev.nvim',
  },
  keys = {
    { '<leader>rn', vim.lsp.buf.rename,                                 desc = 'LSP: [R]e[n]ame' },
    { '<leader>ca', vim.lsp.buf.code_action,                            desc = 'LSP: [C]ode [A]ction' },
    { 'gd',         vim.lsp.buf.definition,                             desc = 'LSP: [G]oto [D]efinition' },
    { '<leader>D',  vim.lsp.buf.type_definition,                        desc = 'LSP: Type [D]efinition' },
    { 'gI',         vim.lsp.buf.implementation,                         desc = 'LSP: [G]oto [I]mplementation' },
    { 'gr',         '<cmd>Telescope lsp_references<cr>',                desc = 'LSP: [G]oto [R]eferences' },
    { '<leader>ds', '<cmd>Telescope lsp_document_symbols<cr>',          desc = 'LSP: [D]ocument [S]ymbols' },
    { '<leader>ws', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', desc = 'LSP: [W]orkspace [S]ymbols' },

    -- See `:help K` for why this keymap
    { 'K',          vim.lsp.buf.hover,                                  desc = 'LSP: Hover Documentation' },
    { '<C-k>',      vim.lsp.buf.signature_help,                         desc = 'LSP: Signature Documentation' },

    -- Lesser used LSP functionality
    { 'gD',         vim.lsp.buf.declaration,                            desc = 'LSP: [G]oto [D]eclaration' },
    { '<leader>wa', vim.lsp.buf.add_workspace_folder,                   desc = 'LSP: [W]orkspace [A]dd Folder' },
    { '<leader>wr', vim.lsp.buf.remove_workspace_folder,                desc = 'LSP: [W]orkspace [R]emove Folder' },
    {
      '<leader>wl',
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      desc = '[W]orkspace [L]ist Folders'
    },
  },
  event = "BufRead", -- The event need because "keys" turns this plugin to lazy
  config = function()
    -- LSP Setup
    local lsp = require('lsp-zero').preset({})

    lsp.on_attach(function(_, bufnr)
      vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
      end, { desc = 'Format current buffer with LSP' })
    end)

    lsp.ensure_installed({
      -- Replace these with whatever servers you want to install
      'tsserver',
      'lua_ls',
      'jsonls',
      'eslint',
      'rust_analyzer',
      'clangd',
    })

    -- Has conflict with jump list keymap <C-i>
    -- lsp.format_mapping('<C-i>', {
    --   servers = {
    --     ['jsonls'] = { 'json' },
    --     ['tsserver'] = { 'javascript', 'typescript' },
    --     ['lua_ls'] = { 'lua' },
    --     ['rust_analyzer'] = { 'rust' },
    --   }
    -- })

    lsp.format_on_save({
      servers = {
        ['jsonls'] = { 'json' },
        ['tsserver'] = { 'javascript', 'typescript' },
        ['lua_ls'] = { 'lua' },
        ['rust_analyzer'] = { 'rust' },
        ['clangd'] = { 'c', 'c++' },
      }
    })

    lsp.set_sign_icons({
      error = 'E',
      warn = 'W',
      hint = 'H',
      info = 'I'
    })

    require('lspconfig').tsserver.setup({
      handlers = {
        ["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
          if result.diagnostics ~= nil then
            local idx = 1
            while idx <= #result.diagnostics do
              -- look for diagnostics codes here:
              -- https://github.com/microsoft/TypeScript/blob/main/src/compiler/diagnosticMessages.json
              if result.diagnostics[idx].code == 80001 then
                table.remove(result.diagnostics, idx)
              else
                idx = idx + 1
              end
            end
          end
          vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
        end,
      },
    })

    -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
    -- Setup neovim lua configuration
    require('neodev').setup()

    lsp.setup()

    -- nvim-cmp setup
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'

    luasnip.config.setup {}

    require('luasnip.loaders.from_vscode').lazy_load()

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'vim-dadbod-completion' },
      }
    }
  end
}
