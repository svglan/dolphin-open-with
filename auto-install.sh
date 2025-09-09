#!/usr/bin/env bash
set -e

echo "=== Fix Dolphin Open With menu on Hyprland ==="

# 1. Создать скрипт fix-dolphin-open-with.sh
FIX_SCRIPT="$HOME/fix-dolphin-open-with.sh"
cat > "$FIX_SCRIPT" <<'EOF'
#!/usr/bin/env bash
XDG_MENU_PREFIX=arch- kbuildsycoca6 --noincremental
EOF

chmod +x "$FIX_SCRIPT"
echo "[OK] Created $FIX_SCRIPT"

# 2. Добавить в hyprland.conf настройки, если их ещё нет
HYPRCONF="$HOME/.config/hypr/hyprland.conf"

if ! grep -q "XDG_MENU_PREFIX,arch-" "$HYPRCONF"; then
    echo "env = XDG_MENU_PREFIX,arch-" >> "$HYPRCONF"
    echo "[OK] Added env to $HYPRCONF"
else
    echo "[SKIP] env already exists in $HYPRCONF"
fi

if ! grep -q "fix-dolphin-open-with.sh" "$HYPRCONF"; then
    echo "exec-once = $FIX_SCRIPT" >> "$HYPRCONF"
    echo "[OK] Added exec-once to $HYPRCONF"
else
    echo "[SKIP] exec-once already exists in $HYPRCONF"
fi

# 3. Пересобрать кеш прямо сейчас
XDG_MENU_PREFIX=arch- kbuildsycoca6 --noincremental
echo "[OK] Rebuilt ksycoca cache"

# 4. Перезапустить Dolphin (если он запущен)
if pgrep -x "dolphin" > /dev/null; then
    killall dolphin
    sleep 1
    dolphin & disown
    echo "[OK] Restarted Dolphin"
else
    echo "[INFO] Dolphin was not running"
fi

# 5. Сообщение пользователю
echo "=== Done! Please relogin or restart Hyprland for full effect. ==="
