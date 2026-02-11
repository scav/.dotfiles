#!/usr/bin/env bash

KEYMAP=$(hyprctl devices -j | jq -r '
  .keyboards[]
  | select(.main == true)
  | if .active_layout_index == 0 then " US 🇺🇸 "
    elif .active_layout_index == 1 then " NO 🇳🇴"
    else " UNKNOWN"
    end
    ')
echo -n $KEYMAP
