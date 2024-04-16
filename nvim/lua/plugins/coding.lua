-- Coding helpers
return {
  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 500
      require("which-key").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end,
  },
  {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  },
  { 'numToStr/Comment.nvim', opts = {} },
  { 'tpope/vim-fugitive' },
  { 'tpope/vim-rhubarb' },
  { 'tpope/vim-sleuth' },
  -- {
  --   "tpope/vim-dadbod",
  --   dependencies = {
  --     "kristijanhusak/vim-dadbod-ui",
  --     "kristijanhusak/vim-dadbod-completion",
  --   },
  --   keys = {
  --     { "<leader>Dt", "<cmd>DBUIToggle<cr>",        desc = "Toggle UI" },
  --     { "<leader>Df", "<cmd>DBUIFindBuffer<cr>",    desc = "Find Buffer" },
  --     { "<leader>Dr", "<cmd>DBUIRenameBuffer<cr>",  desc = "Rename Buffer" },
  --     { "<leader>Dq", "<cmd>DBUILastQueryInfo<cr>", desc = "Last Query Info" },
  --   },
  -- },
  -- { 'mg979/vim-visual-multi' },
  -- {
  --   'echasnovski/mini.pairs',
  --   version = false,
  --   config = function()
  --     require("mini.pairs").setup()
  --   end,
  -- },
  {
    'echasnovski/mini.nvim',
    config = function()
      require("mini.splitjoin").setup()
      require("mini.surround").setup({
        custom_surroundings = {
          ['('] = { output = { left = '(', right = ')' } },
          ['['] = { output = { left = '[', right = ']' } },
        }
      })
      require("mini.ai").setup()
      require("mini.cursorword").setup()
      require("mini.move").setup()
    end
  },
  {
    'theprimeagen/harpoon',
    keys = {
      { '<leader>ha', function() require("harpoon.mark").add_file() end,        desc = '[h]arpoon [a]dd file' },
      { '<leader>he', function() require("harpoon.ui").toggle_quick_menu() end, desc = '[h]arpoon toggle-menu' },
      { '<leader>h1', function() require("harpoon.ui").nav_file(1) end,         desc = '[h]arpoon [1]' },
      { '<leader>h2', function() require("harpoon.ui").nav_file(2) end,         desc = '[h]arpoon [2]' },
      { '<leader>h3', function() require("harpoon.ui").nav_file(3) end,         desc = '[h]arpoon [3]' },
      { '<leader>h4', function() require("harpoon.ui").nav_file(4) end,         desc = '[h]arpoon [4]' },
      { '<leader>h5', function() require("harpoon.ui").nav_file(5) end,         desc = '[h]arpoon [5]' },
      { '<leader>h6', function() require("harpoon.ui").nav_file(6) end,         desc = '[h]arpoon [6]' },
      { '<leader>h7', function() require("harpoon.ui").nav_file(7) end,         desc = '[h]arpoon [7]' },
      { '<leader>h8', function() require("harpoon.ui").nav_file(8) end,         desc = '[h]arpoon [8]' },
      { '<leader>h9', function() require("harpoon.ui").nav_file(9) end,         desc = '[h]arpoon [9]' },
    }
  },
  {
    "mbbill/undotree",
    keys = {
      { '<leader>u', '<cmd>UndotreeToggle<cr>', desc = 'Toggle [u]ndo tree' }
    }
  },
  {
    "max397574/better-escape.nvim",
    config = function()
      require('better_escape').setup({
        mapping = { "jj", "kk", "jk", "kj" },
        timeout = 1000,
      })
    end
  },
  -- {
  --   "rest-nvim/rest.nvim",
  --   dependencies = { { "nvim-lua/plenary.nvim" } },
  --   commit = "8b62563",
  --   config = function()
  --     require("rest-nvim").setup({
  --       -- Open request results in a horizontal split
  --       result_split_horizontal = false,
  --       -- Keep the http file buffer above|left when split horizontal|vertical
  --       result_split_in_place = false,
  --       -- Skip SSL verification, useful for unknown certificates
  --       skip_ssl_verification = false,
  --       -- Encode URL before making request
  --       encode_url = true,
  --       -- Highlight request on run
  --       highlight = {
  --         enabled = true,
  --         timeout = 150,
  --       },
  --       result = {
  --         -- toggle showing URL, HTTP info, headers at top the of result window
  --         show_url = true,
  --         -- show the generated curl command in case you want to launch
  --         -- the same request via the terminal (can be verbose)
  --         show_curl_command = false,
  --         show_http_info = true,
  --         show_headers = true,
  --         -- executables or functions for formatting response body [optional]
  --         -- set them to false if you want to disable them
  --         formatters = {
  --           json = "jq",
  --           html = function(body)
  --             return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
  --           end
  --         },
  --       },
  --       -- Jump to request line on run
  --       jump_to_request = false,
  --       env_file = '.env',
  --       custom_dynamic_variables = {},
  --       yank_dry_run = true,
  --     })
  --   end,
  --   keys = {
  --     { '<leader>xv', function() require('rest-nvim').run(true) end, desc = 'E[x]ecute pre[v]iew of request' },
  --     { '<leader>xr', function() require('rest-nvim').run() end,     desc = 'E[x]ecute [r]equest' },
  --     { '<leader>xl', function() require('rest-nvim').last() end,    desc = 'E[x]ecute [l]ast request' }
  --   },
  --   lazy = false,
  -- },
  {
    'nvim-pack/nvim-spectre',
    keys = {
      {
        '<leader>St',
        '<cmd>lua require("spectre").toggle()<CR>',
        desc = "[S]pectre [t]oggle",
      },
      {
        '<leader>Sw',
        '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
        desc = "[S]pectre - Search current [w]ord",
      },
      {
        '<leader>Sw',
        '<esc><cmd>lua require("spectre").open_visual()<CR>',
        desc = "[S]pectre - Search current [w]ord",
        mode = 'v',
      },
      {
        '<leader>Sf',
        '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
        desc = "[S]pectre - Search on current [f]ile",
      },
    }
  },
  {
    'ThePrimeagen/refactoring.nvim',
    config = function()
      require('refactoring').setup({

      })
    end
  }
}
