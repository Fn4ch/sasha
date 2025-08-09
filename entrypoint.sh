#!/bin/sh
set -e

DOMAIN="vesy16.ru"
EMAIL="admin@vesy16.ru"
WEBROOT="/var/www/certbot"
NGINX_CONF="/etc/nginx/conf.d/default.conf"
CERT_DIR="/etc/letsencrypt/live/$DOMAIN"

# Функция: ожидание готовности сервиса
wait_for() {
  echo "Ожидание $1..."
  while ! nc -z localhost $2; do sleep 1; done
  echo "$1 доступен"
}

echo "🚀 Запуск entrypoint.sh" >&2
echo "DOMAIN=$DOMAIN" >&2

# Проверка Nginx
if ! nginx -t; then
  echo "❌ Ошибка конфигурации Nginx" >&2
  exit 1
fi

echo "✅ Nginx конфиг OK" >&2

# Запуск Nuxt
echo "🔥 Запуск Nuxt..." >&2
node .output/server/index.mjs &

# Запуск Nginx
echo "🌐 Запуск Nginx..." >&2
exec nginx -g "daemon off;"

# === Шаг 1: Запускаем временный HTTP-сервер для /acme-challenge ===
echo "🚀 Запуск временного HTTP-сервера для получения SSL..."

# Убедимся, что конфиг только для HTTP (без SSL)
cat > /etc/nginx/conf.d/acme.conf << 'EOF'
server {
    listen 80;
    server_name vesy16.ru www.vesy16.ru;

    location /.well-known/acme-challenge/ {
        root /var/www/certbot;
        try_files $uri =403;
    }

    location / {
        return 404;
    }
}
EOF

# Запускаем Nginx с acme-конфигом
nginx -c /etc/nginx/acme.conf -g "daemon off;" &
wait_for "acme Nginx" 80

# === Шаг 2: Получаем сертификат, если его нет ===
if [ ! -d "$CERT_DIR" ]; then
  echo "📝 Получаем SSL-сертификат для $DOMAIN..."

  certbot certonly --webroot -w $WEBROOT \
    -d $DOMAIN \
    -d www.$DOMAIN \
    --email $EMAIL \
    --agree-tos \
    --no-eff-email \
    --non-interactive \
    || {
      echo "❌ Ошибка получения сертификата. Проверь домен и порт 80."
      exit 1
    }

  echo "✅ Сертификат получен!"
else
  echo "✅ Сертификат уже существует: $CERT_DIR"
fi

# Останавливаем временный Nginx
kill %1 || true
sleep 2

# === Шаг 3: Запускаем основной Nginx + Nuxt ===

# Добавляем cron для автообновления
echo "0 12 * * * certbot renew --quiet --post-hook 'nginx -s reload'" | crontab -
crond

# Запускаем Nuxt сервер
echo "🔥 Запуск Nuxt SSR..."
node .output/server/index.mjs &

# Запускаем основной Nginx
echo "🌐 Запуск основного Nginx (с HTTPS)..."
exec nginx -c $NGINX_CONF -g "daemon off;"