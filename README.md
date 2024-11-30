# chkn.nvim

🐔 **Scratch smarter, not harder!**

**chkn.nvim** is a Neovim plugin that gives you a cozy little scratchpad to jot down your fleeting thoughts, ideas, and code snippets — right in the middle of your editor. Like a chicken scratching in the dirt, it’s simple, persistent, and always ready to dig up something useful.

## Features

- 🖋️ **Centered Floating Window**: A clean, distraction-free space to scratch out ideas.
- 💾 **Persistent Memory**: Save your scratches automatically—no more lost nuggets of genius!
- ⚡ **LazyVim-Ready**: Easy to install and configure with your LazyVim setup.
- 🐓 **Quick Access**: Open it with a keybind, scratch away, and get back to work.

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):
Add the following to `plugins/chkn.lua`, then run `:Lazy sync` and restart Neovim.

```lua
return {
  "ericrswanny/chkn.nvim",
  branch = "feat/chkntoggle",
  config = function()
    require("chkn").setup({
      width = 80,
      height = 20,
      border = "rounded",
      persistent = true,
    })
  end,
  lazy = false,
  keys = {
    {
      "<leader>sp",
      ":ChknToggle<CR>",
      desc = "Toggle Scratchpad",
    },
  },
}

```

## Development

To get started developing, add the following line after the git URL in your `plugins/chkn.lua` file:

```lua
  dependencies = { "nvim-lua/plenary.nvim" }, -- plenary for tests
```

Run tests with `./run_tests.sh`

GitHub actions can be run locally using `act`.

- `act -j test`

ericrswanny
