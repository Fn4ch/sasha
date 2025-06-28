#!/bin/bash

# Скрипт для установки зависимостей на VM
# Использование: ./setup-vm.sh

set -e

# Цвета для вывода
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
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

log_step() {
    echo -e "${BLUE}[STEP]${NC} $1"
}

# Проверка на root права
if [[ $EUID -eq 0 ]]; then
   log_error "Не запускайте этот скрипт от root пользователя!"
   exit 1
fi

log_info "Начинаем установку зависимостей для Vesi..."

# Определение дистрибутива
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
else
    log_error "Не удалось определить дистрибутив"
    exit 1
fi

log_step "Обнаружен дистрибутив: $OS $VER"

# Обновление системы
log_step "Обновление системы..."
if [[ "$OS" == *"Ubuntu"* ]] || [[ "$OS" == *"Debian"* ]]; then
    sudo apt update && sudo apt upgrade -y
elif [[ "$OS" == *"CentOS"* ]] || [[ "$OS" == *"Red Hat"* ]]; then
    sudo yum update -y
else
    log_warn "Неизвестный дистрибутив, пропускаем обновление системы"
fi

# Установка Docker
log_step "Установка Docker..."
if command -v docker &> /dev/null; then
    log_info "Docker уже установлен"
else
    if [[ "$OS" == *"Ubuntu"* ]] || [[ "$OS" == *"Debian"* ]]; then
        curl -fsSL https://get.docker.com -o get-docker.sh
        sudo sh get-docker.sh
        sudo usermod -aG docker $USER
        rm get-docker.sh
    elif [[ "$OS" == *"CentOS"* ]] || [[ "$OS" == *"Red Hat"* ]]; then
        sudo yum install -y docker
        sudo systemctl start docker
        sudo systemctl enable docker
        sudo usermod -aG docker $USER
    else
        log_error "Не удалось установить Docker на данном дистрибутиве"
        exit 1
    fi
fi

# Установка Make
log_step "Установка Make..."
if command -v make &> /dev/null; then
    log_info "Make уже установлен"
else
    if [[ "$OS" == *"Ubuntu"* ]] || [[ "$OS" == *"Debian"* ]]; then
        sudo apt install -y make
    elif [[ "$OS" == *"CentOS"* ]] || [[ "$OS" == *"Red Hat"* ]]; then
        sudo yum install -y make
    else
        log_error "Не удалось установить Make на данном дистрибутиве"
        exit 1
    fi
fi

# Установка curl (для health check)
log_step "Установка curl..."
if command -v curl &> /dev/null; then
    log_info "curl уже установлен"
else
    if [[ "$OS" == *"Ubuntu"* ]] || [[ "$OS" == *"Debian"* ]]; then
        sudo apt install -y curl
    elif [[ "$OS" == *"CentOS"* ]] || [[ "$OS" == *"Red Hat"* ]]; then
        sudo yum install -y curl
    fi
fi

# Установка Git
log_step "Установка Git..."
if command -v git &> /dev/null; then
    log_info "Git уже установлен"
else
    if [[ "$OS" == *"Ubuntu"* ]] || [[ "$OS" == *"Debian"* ]]; then
        sudo apt install -y git
    elif [[ "$OS" == *"CentOS"* ]] || [[ "$OS" == *"Red Hat"* ]]; then
        sudo yum install -y git
    fi
fi

# Настройка firewall (опционально)
log_step "Настройка firewall..."
if command -v ufw &> /dev/null; then
    log_info "Настройка UFW..."
    sudo ufw allow 80/tcp
    sudo ufw allow 443/tcp
    sudo ufw allow 22/tcp
    sudo ufw --force enable
elif command -v firewall-cmd &> /dev/null; then
    log_info "Настройка firewalld..."
    sudo firewall-cmd --permanent --add-port=80/tcp
    sudo firewall-cmd --permanent --add-port=443/tcp
    sudo firewall-cmd --permanent --add-port=22/tcp
    sudo firewall-cmd --reload
else
    log_warn "Firewall не обнаружен, пропускаем настройку"
fi

# Создание директории для проекта
log_step "Создание директории проекта..."
sudo mkdir -p /opt/vesi
sudo chown $USER:$USER /opt/vesi

# Проверка установки
log_step "Проверка установки..."
if command -v docker &> /dev/null; then
    log_info "✅ Docker установлен"
else
    log_error "❌ Docker не установлен"
    exit 1
fi

if command -v make &> /dev/null; then
    log_info "✅ Make установлен"
else
    log_error "❌ Make не установлен"
    exit 1
fi

if command -v git &> /dev/null; then
    log_info "✅ Git установлен"
else
    log_error "❌ Git не установлен"
    exit 1
fi

# Проверка группы docker
if groups $USER | grep -q docker; then
    log_info "✅ Пользователь в группе docker"
else
    log_warn "⚠️ Пользователь не в группе docker. Выполните: newgrp docker"
fi

log_info "🎉 Установка зависимостей завершена!"
log_info ""
log_info "Следующие шаги:"
echo "1. Перезагрузите сессию или выполните: newgrp docker"
echo "2. Клонируйте проект: git clone <repo> /opt/vesi"
echo "3. Перейдите в директорию: cd /opt/vesi"
echo "4. Запустите деплой: ./deploy.sh production"
echo ""
log_info "Для получения помощи: cat DEPLOY.md" 