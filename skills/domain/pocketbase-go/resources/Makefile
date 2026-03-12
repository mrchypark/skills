PB_URL ?= http://127.0.0.1:8090
PB_ADMIN_EMAIL ?= admin@example.com
PB_ADMIN_PASSWORD ?= admin1234
PB_DIR ?= .pb
PB_BIN ?= $(PB_DIR)/pocketbase
PB_VERSION ?= 0.36.0
PBC_GEN_VERSION ?= v0.3.8
SCHEMA_FILE ?= pb_schema.json
MODELS_OUT ?= models/models.gen.go
MODELS_PKG ?= models

PB_MIGRATIONS_DIR ?= ./pb_migrations
PB_HOOKS_DIR ?= ./pb_hooks

.PHONY: all init serve migrate dump codegen sync clean

all: serve

init:
	@echo "Installing PocketBase..."
	@mkdir -p $(PB_DIR)
	@if [ ! -f "$(PB_BIN)" ]; then \
		OS=$$(uname -s | tr '[:upper:]' '[:lower:]'); \
		ARCH=$$(uname -m); \
		case $$ARCH in \
			x86_64) ARCH=amd64 ;; \
			arm64|aarch64) ARCH=arm64 ;; \
			*) echo "Unsupported arch: $$ARCH"; exit 1 ;; \
		esac; \
		echo "Detected OS: $$OS, Arch: $$ARCH"; \
		curl -L -o "$(PB_DIR)/pb.zip" "https://github.com/pocketbase/pocketbase/releases/download/v$(PB_VERSION)/pocketbase_$(PB_VERSION)_$${OS}_$${ARCH}.zip"; \
		unzip -o "$(PB_DIR)/pb.zip" -d "$(PB_DIR)"; \
		rm "$(PB_DIR)/pb.zip"; \
		chmod +x "$(PB_BIN)"; \
	fi
	@echo "Bootstrapping Admin..."
	@$(PB_BIN) superuser create $(PB_ADMIN_EMAIL) $(PB_ADMIN_PASSWORD) || echo "Admin might already exist."
	@echo "Creating pb_hooks..."
	@mkdir -p pb_hooks && touch pb_hooks/.gitkeep
	@echo "Installing pbc-gen $(PBC_GEN_VERSION)..."
	@go install github.com/mrchypark/pocketbase-client/cmd/pbc-gen@$(PBC_GEN_VERSION)
	@echo "Environment initialized."

serve:
	$(PB_BIN) serve --http 127.0.0.1:8090 --dir $(PB_DIR)/pb_data --migrationsDir $(PB_MIGRATIONS_DIR) --hooksDir $(PB_HOOKS_DIR)

migrate:
	python3 pb_migrate_ops.py apply --url $(PB_URL) --email $(PB_ADMIN_EMAIL) --password $(PB_ADMIN_PASSWORD) --schema $(SCHEMA_FILE)

dump:
	python3 pb_migrate_ops.py dump --url $(PB_URL) --email $(PB_ADMIN_EMAIL) --password $(PB_ADMIN_PASSWORD) --schema $(SCHEMA_FILE)

codegen:
	@mkdir -p $(dir $(MODELS_OUT))
	pbc-gen -schema $(SCHEMA_FILE) -path $(MODELS_OUT) -pkgname $(MODELS_PKG)

sync: dump codegen
	@echo "Synced schema from DB and generated code."

clean:
	rm -rf $(PB_DIR)
