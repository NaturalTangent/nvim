local lsp = require("lsp-zero")

local lsp_attach = function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp.default_keymaps({buffer = bufnr})
end

lsp.extend_lspconfig({
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  lsp_attach = lsp_attach,
  float_border = 'rounded',
  sign_text = true,
})


local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
	  ['<Up>'] = cmp.mapping.select_prev_item(cmp_select),
	  ['<Down>'] = cmp.mapping.select_next_item(cmp_select),
	  ['<CR>'] = cmp.mapping.confirm({ select = true }),
	  ["<C-Space>"] = cmp.mapping.complete(),
	  ["<C-e>"] = cmp.mapping.abort(),
	}),
})

require("mason").setup()
require('mason-lspconfig').setup({
  -- Replace the language servers listed here
  -- with the ones you want to install
  ensure_installed = {'gopls', 'rust_analyzer'},
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
  }
})



-- lsp.preset("recommended")
--
--lsp.ensure_installed({
--  'rust_analyzer',
--  'gopls',
--  'clangd',
--})
--
---- Fix Undefined global 'vim'
--lsp.nvim_workspace()
--
--local cmp = require('cmp')
--local cmp_select = {behavior = cmp.SelectBehavior.Select}
--local cmp_mappings = lsp.defaults.cmp_mappings({
--  ['<Up>'] = cmp.mapping.select_prev_item(cmp_select),
--  ['<Down>'] = cmp.mapping.select_next_item(cmp_select),
--  ['<CR>'] = cmp.mapping.confirm({ select = true }),
--  ["<C-Space>"] = cmp.mapping.complete(),
--  ["<C-e>"] = cmp.mapping.abort(),
--})
--
--
--lsp.setup_nvim_cmp({
--  mapping = cmp_mappings
--})
--
--lsp.set_preferences({
--    suggest_lsp_servers = false,
--    sign_icons = {
--        error = 'E',
--        warn = 'W',
--        hint = 'H',
--        info = 'I'
--    }
--})
--
--lsp.on_attach(function(client, bufnr)
--  local opts = {buffer = bufnr, remap = false}
--
--  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
--  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
--  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
--  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
--  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
--  vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
--  vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
--  vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)
--  vim.keymap.set("n", "<leader>wl", function() 
--    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--  end, opts)
--  vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
--  vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
--  vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
--  vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
--  vim.keymap.set({"n", "v"}, "<leader>a", vim.lsp.buf.code_action, opts)
--  vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
--  vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
--end)
--
--lsp.setup()
--
--vim.diagnostic.config({
--    virtual_text = true,
--})
