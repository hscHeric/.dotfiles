return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      -- Ensure mason installs the server
      clangd = {
        keys = {
          { "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
        },
        root_dir = function(fname)
          return require("lspconfig.util").root_pattern(
            ".clangd",
            "Makefile",
            "configure.ac",
            "configure.in",
            "config.h.in",
            "meson.build",
            "meson_options.txt",
            "build.ninja"
          )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
            fname
          ) or require("lspconfig.util").find_git_ancestor(fname)
        end,
        capabilities = {
          offsetEncoding = { "utf-16" }, -- Standard capability for precise positioning.
        },
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy", -- Enables clang-tidy. clangd will automatically look for a .clang-tidy file
          -- in the project directory and apply its checks. This will show warnings from clang-tidy.
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--fallback-style=llvm", -- Specifies the code formatting style to use if no .clang-format file is found
          -- in the project. clangd automatically detects and uses a .clang-format file if present.
          -- If not found, it will use LLVM style as requested.
        },
        init_options = {
          usePlaceholders = true,
          completeUnimported = true,
          clangdFileStatus = true, -- Shows clangd status information, can be helpful for diagnostics.
        },
      },
    },
    setup = {
      clangd = function(_, opts)
        local clangd_ext_opts = LazyVim.opts("clangd_extensions.nvim")
        require("clangd_extensions").setup(vim.tbl_deep_extend("force", clangd_ext_opts or {}, { server = opts }))
        return false -- Important: return false to allow nvim-lspconfig to also run its default setup for clangd.
      end,
    },
  },
}
