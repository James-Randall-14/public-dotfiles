-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

-- User plugin config
lvim.plugins = {
  {
      "scottmckendry/cyberdream.nvim",
      lazy = false,
      priority = 1000,
      config = function()
        -- Colorscheme Config
          require("cyberdream").setup({
              -- Enable transparent background
              transparent = true, -- Default: false

              -- Enable italics comments
              italic_comments = true, -- Default: false

              -- Replace all fillchars with ' ' for the ultimate clean look
              hide_fillchars = true, -- Default: false

              theme = { -- Default: nil

                  -- Override a color entirely
                  colors = {
                      -- For a list of colors see `lua/cyberdream/colours.lua`
                      -- Example:
                      red = "#FF3B30",
                      orange = "#FF9500",
                      yellow = "#FFCC00",
                      green = "#34C759",
                      blue = "#007AFF",
                      cyan = "#32ADE6",
                      purple = "#AF52DE",
                      pink = "#FF2D55",
                      fg = "#D1D1D6",
                      bg = "#1C1C1E",
                  },
              },
          })
      end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    defaults = { lazy = true },
    config = function()
      require 'colorizer'.setup ( { '*' }, { mode = 'background' } )
    end,
  },
}

-- Set Options

-- Set Colorscheme
lvim.colorscheme = "cyberdream"

-- Configure tabbing
vim.opt.tabstop = 2 -- # spaces to a tab
vim.opt.shiftwidth = 0
vim.opt.smarttab = true
-- vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.breakindent = true -- wrap text with constant indent
vim.opt.expandtab = true -- turn tab character in to spaces
vim.opt.shiftround = true
vim.opt.startofline = true -- jump cursor to first non-blank char of line

-- Enable text wrapping (as opposed to horizontal scrolling)
vim.opt.wrap = true
vim.opt.wrapscan = true

-- Enable prompting to save when quitting
vim.opt.confirm = true

-- Tell NeoVim to use the system clipboard by default
vim.opt.clipboard = "unnamed"
-- Set case ignore for file names when searching
vim.opt.fileignorecase = true

-- Configure settings for folds (like grouped rows in sheets)
vim.opt.foldcolumn = "0"
vim.opt.foldenable = true
vim.opt.foldmethod = "manual"

-- Case insensitive search (unless searching w/ uppercase)
vim.opt.smartcase = true
vim.opt.ignorecase = true

-- Define character pairs (chars to jump between)
vim.opt.matchpairs = "(:),{:},[:],\":\",':'"

-- Mouse configuration
vim.opt.mousefocus = true -- Window focused on mouse hover
vim.opt.mousehide = true -- Hide mouse when typing

-- Tweak Scrolling
vim.opt.mousescroll = "ver:2,hor:3"

-- Display vim mode at bottom
vim.opt.showmode = true

-- Set timeoutlen (increase leader menu speed)
vim.opt.timeoutlen = 200

-- Enable cursor blinking
vim.opt.guicursor = "n-v-sm:block,i-c-ci-ve:ver25,r-cr-o:hor20,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor"

-- Configure terminals to allow only floating
lvim.builtin.terminal.start_in_insert = true
lvim.builtin.terminal.direction = 'float'
lvim.builtin.terminal.execs = {}
lvim.builtin.terminal.open_mapping = "<M-a>"

-- Set NeoVim Clipboard to default
vim.opt.clipboard = "unnamedplus"

-- Set window title to filename
vim.opt.title = true
vim.opt.titlestring = "NeoVim"

-- Customize Keybinds

-- Map ctrl + shift + v to paste
-- Also map all paste functions to preserve indent
lvim.keys.normal_mode["p"] = "]p"
lvim.keys.normal_mode["<C-S-V>"] = "]p"
lvim.keys.visual_mode["p"] = "]p"
lvim.keys.visual_mode["<C-S-V>"] = "]p"

-- Map buffer cycling, and buffer killing
lvim.keys.normal_mode["<C-Tab>"] = ":BufferLineCycleNext<>"
lvim.keys.normal_mode["<C-S-Tab>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<C-w>"] = ":BufferKill<CR>"

-- THINGS TO CHANGE:
-- https://www.reddit.com/r/Ubuntu/comments/o3n7f0/battery_drain_in_suspend_mode/

-- Function to make nvimtree quit automatically if it is the last window open
vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
      vim.cmd "quit"
    end
  end
})

