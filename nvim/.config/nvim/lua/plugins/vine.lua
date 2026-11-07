local vine_repo = vim.fn.expand("~/src/vine")

vim.filetype.add({
	extension = {
		vi = "vine",
	},
})

vim.api.nvim_create_autocmd("User", {
	pattern = "TSUpdate",
	callback = function()
		require("nvim-treesitter.parsers").vine = {
			install_info = {
				url = "https://github.com/...",
				files = { "src/parser.c" },
				branch = "main",
			},
		}
	end,
})

vim.treesitter.language.register("vine", "vine")

local capabilities = require("blink.cmp").get_lsp_capabilities()
local augroup = vim.api.nvim_create_augroup("VineConfig", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = "vine",
	callback = function(args)
		vim.bo[args.buf].commentstring = "// %s"

		local root_dir = vim.fs.dirname(vim.fs.find({ ".git", "src" }, { upward = true })[1])
			or vim.fn.getcwd()

		vim.lsp.start({
			name = "vine",
			cmd = { "vine", "lsp", "--", "src/main.vi" },
			root_dir = root_dir,
			capabilities = capabilities,
		})

		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = args.buf,
			callback = function()
				local lines = vim.api.nvim_buf_get_lines(args.buf, 0, -1, false)
				local res = vim.system({ "vine", "fmt" }, { stdin = lines, text = true }):wait()
				if res.code == 0 and res.stdout then
					local formatted = vim.split(res.stdout, "\n", { plain = true })
					if formatted[#formatted] == "" then
						table.remove(formatted)
					end
					local view = vim.fn.winsaveview()
					vim.api.nvim_buf_set_lines(args.buf, 0, -1, false, formatted)
					vim.fn.winrestview(view)
				end
			end,
		})
	end,
})
