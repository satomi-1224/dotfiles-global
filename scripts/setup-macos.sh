#!/bin/bash
#
# macOS settings that nix-darwin's system.defaults cannot handle.
# Run once per machine after initial setup.
#
set -euo pipefail

echo "=== macOS extra setup ==="

# --- Caps Lock → Control ---
echo "Setting Caps Lock → Control..."
hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x7000000E0}]}' > /dev/null

# --- Live conversion OFF (Japanese input) ---
echo "Disabling live conversion..."
defaults write com.apple.inputmethod.Kotoeri JIMPrefLiveConversionKey -bool false

# --- Night Shift: always on, warmest ---
echo "Enabling Night Shift (always on, warmest)..."
# Night Shift is managed via CoreBrightness framework.
# The plist is per-user at:
#   ~/Library/Preferences/com.apple.CoreBrightness.plist
#
# Automated configuration requires manipulating CBBlueReductionStatus.
# This is fragile across macOS versions. If the commands below fail,
# set Night Shift manually: System Settings → Displays → Night Shift → Schedule: Custom → Sunset to Sunrise (or manual full-time).

NIGHTSHIFT_PLIST="$HOME/Library/Preferences/com.apple.CoreBrightness.plist"
if [ -f "$NIGHTSHIFT_PLIST" ]; then
  # Get current user UID for the plist key
  USER_UID=$(dscl . -read /Users/"$(whoami)" GeneratedUID | awk '{print $2}')
  PLIST_KEY="CBUser-${USER_UID}"

  # Set schedule to sunset-to-sunrise (mode 2) and enable
  defaults write com.apple.CoreBrightness "${PLIST_KEY}" -dict-add \
    CBBlueLightReductionSchedule -dict \
      DayStartHour 7 \
      DayStartMinute 0 \
      NightStartHour 0 \
      NightStartMinute 0
  defaults write com.apple.CoreBrightness "${PLIST_KEY}" -dict-add \
    CBBlueReductionStatus -dict \
      AutoBlueReductionEnabled 1 \
      BlueLightReductionSchedule 2 \
      BlueReductionEnabled 1 \
      BlueReductionMode 2 \
      UserAutoBlueReductionEnabled 1

  echo "Night Shift configured. You may need to restart to take effect."
else
  echo "WARNING: CoreBrightness plist not found. Set Night Shift manually."
  echo "  System Settings → Displays → Night Shift"
fi

echo ""
echo "=== Done ==="
echo "Note: Some settings may require logout/restart to take effect."
