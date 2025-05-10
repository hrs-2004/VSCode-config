-- ~/.config/nvim/lua/config/lazy.lua

-- Bootstrap Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Plugin setup
require("lazy").setup({
  -- Your plugin specifications here
})


require("lazy").setup({
  {
    "kylechui/nvim-surround",
    version = "*", -- use latest stable
    event = "VeryLazy", -- lazy load on idle
    config = function()
      require("nvim-surround").setup()
    end,
  },
  {
  'echasnovski/mini.nvim',
  version = false,
  config = function()
    require('mini.operators').setup()
  end,
  },
{
  'hrsh7th/nvim-pasta',
  config = function()
    -- Set up key mappings for paste operations
    vim.keymap.set({ 'n', 'x' }, 'p', require('pasta.mapping').p, { desc = 'Paste after with pasta' })
    vim.keymap.set({ 'n', 'x' }, 'P', require('pasta.mapping').P, { desc = 'Paste before with pasta' })

    -- Configure pasta settings
    local pasta = require('pasta')
    pasta.config.next_key = vim.keycode('<C-n>')
    pasta.config.prev_key = vim.keycode('<C-p>')
    pasta.config.indent_key = vim.keycode(',')
    pasta.config.indent_fix = true
  end,
},

})

-- Map X to delete without overriding the register
vim.keymap.set('n', 'x', '"_x', { noremap = true, silent = true })
vim.keymap.set('n', 'X', '"_X', { noremap = true, silent = true })
vim.keymap.set('v', 'x', '"_x', { noremap = true, silent = true })
vim.keymap.set('v', 'X', '"_X', { noremap = true, silent = true })

-- Copy the line content (without newline)
vim.keymap.set('n', 'yy', '0vg_y', { noremap = true, silent = true })
vim.keymap.set('n', 'dd', '0vg_d', { noremap = true, silent = true })

--for not overriding the unnamed register after pasting
vim.keymap.set('x', 'P', '"_dP', { noremap = true, silent = true, desc = 'Paste without yanking in visual mode' })

--keymap to paste the content directly
vim.keymap.set('n', 'gib', 'vibpgvy', { noremap = true })

--keymap to enter the behave as normal 
vim.keymap.set('n', '<CR>', 'i<CR><Esc>', { noremap = true, silent = true })

--keymap to ctrl - enter the behave as normal 
vim.keymap.set('n', '<C-CR>', 'o<Esc>', { noremap = true, silent = true })

--clipboard settings
vim.opt.clipboard = "unnamedplus"
