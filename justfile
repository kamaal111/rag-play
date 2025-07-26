set export
set dotenv-load

PORT := "8000"

UV := "uv"
UVR := UV + " run"

DATABASE_USER := "rag-play-user"
DATABASE_PASSWORD := "secure-password"
DATABASE_HOST := "db"
DATABASE_PORT := "5432"
DATABASE_NAME := "rag_play_db"
DATABASE_SSLMODE := "disable"
DATABASE_DRIVER := "psycopg"
DATABASE_URL := "postgresql+" + DATABASE_DRIVER + "://" + DATABASE_USER + ":" + DATABASE_PASSWORD + "@" + DATABASE_HOST + ":" + DATABASE_PORT / DATABASE_NAME

UV_LINK_MODE := "copy"

# List available commands
default:
    just --list --unsorted

# Run in dev mode
dev: prepare
    {{ UVR }} src/rag/main.py

# Lint code
lint:
    {{ UVR }} ruff check .

# Lint and fix any issues that can be fixed automatically
lint-fix:
    {{ UVR }} ruff check . --fix

# Type check
type-check:
    {{ UVR }} mypy .

# Format code
format:
    {{ UVR }} ruff format .

# Quality checks
quality: lint type-check format

# Prepare to run project
prepare: install-python-modules

# Install Python modules
install-python-modules:
    {{ UV }} sync

# Bootstrap project
bootstrap: prepare setup-pre-commit

# Set up dev container. This step runs after building the dev container
post-dev-container-create: bootstrap

[private]
setup-pre-commit:
    {{ UVR }} pre-commit
