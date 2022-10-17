local Plugin = {}

function Plugin.setup()
  local function plugins(use)

    require("utils.settings").setup()
    require("config.keymap").setup()

    use { 'wbthomason/packer.nvim' }
    use {
      'kyazdani42/nvim-web-devicons',
      config = function()
        require("nvim-web-devicons").setup { default = true }
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

  end

  require("packer").startup(plugins)

end

return Plugin
