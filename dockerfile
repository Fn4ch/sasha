FROM node:24-alpine AS base
WORKDIR /app

FROM base AS deps
RUN corepack enable
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile --production

FROM base AS build
ARG VITE_S3_URL
ARG TELEGRAM_BOT_TOKEN
ARG TELEGRAM_CHAT_ID
ENV VITE_S3_URL=$VITE_S3_URL
ENV TELEGRAM_BOT_TOKEN=$TELEGRAM_BOT_TOKEN
ENV TELEGRAM_CHAT_ID=$TELEGRAM_CHAT_ID
RUN corepack enable
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile
COPY . .
RUN yarn build

FROM base AS production
WORKDIR /app

RUN apk add --no-cache nginx && \
    mkdir -p /run/nginx && \
    chown -R nginx:nginx /run/nginx

# Копирование файлов приложения
COPY --from=deps /app/node_modules ./node_modules
COPY --from=build /app/.output ./.output
COPY --from=build /app/public ./public

COPY nginx.conf /etc/nginx/http.d/default.conf

RUN chown -R nginx:nginx /app && \
    chmod -R 755 /app && \
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80
EXPOSE 443

CMD ["sh", "-c", "node .output/server/index.mjs & exec nginx -g 'daemon off;'"]