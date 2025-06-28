# 🚀 Инструкция по деплою Vesi на VM

## 📋 Требования

- Ubuntu 20.04+ или CentOS 8+
- Docker
- Make
- Git

## 🔧 Подготовка VM

### 1. Установка Docker

```bash
# Ubuntu/Debian
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER

# CentOS/RHEL
sudo yum install -y docker
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER
```

### 2. Установка Make

```bash
# Ubuntu/Debian
sudo apt update && sudo apt install -y make

# CentOS/RHEL
sudo yum install -y make
```

### 3. Перезагрузка сессии

```bash
# Выйдите и войдите заново или выполните:
newgrp docker
```

## 🚀 Быстрый деплой

### Вариант 1: Автоматический деплой (Рекомендуемый)

```bash
# Клонирование проекта
git clone <your-repo-url> /opt/vesi
cd /opt/vesi

# Сделать скрипт исполняемым
chmod +x deploy.sh

# Запуск деплоя
./deploy.sh production
```

### Вариант 2: Ручной деплой

```bash
# Клонирование проекта
git clone <your-repo-url> /opt/vesi
cd /opt/vesi

# Сборка и запуск
make build
make up

# Проверка статуса
make status
```

## 📊 Управление приложением

### Основные команды

```bash
# Просмотр статуса
make status

# Просмотр логов
make logs

# Просмотр последних 100 строк логов
make logs-tail

# Перезапуск приложения
make restart

# Проверка доступности
make health

# Остановка приложения
make stop

# Полное обновление
make update

# Очистка ресурсов
make clean
```

### Мониторинг

```bash
# Статус контейнера
docker ps

# Использование ресурсов
docker stats vesi-kazan

# Логи в реальном времени
docker logs -f vesi-kazan
```

## 🔧 Настройка

### Изменение порта

```bash
# Запуск на другом порту
APP_PORT=8080 make up
```

### Изменение версии

```bash
# Сборка с другой версией
VERSION=v1.0.0 make build
VERSION=v1.0.0 make up
```

### Переменные окружения

```bash
# Установка переменных окружения
export NUXT_APP_ENV=production
export NODE_ENV=production
make build
```

## 🛠 Устранение неполадок

### Приложение не запускается

```bash
# Проверка логов
make logs

# Проверка статуса контейнера
make status

# Перезапуск
make restart
```

### Проблемы с портами

```bash
# Проверка занятых портов
sudo netstat -tulpn | grep :80

# Остановка контейнера
make stop

# Запуск на другом порту
APP_PORT=8080 make up
```

### Очистка и пересборка

```bash
# Полная очистка
make clean

# Пересборка
make build
make up
```

## 🔒 Безопасность

### Firewall

```bash
# Открытие порта 80
sudo ufw allow 80/tcp

# Открытие порта 443 (для HTTPS)
sudo ufw allow 443/tcp
```

### SSL сертификат (опционально)

```bash
# Установка Certbot
sudo apt install certbot python3-certbot-nginx -y

# Получение сертификата
sudo certbot --nginx -d your-domain.com
```

## 📈 Масштабирование

### Добавление второго экземпляра

```bash
# Запуск второго экземпляра на другом порту
PROJECT_NAME=vesi-kazan-2 APP_PORT=8080 make up
```

### Настройка балансировщика нагрузки

```bash
# Установка Nginx как балансировщик
sudo apt install nginx -y

# Настройка конфигурации балансировщика
sudo nano /etc/nginx/sites-available/vesi-balancer
```

## 🔄 Обновление приложения

### Автоматическое обновление

```bash
# Полное обновление
make update
```

### Ручное обновление

```bash
# Остановка
make stop

# Очистка
make clean

# Сборка новой версии
make build

# Запуск
make up
```

## 📝 Логи и мониторинг

### Просмотр логов

```bash
# Все логи
make logs

# Последние 100 строк
make logs-tail

# Логи с временными метками
docker logs -t vesi-kazan
```

### Резервное копирование

```bash
# Создание резервной копии
make backup
```

## 🆘 Поддержка

При возникновении проблем:

1. Проверьте логи: `make logs`
2. Проверьте статус: `make status`
3. Проверьте доступность: `make health`
4. Перезапустите: `make restart`

## 📞 Контакты

Для получения поддержки обратитесь к разработчику проекта. 