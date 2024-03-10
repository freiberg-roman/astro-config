return {
  dap = {
    adapters = {
      python = {
        type = "executable",
        command = "/usr/bin/python3"
        args = { "-m", "debugpy.adapter" },
      },
    },
    configurations = {
      python = {
        {
          -- The first three options are required by nvim-dap
          type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
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
      },
    },
  },
}
