return {
  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<leader>?',       '<cmd>Telescope oldfiles theme=ivy<cr>',                      desc =
      '[?] Find recently opened files' },
      { '<leader><space>', '<cmd>Telescope buffers theme=ivy<cr>',                       desc =
      '[ ] Find existing buffers' },
      { '<leader>sf',      '<cmd>Telescope find_files theme=ivy<cr>',                    desc = '[S]earch [F]iles' },
      { '<leader>sh',      '<cmd>Telescope help_tags theme=ivy<cr>',                     desc = '[S]earch [H]elp' },
      { '<leader>sw',      '<cmd>Telescope grep_string theme=ivy<cr>',                   desc = '[S]earch current [W]ord' },
      { '<leader>sg',      '<cmd>Telescope live_grep theme=ivy<cr>',                     desc = '[S]earch by [G]rep' },
      { '<leader>sd',      '<cmd>Telescope diagnostics theme=ivy<cr>',                   desc = '[S]earch [D]iagnostics' },
      { '<leader>ds',      '<cmd>Telescope lsp_document_symbols theme=ivy<cr>',          desc = '[D]ocument [S]ymbols' },
      { '<leader>ws',      '<cmd>Telescope lsp_dynamic_workspace_symbols theme=ivy<cr>', desc = '[W]orkspace [S]ymbols' },
      { 'gr',              '<cmd>Telescope lsp_references theme=ivy<cr>',                desc = '[G]oto [R]eferences' },
    },
    config = function()
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        defaults = {
          mappings = {
            i = {
              ['<C-u>'] = false,
              ['<C-d>'] = false,
            },
          },
        },
      }

      -- Enable telescope fzf native, if installed
      pcall(require('telescope').load_extension, 'fzf')

      -- See `:help telescope.builtin`
      -- vim.keymap.set('n', '<leader>/', function()
      --   -- You can pass additional configuration to telescope to change theme, layout, etc.
      --   require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      --     winblend = 10,
      --     previewer = false,
      --   })
      -- end, { desc = '[/] Fuzzily search in current buffer' })
    end
  },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },
}
