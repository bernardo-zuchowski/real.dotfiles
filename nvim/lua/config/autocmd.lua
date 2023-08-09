local caps_group = vim.api.nvim_create_augroup("CapsLockOff", { clear = true })

local sh_command = function(args, output)
  return vim.api.nvim_cmd({
    cmd = "!",
    args = { args },
  }, { output = true })
end

-- Auto disable the capslock after leave insert mode
-- Only work in Linux (tested in Arch based Linux distro)
-- Needs github.com/jordansissel/xdotool
vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    local caps_lock_state = sh_command("xset -q")
    local caps_lock_on = string.match(caps_lock_state, "00: Caps Lock:%s+ on")

    if caps_lock_on then
      sh_command("xdotool key Caps_Lock")
    end
  end,
  group = caps_group,
})
