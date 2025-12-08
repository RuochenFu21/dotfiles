return {
  -- Mason: installs external tools (LSPs, linters, DAPs)
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- Mason + LSP integration
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "basedpyright", "lua_ls" }, -- automatically install Pyright
        automatic_installation = true,
      })
    end,
  },

  -- Neovim 0.11 LSP setup
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      -- Auto-start Pyright for Python files
    end,
  },
}
