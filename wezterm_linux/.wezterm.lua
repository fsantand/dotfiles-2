local wezterm = require "wezterm"

return {
  font = wezterm.font_with_fallback {
    'Monoid Nerd Font',
    'JetBrains Mono',
    'JetBrainsMono',
  },
  font_size = 12,
  harfbuzz_features = {"calt=0", "clig=0", "liga=0"},
  freetype_interpreter_version = 35,
  color_scheme = 'Monokai Pro (Gogh)',
  keys = {
    {
      key = "k",
      mods = "CTRL|SHIFT",
      action = wezterm.action.DisableDefaultAssignment,
    },
    {
      key = "Enter",
      mods = "ALT",
      action = wezterm.action.DisableDefaultAssignment,
    },
    {
      key = "Enter",
      mods = "CTRL|SHIFT|ALT",
      action = wezterm.action.ToggleFullScreen,
    }
  },
  hide_tab_bar_if_only_one_tab = true,
  window_decorations = "RESIZE",
  scrollback_lines = 5000,
}
