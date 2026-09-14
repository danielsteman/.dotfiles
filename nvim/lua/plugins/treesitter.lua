return {
	"nvim-treesitter/nvim-treesitter",
	-- The `master` branch is frozen and its custom query directives call the
	-- pre-0.11 single-node match API, which errors on every injection (fenced
	-- code blocks, heredocs, <script> tags) on Neovim 0.12.
	branch = "main",
	build = ":TSUpdate",
	config = function()
		local parsers = {
			"bash",
			"c",
			"go",
			"gomod",
			"gosum",
			"javascript",
			"json",
			"lua",
			"markdown",
			"markdown_inline",
			"nix",
			"python",
			"rust",
			"toml",
			"tsx",
			"typescript",
			"yaml",
		}
		require("nvim-treesitter").install(parsers)

		vim.api.nvim_create_autocmd("FileType", {
			callback = function(ev)
				if not pcall(vim.treesitter.start, ev.buf) then
					return
				end
				vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
