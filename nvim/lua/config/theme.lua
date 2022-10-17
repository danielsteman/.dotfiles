local Theme = {}

function Theme.setup()

  require('onedark').setup {
    style = 'deep'
  }
  require('onedark').load()

end

return Theme