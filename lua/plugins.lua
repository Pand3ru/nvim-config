local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- Colorscheme
    {
      'rebelot/kanagawa.nvim',
      config = function()
        vim.cmd('colorscheme kanagawa')
      end,
    },

    {
      "lervag/vimtex",
      lazy = false, 
      init = function()
        vim.g.vimtex_view_method = "zathura"
        vim.g.vimtex_compiler_method = "latexmk"
    
        vim.g.vimtex_compiler_latexmk = {
          continuous = 1,
          options = {
            "-pdf",
            "-interaction=nonstopmode",
            "-synctex=1",
          },
        }
    
        vim.g.vimtex_quickfix_mode = 0
      end,
    },


    -- Telescope
    {
      'nvim-telescope/telescope.nvim',
      tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
        require('telescope').setup({
          defaults = {
            mappings = {
              i = {
                ["kj"] = "close",
                ["<CR>"] = "select_tab",
              },
            },
          },
        })
      end,
    },

    -- Completion
    {
      "saghen/blink.cmp",
      dependencies = { "rafamadriz/friendly-snippets" },
      version = "*",
      opts = {
        keymap = {
          preset = "enter",
          ["<Up>"] = { "select_prev", "fallback" },
          ["<Down>"] = { "select_next", "fallback" },
          ["<C-b>"] = { "scroll_documentation_up", "fallback" },
          ["<C-f>"] = { "scroll_documentation_down", "fallback" },
          ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
        },
        appearance = {
          nerd_font_variant = "mono",
        },
        sources = {
          default = { "lsp", "path", "snippets", "buffer" },
          per_filetype = {
              tex = { "buffer", "path", "snippets" },

          },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" },
        completion = {
          keyword = { range = "prefix" },
          menu = {
            draw = {
              treesitter = { "lsp" },
            },
          },
          trigger = { show_on_trigger_character = true },
          documentation = {
            auto_show = true,
          },
        },
        signature = { enabled = true },
      },
      opts_extend = { "sources.default" },
    },

    -- LSP Setup
    {
      "williamboman/mason.nvim",
      config = function()
        require("mason").setup()
      end,
    },

    {
      "williamboman/mason-lspconfig.nvim",
      dependencies = { "williamboman/mason.nvim" },
      config = function()
        require("mason-lspconfig").setup({
          ensure_installed = { "lua_ls" },
        })
      end,
    },

    {
      "neovim/nvim-lspconfig",
      config = function()
        local lspconfig = require("lspconfig")
        lspconfig.lua_ls.setup({})
      end,
    },
  },

  -- ✅ These go *outside* the spec block
  install = { colorscheme = { "habamax" } },
  checker = { enabled = true },
})
