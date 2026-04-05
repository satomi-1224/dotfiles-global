local wezterm = require('wezterm')
local config = wezterm.config_builder()

-- ============================================================================
-- カラーテーマ
-- ============================================================================
config.color_scheme = 'Selenized Dark (Gogh)'

-- 背景の透明度設定
config.window_background_opacity = 0.8

-- ============================================================================
-- フォント設定
-- ============================================================================
config.font = wezterm.font_with_fallback({
  { family = 'JetBrains Mono', harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0', 'dlig=0' } },
  'Hiragino Sans',
  'Menlo',
  'Monaco',
})
config.font_size = 14.0

-- ============================================================================
-- ウィンドウ設定
-- ============================================================================
-- タイトルバーを非表示にしてリサイズのみ有効
config.window_decorations = 'RESIZE'
config.window_padding = {
  left = 8,
  right = 8,
  top = 6,
  bottom = 6,
}

-- ============================================================================
-- タブバー設定
-- ============================================================================
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false

-- タブバーの色設定
config.colors = {
  tab_bar = {
    background = "#002b36",  -- タブバー領域全体(ドラッグ可能な領域)の背景色
    active_tab = {
      bg_color = "#2aa198",
      fg_color = "#002b36",
    },
    inactive_tab = {
      bg_color = "#073642",
      fg_color = "#839496",
    },
    inactive_tab_hover = {
      bg_color = "#586e75",
      fg_color = "#93a1a1",
    },
  },
}

-- タブバー領域の透明度を調整
config.window_frame = {
  inactive_titlebar_bg = "rgba(0, 43, 54, 0.8)",
  active_titlebar_bg = "rgba(0, 43, 54, 0.8)",
}

-- ============================================================================
-- キーバインド
-- ============================================================================
config.keys = {
  -- タブ操作
  { key = 't', mods = 'CMD', action = wezterm.action.SpawnTab('CurrentPaneDomain') },
  { key = 'w', mods = 'CMD', action = wezterm.action.CloseCurrentTab({ confirm = true }) },

  -- ペイン分割
  { key = 'd', mods = 'CMD', action = wezterm.action.SplitHorizontal({ domain = 'CurrentPaneDomain' }) },
  { key = 'd', mods = 'CMD|SHIFT', action = wezterm.action.SplitVertical({ domain = 'CurrentPaneDomain' }) },

  -- ペイン間移動
  { key = 'LeftArrow', mods = 'CMD|SHIFT', action = wezterm.action.ActivatePaneDirection('Left') },
  { key = 'RightArrow', mods = 'CMD|SHIFT', action = wezterm.action.ActivatePaneDirection('Right') },
  { key = 'UpArrow', mods = 'CMD|SHIFT', action = wezterm.action.ActivatePaneDirection('Up') },
  { key = 'DownArrow', mods = 'CMD|SHIFT', action = wezterm.action.ActivatePaneDirection('Down') },

  -- フォントサイズ調整
  { key = '+', mods = 'CMD', action = wezterm.action.IncreaseFontSize },
  { key = '-', mods = 'CMD', action = wezterm.action.DecreaseFontSize },
  { key = '0', mods = 'CMD', action = wezterm.action.ResetFontSize },

  -- Shift+Enterで改行を送信
  { key = 'Enter', mods = 'SHIFT', action = wezterm.action.SendString('\n') },
}

-- ============================================================================
-- パフォーマンス設定
-- ============================================================================
config.front_end = 'WebGpu'
config.max_fps = 120
config.animation_fps = 60

-- ============================================================================
-- その他の設定
-- ============================================================================
config.scrollback_lines = 10000
config.enable_scroll_bar = false
config.audible_bell = 'Disabled'
config.use_ime = true

-- macOS特有の設定
config.macos_window_background_blur = 20
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = true

return config
