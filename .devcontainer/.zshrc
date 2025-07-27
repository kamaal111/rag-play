export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

. $ZSH/oh-my-zsh.sh
. "$HOME/.cargo/env"

if command -v atuin > /dev/null 2>&1
then
    eval "$(atuin init zsh)"
fi

export PATH="$PATH:/root/.local/bin"

alias exa=eza

export DATABASE_HOST="vector_store"
