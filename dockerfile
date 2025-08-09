FROM node:24-alpine AS base
WORKDIR /app

# Зависимости
FROM base AS deps
RUN corepack enable
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile --production

# Сборка
FROM base AS build
ARG NUXT_APP_ENV
ENV NUXT_APP_ENV=$NUXT_APP_ENV
ARG VITE_S3_URL
ENV VITE_S3_URL=$VITE_S3_URL
RUN corepack enable
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile
COPY . .
RUN yarn build

# Финальный образ
FROM base AS production
WORKDIR /app

ARG VITE_S3_URL
ENV VITE_S3_URL=$VITE_S3_URL

# Установка Nginx, Certbot, cron
RUN apk add --no-cache nginx certbot certbot-nginx openrc && \
    mkdir -p /run/nginx /var/www/certbot && \
    chown -R node:node /var/www/certbot && \
    chown -R node:node /etc/letsencrypt 2>/dev/null || true && \
    mkdir -p /etc/nginx/conf.d

# Копируем артефакты
COPY --from=deps /app/node_modules ./node_modules
COPY --from=build /app/.output ./.output
COPY --from=build /app/public ./public

# Копируем Nginx конфиг
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Копируем entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Права
RUN chown -R node:node /app && \
    chown -R node:node /run/nginx

# Переключаемся на пользователя node (безопасность)
USER node

EXPOSE 80
EXPOSE 443

HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

CMD ["/entrypoint.sh"]