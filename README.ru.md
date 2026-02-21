# Мои скиллы для Claude Code

Коллекция кастомных скиллов и ссылки на сторонние скиллы, которые я использую с [Claude Code](https://docs.anthropic.com/en/docs/claude-code).

## Кастомные скиллы

### [screenshot](./screenshot/)

Монитор буфера обмена — автоматически сохраняет скриншоты и делает их доступными через команду `/screenshot`.

**Как работает:**
- Фоновый демон следит за буфером обмена (каждую секунду)
- Когда появляется новое изображение — сохраняет в `~/Screenshots` как PNG
- Claude Code читает и описывает скриншоты по запросу

**Быстрая установка:**
```bash
brew install pngpaste
cd screenshot && bash scripts/install.sh
```

Подробнее в [screenshot/README.md](./screenshot/README.md).

## Советы

### `lfg` — запуск Claude Code в автономном режиме

Shell-алиас для запуска Claude Code с `--dangerously-skip-permissions` (без подтверждений). Идея от [Сергея Риса](https://github.com/serejaris/ris-claude-code) и его воркфлоу для Claude Code.

Добавь в `~/.zshrc`:

```bash
alias lfg="claude --dangerously-skip-permissions"
```

Потом просто набери `lfg` в директории проекта — Claude Code стартует в полностью автономном режиме.

> **Внимание:** Пропускает все запросы на подтверждение. Используй только в доверенном окружении — Claude будет читать, писать и выполнять команды без вопросов.

## Сторонние скиллы

| Скилл | Автор | Описание |
|-------|-------|---------|
| [superpowers](https://github.com/obra/superpowers) | Jesse Vincent | TDD, отладка, брейнсторминг, код-ревью, планирование |
| [data](https://github.com/anthropics/claude-code/tree/main/plugins) | Anthropic | SQL, визуализация данных, дашборды, статистика |
| [macos-fixer](https://github.com/serejaris/ris-claude-code) | Сергей Рис | Диагностика памяти macOS, траблшутинг производительности |
| [git-workflow-manager](https://github.com/serejaris/ris-claude-code) | Сергей Рис | Conventional commits, семантическое версионирование, changelogs |

## Лицензия

MIT
