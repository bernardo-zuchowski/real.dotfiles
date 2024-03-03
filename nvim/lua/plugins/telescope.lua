return {
  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
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
    },
    keys = {
      { '<leader>?',       '<cmd>Telescope oldfiles<cr>',                      desc = '[?] Find recently opened files' },
      { '<leader><space>', '<cmd>Telescope buffers<cr>',                       desc = '[ ] Find existing buffers' },
      { '<leader>sf',      '<cmd>Telescope find_files<cr>',                    desc = '[S]earch [F]iles' },
      { '<leader>sh',      '<cmd>Telescope help_tags<cr>',                     desc = '[S]earch [H]elp' },
      { '<leader>sw',      '<cmd>Telescope grep_string<cr>',                   desc = '[S]earch current [W]ord' },
      { '<leader>sg',      '<cmd>Telescope live_grep<cr>',                     desc = '[S]earch by [G]rep' },
      { '<leader>sd',      '<cmd>Telescope diagnostics<cr>',                   desc = '[S]earch [D]iagnostics' },
      { '<leader>ds',      '<cmd>Telescope lsp_document_symbols<cr>',          desc = '[D]ocument [S]ymbols' },
      { '<leader>ws',      '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', desc = '[W]orkspace [S]ymbols' },
      { '<leader>/',       '<cmd>Telescope current_buffer_fuzzy_find<cr>',     desc = '[S]earch in current [B]uffer' },
      { 'gd',              '<cmd>Telescope lsp_definitions<cr>',               desc = '[G]oto [D]efinition' },
      { 'gr',              '<cmd>Telescope lsp_references<cr>',                desc = '[G]oto [R]eferences' },
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
          layout_strategy = 'bottom_pane',
        },
      }

      -- Enable telescope extensions, if they are installed
      pcall(require('telescope').load_extension, 'fzf')
    end
  },
}
