return {
  {
    "b0o/incline.nvim",
    event = "BufReadPre",
    priority = 1200,
    config = function()
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = { guibg = "#282828", guifg = "##ebdbb2" }, -- magenta500 / base04
            InclineNormalNC = { guifg = "##d3869b", guibg = "#282828" }, -- violet500 / base03
          },
        },
        window = { margin = { vertical = 0, horizontal = 1 } },
        hide = {
          cursorline = true,
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if vim.bo[props.buf].modified then
            filename = "[+] " .. filename
          end

          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },

  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = [[
    ██╗  ██╗███████╗ ██████╗██╗  ██╗███████╗██████╗ ██╗ ██████╗
    ██║  ██║██╔════╝██╔════╝██║  ██║██╔════╝██╔══██╗██║██╔════╝
    ███████║███████╗██║     ███████║█████╗  ██████╔╝██║██║     
    ██╔══██║╚════██║██║     ██╔══██║██╔══╝  ██╔══██╗██║██║     
    ██║  ██║███████║╚██████╗██║  ██║███████╗██║  ██║██║╚██████╗
    ╚═╝  ╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝ ╚═════╝
                ]],
        },
      },
    },
  },
}
