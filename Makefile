.PHONY: env build all up run down push pull clean logs restart status health

APP_PORT ?= 80
REGISTRY_IMAGE ?= vesi
PROJECT_NAME ?= vesi-kazan
VERSION ?= latest

# Сборка Docker-образа
build:
	docker build -t $(REGISTRY_IMAGE):$(VERSION) .

# Загрузка образа в реестр
push:
	docker push $(REGISTRY_IMAGE):$(VERSION)

# Скачивание образа из реестра
pull:
	docker pull $(REGISTRY_IMAGE):$(VERSION)

# Запуск контейнера с улучшениями
up: down
	docker run --name $(PROJECT_NAME) \
	-p 127.0.0.1:$(APP_PORT):80 \
	--restart unless-stopped \
	--detach \
	$(REGISTRY_IMAGE):$(VERSION)

# Остановка контейнера
stop:
	docker stop $(PROJECT_NAME) 2>/dev/null || true
	docker container rm $(PROJECT_NAME) 2>/dev/null || true

# Запуск контейнера в интерактивном режиме (для отладки)
run:
	docker run --rm -it \
	-p 127.0.0.1:$(APP_PORT):80 \
	$(REGISTRY_IMAGE):$(VERSION)

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
	@echo "=== Доступные команды ==="
	@echo "make build      - сборка образа"
	@echo "make up         - запуск приложения"
	@echo "make stop       - остановка приложения"
	@echo "make restart    - перезапуск приложения"
	@echo "make logs       - просмотр логов"
	@echo "make status     - статус контейнера"
	@echo "make health     - проверка доступности"
	@echo "make update     - полное обновление"
	@echo "make clean      - очистка ресурсов"