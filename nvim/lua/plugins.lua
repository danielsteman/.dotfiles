local Plugin = {}

function Plugin.setup()
  local function plugins(use)

    require('utils.settings').setup()
    require('config.keymap').setup()

    use { 'wbthomason/packer.nvim' }
    use {
      'kyazdani42/nvim-web-devicons',
      config = function()
        require('nvim-web-devicons').setup { default = true }
      end,
    }
    use {
      'kyazdani42/nvim-tree.lua',
      config = function()
        require('config.nvim-tree').setup()
      end,
    }
    use {
      'navarasu/onedark.nvim',
      config = function()
        require('config.theme').setup()
      end,
    }
    use {
      'neovim/nvim-lspconfig',
      opt = true,
      event = 'BufReadPre',
      wants = { 'nvim-lsp-installer' },
      config = function()
        require('config.lsp').setup()
      end,
      requires = {
        'williamboman/nvim-lsp-installer',
      },
    }
    use {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      opt = true,
      config = function()
        require("config.cmp").setup()
      end,
      wants = { "LuaSnip" },
      requires = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lua",
        "ray-x/cmp-treesitter",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        {
          "L3MON4D3/LuaSnip",
          wants = "friendly-snippets",
          config = function()
            require("config.luasnip").setup()
          end,
        },
        "rafamadriz/friendly-snippets",
      },
      disable = false,
    }
    use {
      "neovim/nvim-lspconfig",
      opt = true,
      event = "BufReadPre",
      wants = { "cmp-nvim-lsp", "nvim-lsp-installer", "lsp_signature.nvim" },
      config = function()
        require("config.lsp").setup()
      end,
      requires = {
        "williamboman/nvim-lsp-installer",
        "ray-x/lsp_signature.nvim",
      },
    }

  end

  require('packer').startup(plugins)

end

return Plugin
