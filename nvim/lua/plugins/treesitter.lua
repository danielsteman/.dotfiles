return {
	"nvim-treesitter/nvim-treesitter",
	-- Pinned: the `main` rewrite drops `nvim-treesitter.configs` and needs a
	-- different setup call entirely.
	branch = "master",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"bash",
				"c",
				"go",
				"gomod",
				"gosum",
				"javascript",
				"json",
				"jsonc",
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
			},
			sync_install = false,
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
