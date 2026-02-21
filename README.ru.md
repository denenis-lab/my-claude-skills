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

## Сторонние скиллы

| Скилл | Автор | Описание |
|-------|-------|---------|
| [superpowers](https://github.com/obra/superpowers) | Jesse Vincent | TDD, отладка, брейнсторминг, код-ревью, планирование |
| [data](https://github.com/anthropics/claude-code/tree/main/plugins) | Anthropic | SQL, визуализация данных, дашборды, статистика |

## Лицензия

MIT
