#!/bin/bash

# Скрипт для деплоя Vesi на VM
# Использование: ./deploy.sh [production|staging]

set -e

# Цвета для вывода
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Функции для логирования
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Проверка аргументов
ENVIRONMENT=${1:-production}
if [[ "$ENVIRONMENT" != "production" && "$ENVIRONMENT" != "staging" ]]; then
    log_error "Неверное окружение. Используйте: production или staging"
    exit 1
fi

log_info "Начинаем деплой в окружении: $ENVIRONMENT"

# Проверка наличия Docker
if ! command -v docker &> /dev/null; then
    log_error "Docker не установлен. Установите Docker и повторите попытку."
    exit 1
fi

# Проверка наличия Make
if ! command -v make &> /dev/null; then
    log_error "Make не установлен. Установите Make и повторите попытку."
    exit 1
fi

# Остановка существующего контейнера
log_info "Останавливаем существующий контейнер..."
make stop || true

# Очистка старых образов
log_info "Очищаем старые образы..."
make clean || true

# Сборка нового образа
log_info "Собираем новый Docker образ..."
export NUXT_APP_ENV=$ENVIRONMENT
make build

# Запуск контейнера
log_info "Запускаем контейнер..."
make up

# Проверка статуса
log_info "Проверяем статус контейнера..."
sleep 5
if docker ps | grep -q "vesi-kazan"; then
    log_info "✅ Контейнер успешно запущен!"
    log_info "🌐 Приложение доступно по адресу: http://localhost:80"
else
    log_error "❌ Контейнер не запущен. Проверьте логи:"
    make logs
    exit 1
fi

# Проверка health check
log_info "Проверяем доступность приложения..."
if curl -f -s http://localhost:80 > /dev/null; then
    log_info "✅ Приложение отвечает на запросы!"
else
    log_warn "⚠️ Приложение не отвечает. Проверьте логи:"
    make logs
fi

log_info "🎉 Деплой завершен успешно!"
log_info "Команды для управления:"
echo "  make logs     - просмотр логов"
echo "  make stop     - остановка приложения"
echo "  make restart  - перезапуск приложения"
echo "  make clean    - очистка ресурсов" 