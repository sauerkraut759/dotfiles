-- BASIC CONFIG --

local opt = vim.opt
opt.number          = true
opt.mouse           = 'a'
opt.numberwidth     = 1
opt.clipboard       = 'unnamedplus'
opt.syntax          = 'enable'
opt.showcmd         = true
opt.ruler           = true
opt.encoding        = 'utf-8'
opt.showmatch       = true
opt.shiftwidth      = 4
opt.tabstop         = 4
opt.expandtab       = true
opt.wildmenu        = true
opt.wildmode        = 'list:longest,list:full'


-- LEADER KEY

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- INSTALL LAZY.NVIM

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

-- PLUGIN SPEC

require('lazy').setup({
    
    -- [THEMES]

    --      colorbuddy (andromeda dep)
    {
        'tjdevries/colorbuddy.nvim',
        branch = 'dev',
    },
    --      andromeda
    {
        'nobbmaestro/nvim-andromeda',
        dependencies = { 'tjdevries/colorbuddy.nvim' },
        name = 'andromeda',
        priority = 1000,
        config = function()
            require('andromeda').setup {
                preset = 'andromeda',
                transparent_bg = true,
            }
            vim.cmd 'colorscheme andromeda'
        end,
    },

    -- [IDE]
    { 'easymotion/vim-easymotion',  event = 'VeryLazy' },
    { 'preservim/nerdtree',         cmd = { 'NERDTreeToggle', 'NERDTreeFind' } },
    { 'christoomey/vim-tmux-navigator', lazy = false },
    { 'windwp/nvim-autopairs', event = 'InsertEnter', config = true},

})

-- PLUGING SETTINGS

vim.g.NERDTreeQuitOnOpen = 1

-- KEY MAPPINGS

vim.keymap.set('n', '<Leader>s', '<Plug>(easymotion-s2)')
vim.keymap.set('n', '<Leader>nt', ':NERDTreeFind<CR>')
