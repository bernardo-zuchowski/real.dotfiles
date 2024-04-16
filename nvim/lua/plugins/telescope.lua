local function multiopen(prompt_bufnr, method)
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local edit_file_cmd_map = {
    vertical = "vsplit",
    horizontal = "split",
    tab = "tabedit",
    default = "edit",
  }
  local edit_buf_cmd_map = {
    vertical = "vert sbuffer",
    horizontal = "sbuffer",
    tab = "tab sbuffer",
    default = "buffer",
  }
  local picker = action_state.get_current_picker(prompt_bufnr)
  local multi_selection = picker:get_multi_selection()

  if #multi_selection > 1 then
    require("telescope.pickers").on_close_prompt(prompt_bufnr)
    pcall(vim.api.nvim_set_current_win, picker.original_win_id)

    for i, entry in ipairs(multi_selection) do
      local filename, row, col

      if entry.path or entry.filename then
        filename = entry.path or entry.filename

        row = entry.row or entry.lnum
        col = vim.F.if_nil(entry.col, 1)
      elseif not entry.bufnr then
        local value = entry.value
        if not value then
          return
        end

        if type(value) == "table" then
          value = entry.display
        end

        local sections = vim.split(value, ":")

        filename = sections[1]
        row = tonumber(sections[2])
        col = tonumber(sections[3])
      end

      local entry_bufnr = entry.bufnr

      if entry_bufnr then
        if not vim.api.nvim_buf_get_option(entry_bufnr, "buflisted") then
          vim.api.nvim_buf_set_option(entry_bufnr, "buflisted", true)
        end
        local command = i == 1 and "buffer" or edit_buf_cmd_map[method]
        pcall(vim.cmd, string.format("%s %s", command, vim.api.nvim_buf_get_name(entry_bufnr)))
      else
        local command = i == 1 and "edit" or edit_file_cmd_map[method]
        if vim.api.nvim_buf_get_name(0) ~= filename or command ~= "edit" then
          filename = require("plenary.path"):new(vim.fn.fnameescape(filename)):normalize(vim.loop.cwd())
          pcall(vim.cmd, string.format("%s %s", command, filename))
        end
      end

      if row and col then
        pcall(vim.api.nvim_win_set_cursor, 0, { row, col - 1 })
      end
    end
  else
    actions["select_" .. method](prompt_bufnr)
  end
end

local custom_actions = function()
  return require("telescope.actions.mt").transform_mod({
    multi_selection_open_vertical = function(prompt_bufnr)
      multiopen(prompt_bufnr, "vertical")
    end,
    multi_selection_open_horizontal = function(prompt_bufnr)
      multiopen(prompt_bufnr, "horizontal")
    end,
    multi_selection_open_tab = function(prompt_bufnr)
      multiopen(prompt_bufnr, "tab")
    end,
    multi_selection_open = function(prompt_bufnr)
      multiopen(prompt_bufnr, "default")
    end,
  })
end

local function stopinsert(callback)
  return function(prompt_bufnr)
    vim.cmd.stopinsert()
    vim.schedule(function()
      callback(prompt_bufnr)
    end)
  end
end

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
              ["<C-v>"] = stopinsert(custom_actions().multi_selection_open_vertical),
              ["<C-s>"] = stopinsert(custom_actions().multi_selection_open_horizontal),
              ["<C-t>"] = stopinsert(custom_actions().multi_selection_open_tab),
              ["<CR>"]  = stopinsert(custom_actions().multi_selection_open)
            },
            n = {
              ["<C-v>"] = custom_actions().multi_selection_open_vertical,
              ["<C-s>"] = custom_actions().multi_selection_open_horizontal,
              ["<C-t>"] = custom_actions().multi_selection_open_tab,
              ["<CR>"] = custom_actions().multi_selection_open,
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
