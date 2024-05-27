local sh_command = function(args, output)
  return vim.api.nvim_cmd({
    cmd = "!",
    args = { args },
  }, { output = true })
end

-- Auto disable the capslock after leave insert mode
-- Only work in Linux (tested in Arch/Ubuntu based Linux distro)
-- Needs github.com/jordansissel/xdotool
local caps_group = vim.api.nvim_create_augroup("CapsLockOff", { clear = true })
vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    if (vim.bo.buftype ~= 'acwrite') then
      local caps_lock_state = sh_command("xset -q")
      local caps_lock_on = string.match(caps_lock_state, "00: Caps Lock:%s+ on")

      if caps_lock_on then
        sh_command("xdotool key Caps_Lock")
      end
    end
  end,
  group = caps_group,
})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
