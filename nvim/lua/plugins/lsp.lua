return {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v3.x",
	dependencies = {
		-- LSP Support
		{ "neovim/nvim-lspconfig" },
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },

		-- Autocompletion
		{ "hrsh7th/nvim-cmp" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "saadparwaiz1/cmp_luasnip" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-nvim-lua" },

		-- Snippets
		{ "L3MON4D3/LuaSnip" },
		{ "rafamadriz/friendly-snippets" },

		-- Formatting
		{ "mfussenegger/nvim-lint" },
	},
	config = function()
		local lsp = require("lsp-zero")
		local mason = require("mason").setup()

		local cmp = require("cmp")
		local cmp_select = { behavior = cmp.SelectBehavior.Select }
		local cmp_mappings = lsp.defaults.cmp_mappings({
			["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
			["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
			["<C-y>"] = cmp.mapping.confirm({ select = true }),
			["<C-Space>"] = cmp.mapping.complete(),
		})

		cmp.setup({
			mapping = cmp_mappings,
		})

		lsp.on_attach(function(client, bufnr)
			lsp.default_keymaps({ buffer = bufnr })

			vim.keymap.set("n", "<leader>vd", function()
				vim.diagnostic.open_float()
			end, opts)
			vim.keymap.set("n", "<leader>vca", function()
				vim.lsp.buf.code_action()
			end, opts)
			vim.keymap.set("n", "<leader>gd", function()
				vim.lsp.buf.definition()
			end, opts)

			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({ async = true, bufnr = bufnr })
					end,
				})
			end
		end)

		local nvim_lint = require("lint")

        nvim_lint.linters_by_ft = {
            ["*"] = { "prettier" },
        }

		local nvim_lsp = require("lspconfig")

		nvim_lsp.rust_analyzer.setup({
			settings = {
				["rust-analyzer"] = {
					diagnostics = {
						disabled = { "unresolved-proc-macro" },
					},
				},
			},
		})

		lsp.setup_servers({ "rust_analyzer", "pyright", "gopls" })

		lsp.setup()
	end,
}
