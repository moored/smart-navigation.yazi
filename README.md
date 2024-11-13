# smart-navigation.yazi

The Smoothest UX on Yazi you'll ever see: preview files in **flow**.

<https://github.com/user-attachments/assets/ae3a5cae-b49c-4ffa-896b-b71fbe27d1bd>

You can also cycle while in-preview:

<https://github.com/user-attachments/assets/de3bf54e-2c76-44fc-bfe5-c4d6d3a5e782>

## Features

- "Go right" on a file with a preview to maximize the preview
- When in maximized preview mode, navigate the file with up/down/j/k, but "unmaximize" the preview by "going left"
- Immediately be able to open the file you're previewing (usually with enter). When exiting, you won't be back to the preview (that would be tedious) and instead be back to the directory.
- According to the recommended controls below, you're also able to jump around in the file

## Installation

This plugin depends on the [max-preview.yazi](https://github.com/yazi-rs/plugins/blob/main/max-preview.yazi) plugin, so you gotta install both as shown below:

```sh
ya pack -a yazi-rs/plugins:max-preview
ya pack -a AmeerArsala/smart-navigation
```

## Usage

Ideally, your `~/.config/yazi/keymap.toml` should contain something like this (this is what I use):

```toml
[manager]
prepend_keymap = [
  { on = "<C-k>", run = "arrow -1", desc = "Move cursor up 1 entry" },  # i promise this will make sense
  { on = "<C-j>", run = "arrow 1", desc = "Move cursor down 1 entry" }, # i promise this will make sense

  { on = "<Up>", run = "plugin smart-navigation --sync --args='jump -1 -1'", desc = "Go up" },
  { on = "k", run = "plugin smart-navigation --sync --args='jump -1 -1'", desc = "Go up" },

  { on = "<Down>", run = "plugin smart-navigation --sync --args='jump 1 1'", desc = "Go down" },
  { on = "j", run = "plugin smart-navigation --sync --args='jump 1 1'", desc = "Go down" },

  { on = "<Left>", run = "plugin smart-navigation --sync --args='left'", desc = "Go left" },
  { on = "h", run = "plugin smart-navigation --sync --args='left'", desc = "Go left" },

  { on = "<Right>", run = "plugin smart-navigation --sync --args='right'", desc = "Go right" },
  { on = "l", run = "plugin smart-navigation --sync --args='right'", desc = "Go right" },

  { on = "<S-Up>", run = "plugin smart-navigation --sync --args='jump -5 -50'", desc = "Jump upward" },
  { on = "<S-Down>", run = "plugin smart-navigation --sync --args='jump 5 50'", desc = "Jump downward" },

  { on = "<PageUp>", run = "plugin smart-navigation --sync --args='jump -50% -100'", desc = "Jump up half a page" },
  { on = "<PageDown>", run = "plugin smart-navigation --sync --args='jump 50% 100'", desc = "Jump down half a page" },

  { on = "<Enter>", run = "plugin smart-navigation --sync --args='open'", desc = "Open selected files" },
]
```

## License

This plugin is MIT-licensed. For more information check the [LICENSE](LICENSE) file.
