-- BASIC CONFIG --

local opt = vim.opt
opt.number		= true
opt.mouse		= 'a'
opt.numberwidth		= 1
opt.clipboard		= 'unnamedplus'
opt.showcmd		= true
opt.ruler		= true
opt.relativenumber	= true
opt.encoding		= 'utf-8'
opt.showmatch		= true
opt.shiftwidth		= 8
opt.tabstop		= 8
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
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "c", "cpp", "lua" },
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				--indent = {enable = true},
			})
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
		"williamboman/mason.nvim",
		opts = {},
	},
	{
		'saghen/blink.cmp',
		dependencies = {
			'saghen/blink.lib',
			'rafamadriz/friendly-snippets',
		},
		build = function()
			require('blink.cmp').build():wait(60000)
		end,
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = {
				preset		= 'default',
				['<CR>']	= { 'accept', 'fallback' },
				['<Tab>']	= { 'select_next', 'snippet_forward', 'fallback' },
				['<S-Tab>']	= { 'select_prev', 'snippet_backward', 'fallback' },
				['<C-d>']	= { 'scroll_documentation_down', 'fallback' },
				['<C-u>']	= { 'scroll_documentation_up', 'fallback' },
				['<C-e>']	= { 'cancel', 'fallback' },
			},
			appearance = {
				nerd_font_variant = 'mono',
			},
			completion = {
				documentation = { auto_show = true, auto_show_delay_ms = 200 },
				list = { selection = { preselect = true, auto_insert = false } },
			},
			sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },

			fuzzy = { implementation = "rust" }
		},
	},
	{
		"rmagatti/auto-session",
		lazy = false,

		config = function()
			require("auto-session").setup({
				suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
			})
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

-- LSP CONFIG

vim.lsp.config('lua_ls', {
	cmd = { 'lua-language-server' },
	filetypes = { 'lua' },
	root_markers = {
		'.emmyrc.json',
		'.luarc.json',
		'.luarc.jsonc',
	},
	settings = {
		Lua = {
			codeLens = { enable = true },
			hint = { enable = true, semicolon = 'Disable' },
			diagnostics = {
				globals = {'vim'},
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
})
vim.lsp.enable('lua_ls')
-- PLUGING SETTINGS

-- UTIL


local function toggle_terminal()
	vim.cmd("botright vsplit")
	vim.cmd("term")
	vim.cmd("vertical resize 40")
	vim.cmd("startinsert")
end

-- KEY MAPPINGS
vim.keymap.set('n', '<Leader>s', '<Plug>(easymotion-s2)')
vim.keymap.set('n', '<Leader>f', ':CHADopen<CR>')
vim.keymap.set('n', '<Leader>t', toggle_terminal)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Show documentation" })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = "Rename variable" })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "Code actions" })
vim.keymap.set('n', '[d', function() vim.diagnostic.jump({count = -1}) end, { desc = "Go to prev diagnostic" })
vim.keymap.set('n', ']d', function() vim.diagnostic.jump({count = 1}) end, { desc = "Go to next diagnostic" })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = "Show diagnostic float" })
