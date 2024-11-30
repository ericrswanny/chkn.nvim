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

```lua
return {
  "ericrswanny/chkn.nvim",
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

ericrswanny
