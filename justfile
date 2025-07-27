set export
set dotenv-load

REQ := "http"

UV := "uv"
UVR := UV + " run"

UV_LINK_MODE := "copy"

# List available commands
default:
    just --list --unsorted

# Ping vector store
ping-vector-store:
    #!/bin/zsh

    if [ -v $DATABASE_HOST ]
    then
        {{ REQ }} :8000/api/v2/heartbeat
    else
        {{ REQ }} $DATABASE_HOST:8000/api/v2/heartbeat
    fi

# Lint code
lint:
    {{ UVR }} ruff check .

# Lint and fix any issues that can be fixed automatically
lint-fix:
    {{ UVR }} ruff check . --fix

# Format code
format:
    {{ UVR }} ruff format .

# Quality checks
quality: lint format

# Prepare to run project
prepare: install-modules

# Install Python modules
install-modules:
    {{ UV }} sync

# Bootstrap project
bootstrap: prepare

# Set up dev container. This step runs after building the dev container
post-dev-container-create: bootstrap
