# AstroNvim User Configuration Example

A user configuration template for [AstroNvim](https://github.com/AstroNvim/AstroNvim)

## 🛠️ Installation

#### Make a backup of your current nvim and shared folder

```shell
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
```

#### Clone AstroNvim

```shell
git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim
```

#### Create a new user repository from this template

Press the "Use this template" button above to create a new repository to store your user configuration.

You can also just clone this repository directly if you do not want to track your user configuration in GitHub.

#### Clone the repository

```shell
git clone https://github.com/freiberg-roman/astro-config.git ~/.config/nvim/lua/user
```

#### Start Neovim

```shell
nvim
```

#### Custom DAP config

This user config searches for a .vim/dap.lua file in the launched directory for custom user DAP configs.

Example python `dap.lua` file

```lua
return {
  dap = {
    adapters = {
      python = {
        type = "executable",
        command = "/usr/bin/python3",
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
          args = {"cwd=sheesh"},
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
        {
            -- other configurations
        },
      },
    },
  },
}
```
