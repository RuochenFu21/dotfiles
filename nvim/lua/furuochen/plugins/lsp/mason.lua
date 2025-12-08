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
      -- on_attach for keymaps
      local function on_attach(_, bufnr)
        local map = function(lhs, rhs) vim.keymap.set("n", lhs, rhs, { buffer = bufnr }) end
        map("K", vim.lsp.buf.hover)
        map("gd", vim.lsp.buf.definition)
        map("gr", vim.lsp.buf.references)
        map("<leader>rn", vim.lsp.buf.rename)
        map("<leader>ca", vim.lsp.buf.code_action)
      end

      -- Detect Python interpreter intelligently
      local function get_python_path(root)
        -- 1. Look for .venv in project root
        local venv_path = root .. "/.venv/bin/python"
        if vim.fn.filereadable(venv_path) == 1 then
          return venv_path
        end

        -- 2. Check VIRTUAL_ENV environment variable
        local venv = os.getenv("VIRTUAL_ENV")
        if venv then
          return venv .. "/bin/python"
        end

        -- 3. Fallback to system Python
        return vim.fn.exepath("python3")
      end

      -- Auto-start Pyright for Python files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "python",
        callback = function(ev)
          -- -- Find project root
          -- local root_file = vim.fs.find({ "pyproject.toml", "setup.py", ".git" }, { upward = true })[1]
          -- if not root_file then return end
          -- local root = vim.fs.dirname(root_file)
          --
          -- Start Pyright
          vim.lsp.enable("basedpyright")
        end,
      })
    end,
  },
}
