-- This file can be loaded by calling `lua require('plugins')` from your init.vim

local ensure_packer = function()
        local fn = vim.fn
        local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
        if fn.empty(fn.glob(install_path)) > 0 then
                fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
                vim.cmd [[packadd packer.nvim]]
                return true
        end
        return false
end

local packer_bootstrap = ensure_packer()

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
        -- Packer can manage itself
        use 'wbthomason/packer.nvim'

        use { "williamboman/mason.nvim" }

        use { "williamboman/mason-lspconfig", requires = { { "williamboman/mason.nvim" } } }

        use { "nvim-neotest/nvim-nio" }

        use {
                'nvim-telescope/telescope.nvim', tag = '0.1.4',
                -- or                            , branch = '0.1.x',
                requires = { { 'nvim-lua/plenary.nvim' } }
        }

        use({
                'rose-pine/neovim',
                as = 'rose-pine',
                config = function()
                        vim.cmd('colorscheme rose-pine')
                end
        })

        use "rebelot/kanagawa.nvim"

        use({
                "folke/trouble.nvim",
                config = function()
                        require("trouble").setup {
                                icons = false,
                                -- your configuration comes here
                                -- or leave it empty to use the default settings
                                -- refer to the configuration section below
                        }
                end
        })

        use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
        use('nvim-treesitter/playground')
        use('nvim-treesitter/nvim-treesitter-context')
        use('ThePrimeagen/harpoon')
        use('mbbill/undotree')
        use('tpope/vim-fugitive')
        use 'tpope/vim-sleuth'  -- Detect tabstop and shiftwidth automatically
        use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
        use 'folke/neodev.nvim'

        use {
                'VonHeikemen/lsp-zero.nvim',
                requires = {
                        -- LSP Support
                        { 'neovim/nvim-lspconfig' },
                        { 'williamboman/mason.nvim' },
                        { 'williamboman/mason-lspconfig.nvim' },

                        -- Autocompletion
                        { 'hrsh7th/nvim-cmp' },
                        { 'hrsh7th/cmp-buffer' },
                        { 'hrsh7th/cmp-path' },
                        { 'saadparwaiz1/cmp_luasnip' },
                        { 'hrsh7th/cmp-nvim-lsp' },
                        { 'hrsh7th/cmp-nvim-lua' },

                        -- Snippets
                        { 'L3MON4D3/LuaSnip' },
                        { 'rafamadriz/friendly-snippets' },
                }
        }

        use {
                'nvim-tree/nvim-tree.lua',
                requires = {
                        'nvim-tree/nvim-web-devicons', -- optional, for file icons
                },
        }
        -- Lualine information / Status bar
        use {
                'nvim-lualine/lualine.nvim',
                requires = { 'kyazdani42/nvim-web-devicons', opt = true }
        }

        -- leap navigation
        use {
                'ggandor/leap.nvim',
                requires = { 'tpope/vim-repeat' }
        }

        -- rust
        use 'simrat39/rust-tools.nvim'

        use 'ray-x/lsp_signature.nvim'

        -- debugging
        use 'mfussenegger/nvim-dap'
        use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } }
        use { "julianolf/nvim-dap-lldb", requires = { "mfussenegger/nvim-dap" } }
        use 'nvim-lua/plenary.nvim'

        -- markdown preview
        --use({ "iamcco/markdown-preview.nvim", run = function() vim.fn["mkdp#util#install"]() end, })
        --use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })
        use { 'euclio/vim-markdown-composer',
                run = 'cargo build --release',
                config = function()
                        vim.g.markdown_composer_external_renderer = 'pandoc -f markdown -t html'
                        vim.g.markdown_composer_autostart = 0
                end
        }


        -- tabs
        -- These optional plugins should be loaded directly because of a bug in Packer lazy loading
        use 'nvim-tree/nvim-web-devicons' -- OPTIONAL: for file icons
        use 'lewis6991/gitsigns.nvim' -- OPTIONAL: for git status
        use 'romgrk/barbar.nvim'

        -- lsp formatting
        use "lukas-reineke/lsp-format.nvim"

        -- Automatically set up your configuration after cloning packer.nvim
        -- Put this at the end after all plugins
        if packer_bootstrap then
                require('packer').sync()
        end
end)
