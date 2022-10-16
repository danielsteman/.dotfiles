local Plugin = {}

function Plugin.setup()
  local function plugins(use)
    use { 'wbthomason/packer.nvim' }
    use { 'kyazdani42/nvim-web-devicons' }
    use { 'kyazdani42/nvim-tree.lua' }
    use { 'navarasu/onedark.nvim' }
    use {
      "neovim/nvim-lspconfig",
      opt = true,
      event = "BufReadPre",
      wants = { "nvim-lsp-installer" },
      config = function()
        require("config.lsp").setup()
      end,
      requires = {
        "williamboman/nvim-lsp-installer",
      },
    }
  end
  require("packer").startup(plugins)

return Plugin
