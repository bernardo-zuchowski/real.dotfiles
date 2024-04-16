-- Custom UI
return {
  -- {
  --   "rebelot/kanagawa.nvim",
  --   lazy = false,    -- make sure we load this during startup if it is your main colorscheme
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     -- load the colorscheme here
  --     vim.cmd([[colorscheme kanagawa]])
  --   end,
  -- },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    opts = {
      disable_background = true,
    },
    config = function()
      vim.cmd('colorscheme rose-pine')
      -- local hour = os.date("%H")
      --
      -- if hour > '18' or hour < '06' then
      --   vim.opt.background = 'dark'
      -- else
      --   vim.opt.background = 'light'
      -- end
    end,
  },
  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'auto',
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'filename' },
        lualine_c = { 'branch', 'diff', 'diagnostics' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
      },
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require('ibl').setup({
        scope = {
          enabled = false,
        },
        indent = {
          char = '┊',
        },
      })
    end
  },

  {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
  {
    "folke/zen-mode.nvim",
    opts = {}
  },
  {
    "SmiteshP/nvim-navic",
    config = function()
      local navic = require("nvim-navic")
      navic.setup({
        lsp = {
          auto_attach = true,
        },
        icons = {
          File          = "",
          Module        = "",
          Namespace     = "",
          Package       = "",
          Class         = "",
          Method        = "",
          Property      = "",
          Field         = "",
          Constructor   = "",
          Enum          = "",
          Interface     = "",
          Function      = "",
          Variable      = "",
          Constant      = "",
          String        = "",
          Number        = "",
          Boolean       = "",
          Array         = "",
          Object        = "",
          Key           = "",
          Null          = "",
          EnumMember    = "",
          Struct        = "",
          Event         = "",
          Operator      = "",
          TypeParameter = "",
        },
      })

      require("lualine").setup {
        winbar = {
          lualine_c = {
            {
              function() return navic.get_location() end,
              cond = function() return navic.is_available() end
            }
          }
        }
      }
    end
  }
}
