return {
  'prettier',
  config = function ()
    local prettier = require("prettier")

    prettier.setup {
      bin = 'prettierd',
      filetypes = {
        "css",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "json",
        "scss",
        "less",
        "yaml"
      }
    }

  end
}
