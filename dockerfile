FROM node:24-alpine AS base
WORKDIR /app

FROM base AS deps
RUN corepack enable
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile --production

FROM base AS build
ARG NUXT_APP_ENV
ENV NUXT_APP_ENV=$NUXT_APP_ENV
RUN corepack enable
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile
COPY . .
RUN yarn build

FROM base AS production
WORKDIR /app

# Установка необходимых пакетов
RUN apk add --no-cache nginx curl && \
    mkdir -p /run/nginx && \
    chown -R nginx:nginx /run/nginx

# Копирование файлов приложения
COPY --from=deps /app/node_modules ./node_modules
COPY --from=build /app/.output ./.output
COPY --from=build /app/public ./public

# Копирование конфига Nginx
COPY nginx.conf.template /etc/nginx/http.d/default.conf

# Создание скрипта запуска
RUN echo '#!/bin/sh\n\
# Запуск Node.js приложения в фоне\n\
node .output/server/index.mjs &\n\
NODE_PID=$$\n\
\n\
# Ожидание запуска приложения\n\
echo "Ожидание запуска приложения..."\n\
sleep 3\n\
\n\
# Проверка доступности приложения\n\
until curl -f http://localhost:24678 > /dev/null 2>&1; do\n\
    echo "Ожидание готовности приложения..."\n\
    sleep 2\n\
done\n\
\n\
echo "Приложение готово, запуск Nginx..."\n\
\n\
# Функция для корректного завершения\n\
cleanup() {\n\
    echo "Получен сигнал завершения..."\n\
    kill $NODE_PID 2>/dev/null || true\n\
    nginx -s quit\n\
    exit 0\n\
}\n\
\n\
# Обработка сигналов\n\
trap cleanup SIGTERM SIGINT\n\
\n\
# Запуск Nginx\n\
exec nginx -g "daemon off;"' > /app/start.sh && \
    chmod +x /app/start.sh

# Настройка прав
RUN chown -R nginx:nginx /app && \
    chmod -R 755 /app && \
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD curl -f http://localhost:80/ || exit 1

# Команда запуска
CMD ["/app/start.sh"]