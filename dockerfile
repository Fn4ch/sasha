FROM node:24-alpine AS base
WORKDIR /app

FROM base AS deps
RUN corepack enable
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile --production

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

FROM base AS production
WORKDIR /app

ARG VITE_S3_URL
ENV VITE_S3_URL=$VITE_S3_URL
RUN apk add --no-cache nginx curl && \
    mkdir -p /run/nginx && \
    chown -R nginx:nginx /run/nginx

COPY --from=deps /app/node_modules ./node_modules
COPY --from=build /app/.output ./.output
COPY --from=build /app/public ./public

COPY nginx.conf.template /etc/nginx/http.d/default.conf

EXPOSE 80

CMD ["sh", "-c", "node .output/server/index.mjs & exec nginx -g 'daemon off;'"]
# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD curl -f http://localhost:80/ || exit 1