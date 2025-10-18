# Автоматическое чтение переменных из .env файла
ifneq (,$(wildcard .env))
    include .env
    export
    $(info ✅ Загружены переменные из .env файла)
else
    $(warning ⚠️  Файл .env не найден. Создайте его с необходимыми переменными.)
endif

.PHONY: env-example env-show check-env build all up run down push pull clean logs restart status health

# Переменные с значениями по умолчанию
APP_PORT ?= 80
REGISTRY_IMAGE ?= vesi
PROJECT_NAME ?= vesi-kazan
VERSION ?= latest
VITE_S3_URL ?= 
TELEGRAM_BOT_TOKEN ?= 
TELEGRAM_CHAT_ID ?= 

# Создание примера .env файла
env-example:
	@echo "=== Создание примера .env файла ==="
	@if [ ! -f .env ]; then \
		echo "# Конфигурация приложения" > .env; \
		echo "VITE_S3_URL=https://your-s3-bucket.s3.amazonaws.com" >> .env; \
		echo "" >> .env; \
		echo "# Telegram Bot Configuration" >> .env; \
		echo "TELEGRAM_BOT_TOKEN=your_bot_token_here" >> .env; \
		echo "TELEGRAM_CHAT_ID=your_chat_id_here" >> .env; \
		echo "" >> .env; \
		echo "# Docker Configuration" >> .env; \
		echo "APP_PORT=80" >> .env; \
		echo "REGISTRY_IMAGE=vesi" >> .env; \
		echo "PROJECT_NAME=vesi-kazan" >> .env; \
		echo "VERSION=latest" >> .env; \
		echo "✅ Создан файл .env с примерами"; \
		echo "📝 Отредактируйте .env файл с вашими значениями"; \
	else \
		echo "⚠️  Файл .env уже существует"; \
	fi

# Проверка обязательных переменных
check-env:
	@echo "=== Проверка переменных окружения ==="
	@if [ -z "$(VITE_S3_URL)" ]; then \
		echo "❌ VITE_S3_URL не установлен"; \
		exit 1; \
	fi
	@if [ -z "$(TELEGRAM_BOT_TOKEN)" ]; then \
		echo "❌ TELEGRAM_BOT_TOKEN не установлен"; \
		exit 1; \
	fi
	@if [ -z "$(TELEGRAM_CHAT_ID)" ]; then \
		echo "❌ TELEGRAM_CHAT_ID не установлен"; \
		exit 1; \
	fi
	@echo "✅ Все обязательные переменные установлены"

# Сборка Docker-образа
build: check-env
	@echo "=== Сборка Docker-образа ==="
	@echo "Образ: $(REGISTRY_IMAGE):$(VERSION)"
	@echo "VITE_S3_URL: $(VITE_S3_URL)"
	@echo "TELEGRAM_BOT_TOKEN: $(if $(TELEGRAM_BOT_TOKEN),установлен,не установлен)"
	@echo "TELEGRAM_CHAT_ID: $(if $(TELEGRAM_CHAT_ID),установлен,не установлен)"
	docker build \
		--build-arg VITE_S3_URL="$(VITE_S3_URL)" \
		--build-arg TELEGRAM_BOT_TOKEN="$(TELEGRAM_BOT_TOKEN)" \
		--build-arg TELEGRAM_CHAT_ID="$(TELEGRAM_CHAT_ID)" \
		-t $(REGISTRY_IMAGE):$(VERSION) .

# Загрузка образа в реестр
push:
	docker push $(REGISTRY_IMAGE):$(VERSION)

# Скачивание образа из реестра
pull:
	docker pull $(REGISTRY_IMAGE):$(VERSION)

# Запуск контейнера с улучшениями
up: check-env down
	@echo "=== Запуск контейнера ==="
	@echo "Контейнер: $(PROJECT_NAME)"
	@echo "Образ: $(REGISTRY_IMAGE):$(VERSION)"
	docker run --name $(PROJECT_NAME) \
		-p 80:80 \
		-p 443:443 \
		-v /home/user1/letsencrypt:/etc/letsencrypt \
		-v /home/user1/letsencrypt-lib:/var/lib/letsencrypt \
		-v /home/user1/public:/public \
		-e VITE_S3_URL="$(VITE_S3_URL)" \
		-e TELEGRAM_BOT_TOKEN="$(TELEGRAM_BOT_TOKEN)" \
		-e TELEGRAM_CHAT_ID="$(TELEGRAM_CHAT_ID)" \
		--restart unless-stopped \
		--detach \
		$(REGISTRY_IMAGE):$(VERSION)
	@echo "✅ Контейнер запущен"
# Остановка контейнера
stop:
	docker stop $(PROJECT_NAME) 2>/dev/null || true
	docker container rm $(PROJECT_NAME) 2>/dev/null || true

# Запуск контейнера в интерактивном режиме (для отладки)
run: check-env
	@echo "=== Запуск контейнера в режиме отладки ==="
	docker run --name $(PROJECT_NAME) \
	-p 80:80 -p 443:443 \
	-v /home/user1/letsencrypt:/etc/letsencrypt \
	-v /home/user1/letsencrypt-lib:/var/lib/letsencrypt \
	-v /home/user1/public:/public \
	-e VITE_S3_URL="$(VITE_S3_URL)" \
	-e TELEGRAM_BOT_TOKEN="$(TELEGRAM_BOT_TOKEN)" \
	-e TELEGRAM_CHAT_ID="$(TELEGRAM_CHAT_ID)" \
	--restart unless-stopped \
	-d $(REGISTRY_IMAGE):$(VERSION)

# Отображение текущих переменных окружения
env-show:
	@echo "=== Текущие переменные окружения ==="
	@echo "VITE_S3_URL: $(VITE_S3_URL)"
	@echo "TELEGRAM_BOT_TOKEN: $(if $(TELEGRAM_BOT_TOKEN),установлен,не установлен)"
	@echo "TELEGRAM_CHAT_ID: $(if $(TELEGRAM_CHAT_ID),установлен,не установлен)"
	@echo "APP_PORT: $(APP_PORT)"
	@echo "REGISTRY_IMAGE: $(REGISTRY_IMAGE)"
	@echo "PROJECT_NAME: $(PROJECT_NAME)"
	@echo "VERSION: $(VERSION)"

certbot-init:
	# Выпуск сертификата через webroot без остановки контейнера
	docker run --rm \
		-v /home/user1/letsencrypt:/etc/letsencrypt \
		-v /home/user1/letsencrypt-lib:/var/lib/letsencrypt \
		-v /home/user1/public:/public \
		certbot/certbot certonly --webroot -w /public \
		-d vesy16.ru -d www.vesy16.ru \
		--email cfrios2002@yandex.ru --agree-tos --no-eff-email --force-renewal --non-interactive

# Просмотр логов
logs:
	docker logs -f $(PROJECT_NAME)

# Просмотр логов за последние 100 строк
logs-tail:
	docker logs --tail=100 $(PROJECT_NAME)

# Перезапуск контейнера
restart: stop up

# Статус контейнера
status:
	@echo "=== Статус контейнера ==="
	@docker ps -a --filter name=$(PROJECT_NAME) --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
	@echo ""
	@echo "=== Использование ресурсов ==="
	@docker stats $(PROJECT_NAME) --no-stream --format "table {{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}"

# Health check
health:
	@echo "Проверка доступности приложения..."
	@if curl -f -s http://localhost:$(APP_PORT) > /dev/null; then \
		echo "✅ Приложение доступно"; \
	else \
		echo "❌ Приложение недоступно"; \
		exit 1; \
	fi

# Полная очистка всех ресурсов (контейнеры, образы)
clean:
	docker stop $(PROJECT_NAME) 2>/dev/null || true
	docker container rm $(PROJECT_NAME) 2>/dev/null || true
	docker rmi $(REGISTRY_IMAGE):$(VERSION) || true

# Очистка всех неиспользуемых ресурсов Docker
clean-all:
	docker system prune -f
	docker volume prune -f

# Создание резервной копии данных
backup:
	@echo "Создание резервной копии..."
	@mkdir -p backups
	@docker cp $(PROJECT_NAME):/app/public ./backups/public_$(shell date +%Y%m%d_%H%M%S) 2>/dev/null || true
	@echo "Резервная копия создана в папке backups/"

# Обновление приложения (полный цикл)
update: stop clean build up
	@echo "✅ Приложение обновлено!"



# Информация о проекте
info:
	@echo "=== Информация о проекте ==="
	@echo "Название: $(PROJECT_NAME)"
	@echo "Образ: $(REGISTRY_IMAGE):$(VERSION)"
	@echo "Порт: $(APP_PORT)"
	@echo "URL: http://localhost:$(APP_PORT)"
	@echo ""
	@echo "=== Переменные окружения ==="
	@echo "VITE_S3_URL: $(if $(VITE_S3_URL),установлен,не установлен)"
	@echo "TELEGRAM_BOT_TOKEN: $(if $(TELEGRAM_BOT_TOKEN),установлен,не установлен)"
	@echo "TELEGRAM_CHAT_ID: $(if $(TELEGRAM_CHAT_ID),установлен,не установлен)"
	@echo ""
	@echo "=== Доступные команды ==="
	@echo "make env-example - создать пример .env файла"
	@echo "make env-show    - показать текущие переменные"
	@echo "make check-env   - проверить переменные окружения"
	@echo "make build       - сборка образа"
	@echo "make up          - запуск приложения"
	@echo "make stop        - остановка приложения"
	@echo "make restart     - перезапуск приложения"
	@echo "make logs        - просмотр логов"
	@echo "make status      - статус контейнера"
	@echo "make health      - проверка доступности"
	@echo "make update      - полное обновление"
	@echo "make clean       - очистка ресурсов"