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
  {
    "tpope/vim-dadbod",
    dependencies = {
      "kristijanhusak/vim-dadbod-ui",
      "kristijanhusak/vim-dadbod-completion",
    },
    keys = {
      { "<leader>Dt", "<cmd>DBUIToggle<cr>",        desc = "Toggle UI" },
      { "<leader>Df", "<cmd>DBUIFindBuffer<cr>",    desc = "Find Buffer" },
      { "<leader>Dr", "<cmd>DBUIRenameBuffer<cr>",  desc = "Rename Buffer" },
      { "<leader>Dq", "<cmd>DBUILastQueryInfo<cr>", desc = "Last Query Info" },
    },
  },
  { 'mg979/vim-visual-multi' },
  {
    'echasnovski/mini.pairs',
    version = false,
    config = function()
      require("mini.pairs").setup()
    end,
  },
  {
    'echasnovski/mini.splitjoin',
    version = false,
    config = function()
      require("mini.splitjoin").setup()
    end,
  },
  {
    'echasnovski/mini.surround',
    version = false,
    config = function()
      require("mini.surround").setup({
        custom_surroundings = {
          ['('] = { output = { left = '(', right = ')' } },
          ['['] = { output = { left = '[', right = ']' } },
        }
      })
    end,
  },
  {
    'echasnovski/mini.ai',
    version = false,
    config = function()
      require("mini.ai").setup()
    end,
  },
  {
    'echasnovski/mini.cursorword',
    version = false,
    config = function()
      require("mini.cursorword").setup()
    end,
  },
  {
    'echasnovski/mini.move',
    version = false,
    config = function()
      require("mini.move").setup()
    end,
  },
  {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    keys = {
      { '<leader>f', '<cmd>HopChar1<cr>', desc = '[f]ind with Hop' }
    },
    config = function()
      require('hop').setup()
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
    'jdhao/better-escape.vim',
    event = 'InsertEnter',
    init = function()
      vim.g.better_escape_shortcut = { 'jk', 'kj', 'jj', 'kk' }
    end
  },
}
