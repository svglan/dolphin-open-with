# dolphin-open-with Fix for Hyprland (Arch Linux)

Автоматизирует восстановление меню **"Open With"** в **Dolphin** в окружении **Hyprland** на Arch Linux.

---

##  Что делает скрипт `auto-install.sh`

- Создаёт вспомогательный скрипт `~/fix-dolphin-open-with.sh`, который:
  - Перестраивает системное меню приложений (`kbuildsycoca6`) с префиксом `arch-`, чтобы Dolphin корректно отображал доступные приложения.
- Вносит изменения в конфигурацию `~/.config/hypr/hyprland.conf`, если их нет:
  - Устанавливает переменную окружения `XDG_MENU_PREFIX,arch-`.
  - Запускает скрипт `fix-dolphin-open-with.sh` один раз при старте сессии.
- Выполняет немедленную пересборку кеша.
- Перезапускает Dolphin, если он активно запущен.
- Выводит подсказку: после выполнения — **рекомендован перезапуск сессии Hyprland (релогин)** для надёжного применения изменений.

---

##  Как работает

Hyprland (в отличие от KDE/Plasma) иногда не прокачивает меню приложений для Dolphin автоматически. Установка `XDG_MENU_PREFIX` и пересборка кэша с помощью `kbuildsycoca6` решает проблему. Скрипт автоматизирует все шаги — от создания вспомогательного скрипта до применения настроек.

---

##  Как запустить

###  Локально

Скачай скрипт и запусти его:
```bash
curl -L https://raw.githubusercontent.com/svglan/dolphin/main/auto-install.sh -o auto-install.sh
chmod +x auto-install.sh
./auto-install.sh
