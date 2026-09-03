-- Neovim 0.11+ native LSP: servers are configured with `vim.lsp.config` and
-- turned on with `vim.lsp.enable`. nvim-lspconfig only ships the per-server
-- defaults (cmd, filetypes, root markers) that those calls merge into.
return {
	{ "mason-org/mason.nvim", opts = {} },

	{
		"mason-org/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			-- rust_analyzer and gopls already come from rustup and `go install`,
			-- so Mason must not shadow them with its own copies.
			ensure_installed = {
				"bashls",
				"jsonls",
				"lua_ls",
				"nil_ls",
				"pyright",
				"ruff",
				"ts_ls",
				"yamlls",
			},
		},
		config = function(_, opts)
			require("mason-lspconfig").setup(opts)

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
					},
				},
			})

			vim.lsp.config("pyright", {
				settings = {
					-- ruff owns imports and linting; pyright only does types.
					pyright = { disableOrganizeImports = true },
					python = {
						analysis = { typeCheckingMode = "standard" },
					},
				},
			})

			vim.lsp.config("gopls", {
				settings = {
					gopls = {
						analyses = { unusedparams = true },
						staticcheck = true,
					},
				},
			})

			vim.lsp.config("rust_analyzer", {
				settings = {
					["rust-analyzer"] = {
						diagnostics = { disabled = { "unresolved-proc-macro" } },
						check = { command = "clippy" },
					},
				},
			})

			vim.lsp.config("yamlls", {
				settings = {
					yaml = {
						schemaStore = { enable = true },
						keyOrdering = false,
					},
				},
			})

			-- Not Mason-managed, so enable them by hand.
			vim.lsp.enable({ "gopls", "rust_analyzer" })
		end,
	},

	{
		"neovim/nvim-lspconfig",
		lazy = true,
		init = function()
			vim.diagnostic.config({
				virtual_text = { prefix = "●" },
				severity_sort = true,
				float = { border = "rounded", source = true },
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local opts = { buffer = args.buf }

					-- Neovim 0.11 already maps grn (rename), gra (code action),
					-- grr (references), gri (implementation), gO (symbols) and K.
					vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
					vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				end,
			})
		end,
	},
}
