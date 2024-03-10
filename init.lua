return {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "stable", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = true, -- automatically quit the current session after a successful update
    remotes = {
    },
  },

  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = false,
    underline = true,
  },

  -- Configure require("lazy").setup() options
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin" },
      },
    },
  },

  polish = function()
    -- load in module from .vim/dap.lua
    -- set dap.adapters = ...

    -- if .vim/dap.lua does not exist use default configuration
    local dap = require("dap")
    dap.adapters.python = {
      type = "executable",
      command = "/usr/bin/python3",
      args = { "-m", "debugpy.adapter" },
    }
    dap.configurations.python = {
        {
          type = "python", 
          request = "launch",
          name = "Launch file",
          -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
          program = "${file}", -- This configuration will launch the current file if used.
          pythonPath = function()
            local conda_prefix = os.getenv("CONDA_PREFIX")
            if conda_prefix then
              return conda_prefix .. "/bin/python"
            else
              local cwd = vim.fn.getcwd()
              if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
                return cwd .. "/venv/bin/python"
              elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
                return cwd .. "/.venv/bin/python"
              else
                return "/usr/bin/python"
              end
            end
          end,
          cwd = function()
            return vim.fn.getcwd()
          end,
        },
      -- other configurations...
    }
  end,
}
