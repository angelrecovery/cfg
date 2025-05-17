vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.opt.breakindent = true

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = 'yes'

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.inccommand = 'split'

vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'

vim.opt.scrolloff = 10

vim.opt.confirm = true

vim.opt.clipboard = 'unnamedplus'

-- Clear search highlights on escape
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
-- Diagnostics
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic quickfix list' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Bootstrap lazy
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Plugins
require('lazy').setup({
  { -- Colors
    'catppuccin/nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'catppuccin'
    end,
  },

  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  {
  { -- AI
    'yetone/avante.nvim',
    event = 'VeryLazy',
    version = false,
    opts = {
      provider = 'claude',
      gemini = {
        model = 'gemini-2.5-flash-preview-04-17',
        timeout = 30000,
        temperature = 0,
        max_tokens = 4096,
      },
      claude = {
        model = 'claude-3-5-haiku-latest',
        timeout = 30000,
        temperature = 0,
        max_tokens = 4096,
      },
      openai = {
        model = 'o4-mini',
        timeout = 30000,
        temperature = 0,
        max_tokens = 4096,
      },
      web_search_engine = {
        provider = 'tavily',
      },
      windows = {
        width = 25, -- % of the screen width
      },
      mappings = {},
    },
    build = 'make',
    dependencies = {
      -- Required
      'nvim-treesitter/nvim-treesitter',
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      -- Optional
      'nvim-telescope/telescope.nvim',
      'hrsh7th/nvim-cmp',
      'nvim-tree/nvim-web-devicons',
      { -- Support for image pasting
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            use_absolute_path = true,
          },
        },
      },
      { -- Markdown rendering for chats
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { 'markdown', 'Avante' },
        },
        ft = { 'markdown', 'Avante' },
      },
    },
  },
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }

      -- Auto surround
      require('mini.surround').setup()

      -- Auto pairs
      require('mini.pairs').setup()

      -- Status line
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- Make the statusline cursor position display as line:column
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- Start screen
      require('mini.starter').setup()
    end,
  },

  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {},
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
  },

  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  { -- which-key
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      delay = 0,
      spec = {
        -- Groups
        { '<leader>s', group = 'Search' },
        { '<leader>t', group = 'Toggle' },
        { '<leader>a', group = 'AI' },
        -- AI (Avante)
        { '<leader>aa', group = 'Ask' },
        { '<leader>aB', group = 'Add current buffers' },
        { '<leader>aB', group = 'Add all open buffers' },
        { '<leader>ad', group = 'Toggle debug' },
        { '<leader>af', group = 'Focus' },
        { '<leader>ah', group = 'Select history' },
        { '<leader>an', group = 'Create new ask' },
        { '<leader>ar', group = 'Refresh' },
        { '<leader>aR', group = 'Display repo map' },
        { '<leader>as', group = 'Toggle suggestions' },
        { '<leader>aS', group = 'Stop' },
        { '<leader>at', group = 'Toggle' },
        { '<leader>a?', group = 'Select model' },
      },
    },
  },

  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',

        build = 'make',

        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
    },
    config = function()
      require('telescope').setup {
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Search help' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'Search keymap' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Search files' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = 'Search select telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = 'Search current word' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Search by grep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'Search diagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = 'Search resume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = 'Search recent files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Find existing buffers' })

      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = 'Fuzzy search in current buffer' })

      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live grep in open files',
        }
      end, { desc = 'Search in open files' })

      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = 'Search neovim files' })
    end,
  },

  { -- lazydev.nvim
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },

  { -- LSP configurations
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', opts = {} },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      { 'j-hui/fidget.nvim', opts = {} },

      'saghen/blink.cmp',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lily-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Rename the variable under cursor
          map('grn', vim.lsp.buf.rename, 'Rename')
          -- Execute code action
          map('gra', vim.lsp.buf.code_action, 'Goto code action', { 'n', 'x' })
          -- Find references for the word under cursor
          map('grr', require('telescope.builtin').lsp_references, 'Goto references')
          -- Jump to the implementation of the word under cursor
          map('gri', require('telescope.builtin').lsp_implementations, 'Goto implementation')
          -- Jump to the definition of the word under cursor
          map('grd', require('telescope.builtin').lsp_definitions, 'Goto definition')
          -- Jump to the declaration of the word under cursor
          map('grD', vim.lsp.buf.declaration, 'Goto declaration')
          -- Fuzzy find all the symbols in current document
          map('gO', require('telescope.builtin').lsp_document_symbols, 'Open document symbols')
          -- Fuzzy find all the symbols in current workspace
          map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open workspace symbols')
          -- Jump to the type of the word under your cursor
          map('grt', require('telescope.builtin').lsp_type_definitions, 'Goto type definition')

          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('lily-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('lily-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'lily-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, 'Toggle inlay hints')
          end
        end,
      })

      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'padded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      local enabled_servers = {
        rust_analyzer = {},
        zls = {},
        clangd = {},
        ruff = {},
        gopls = {},
        ts_ls = {},
        jsonls = {},
        yamlls = {},
        cssls = {},
        html = {},
        htmx = {},
        --sqlls = {},
        postgrestools = {},
        asm_lsp = {},
        dockerls = {},
        just = {},
        cmake = {},
        stylua = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
      }
      local ensure_installed = vim.tbl_keys(enabled_servers or {})

      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        ensure_installed = {},
        automatic_enable = true,
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = enabled_servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  { -- Auto formatting
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = 'Format buffer',
      },
    },
    opts = {
      notify_on_error = true,
      format_on_save = function(bufnr)
        local disable_filetypes = {}
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        rust = { 'rustfmt' },
        python = { 'ruff' },
      },
    },
  },

  { -- Auto completion
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {},
        opts = {},
      },
      'folke/lazydev.nvim',
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = {
        -- Accept completions with tab
        preset = 'super-tab',
      },

      appearance = {
        nerd_font_variant = 'mono',
      },

      completion = {
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'lazydev' },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        },
      },

      snippets = { preset = 'luasnip' },

      fuzzy = { implementation = 'lua' },

      signature = { enabled = true },
    },
  },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = { 'bash', 'c', 'zig', 'rust', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      auto_install = true,
      highlight = {
        enable = true,
      },
      indent = { enable = true },
    },
  },
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
