-- Format on save. conform.nvim runs a real formatter where one exists and
-- falls back to the LSP otherwise.
return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true })
				end,
				mode = { "n", "v" },
				desc = "Format buffer",
			},
		},
		opts = {
			formatters_by_ft = {
				bash = { "shfmt" },
				css = { "prettierd", "prettier", stop_after_first = true },
				go = { "goimports", "gofumpt" },
				html = { "prettierd", "prettier", stop_after_first = true },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				javascriptreact = { "prettierd", "prettier", stop_after_first = true },
				json = { "prettierd", "prettier", stop_after_first = true },
				jsonc = { "prettierd", "prettier", stop_after_first = true },
				lua = { "stylua" },
				markdown = { "prettierd", "prettier", stop_after_first = true },
				nix = { "nixfmt" },
				python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
				rust = { "rustfmt" },
				sh = { "shfmt" },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				typescriptreact = { "prettierd", "prettier", stop_after_first = true },
				yaml = { "prettierd", "prettier", stop_after_first = true },
			},
			default_format_opts = { lsp_format = "fallback" },
			format_on_save = function(bufnr)
				if vim.b[bufnr].disable_autoformat or vim.g.disable_autoformat then
					return
				end
				return { timeout_ms = 2000 }
			end,
			formatters = {
				shfmt = { prepend_args = { "-i", "2", "-ci" } },
			},
		},
		init = function()
			-- Let :w ! and friends go through conform too.
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

			vim.api.nvim_create_user_command("FormatDisable", function(args)
				if args.bang then
					vim.b.disable_autoformat = true
				else
					vim.g.disable_autoformat = true
				end
			end, { desc = "Disable format on save (! for this buffer only)", bang = true })

			vim.api.nvim_create_user_command("FormatEnable", function()
				vim.b.disable_autoformat = false
				vim.g.disable_autoformat = false
			end, { desc = "Re-enable format on save" })
		end,
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason-org/mason.nvim" },
		event = "VeryLazy",
		opts = {
			-- rustfmt and gofmt ship with their toolchains; the rest are Mason's.
			-- nixfmt is deliberately absent: Mason only publishes a linux_x64
			-- asset for it, so install it with nix and let conform find it on
			-- PATH.
			ensure_installed = {
				"gofumpt",
				"goimports",
				"prettierd",
				"ruff",
				"shfmt",
				"stylua",
			},
		},
	},
}
