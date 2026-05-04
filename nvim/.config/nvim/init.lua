-- BASIC CONFIG --

local opt = vim.opt
opt.number			= true
opt.mouse			= 'a'
opt.numberwidth		= 1
opt.clipboard		= 'unnamedplus'
opt.syntax			= 'enable'
opt.showcmd			= true
opt.ruler			= true
opt.relativenumber	= true
opt.encoding		= 'utf-8'
opt.showmatch		= true
opt.shiftwidth		= 8
opt.tabstop			= 8
opt.expandtab		= false
opt.wildmenu		= true
opt.wildmode		= 'list:longest,list:full'
opt.listchars		= 'eol:$,tab:--⯈,space:␣'



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

	--		treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		branch = 'master',
		priority = 1001,
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup {
				ensure_installed = { "c", "cpp", "lua" },
				highlight = {
					enable = true,
					aditional_vim_regex_highlighting = false,
				},

				--indent = {enable = true},
			}
		end
	},
	{ 
		"sauerkraut759/gruber-darker.nvim",
		branch="add-transparent-background",
		--dir = "/data/coding/nvim-plugins/gruber-darker.nvim",
		opts = {
			transparent_bg = true,
		},
		priority = 1000,
		config = function()
			require("gruber-darker").setup({
				transparent_bg = true,
			})
		end
	},
	{
		'olivercederborg/poimandres.nvim',
		lazy = false,
		priority = 1000,
		config = function()
			require('poimandres').setup {
				disable_background = true,
				bold_vert_split = true
			}
			vim.cmd 'colorscheme poimandres'
		end
	},
	-- [IDE]
	{
		"rmagatti/auto-session",
		lazy = false,

		---enables autocomplete for opts
		---@module "auto-session"
		---@type AutoSession.Config
		opts = {
		suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
		},
		config = function()
			require("auto-session").setup({})
		end
	},
	{ 'easymotion/vim-easymotion',	event = 'VeryLazy' },
	--{ 'preservim/nerdtree',		  cmd = { 'NERDTreeToggle', 'NERDTreeFind' } },
	{
		'ms-jpq/chadtree',
		branch = 'chad',
		build = 'python3 -m chadtree deps'
	},
	{ 'christoomey/vim-tmux-navigator', lazy = false },
	{ 'windwp/nvim-autopairs', event = 'InsertEnter', config = true},
	{ 
		'brenoprata10/nvim-highlight-colors',
		config = function()
			require('nvim-highlight-colors').setup({

			})
		end
	}

})

-- PLUGING SETTINGS

vim.g.NERDTreeQuitOnOpen = 1

-- UTIL


local function toggle_terminal()
	vim.cmd("botright vsplit")
	vim.cmd("term")
	vim.cmd("vertical resize 40")
	vim.cmd("startinsert")
end

-- KEY MAPPINGS

vim.keymap.set('n', '<Leader>s', '<Plug>(easymotion-s2)')
vim.keymap.set('n', '<Leader>nt', ':CHADopen<CR>')
vim.keymap.set('n', '<Leader>ts', toggle_terminal)
