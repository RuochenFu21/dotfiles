return {
  'brianhuster/live-preview.nvim',
  dependencies = {
    -- You can choose one of the following pickers
    'nvim-telescope/telescope.nvim',
    'ibhagwan/fzf-lua',
    'echasnovski/mini.pick',
    'folke/snacks.nvim',
  },
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "html"
      },
      callback = function(event)
        vim.keymap.set("n", "gp", ":LivePreview start<CR>", { buffer = event.buf })
      end,
    })
  end
}
