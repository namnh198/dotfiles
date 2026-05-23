export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"
export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:\
*.tar=01;31:*.zip=01;31:*.7z=01;31:*.rar=01;31:*.gz=01;31:\
*.txt=00;37:*.md=01;38;5;156:\
*.js=01;38;5;221:*.jsx=01;38;5;221:*.ts=01;38;5;111:*.tsx=01;38;5;111:\
*.html=01;38;5;111:*.css=01;38;5;115:*.scss=01;38;5;115:\
*.jpg=01;35:*.png=01;35:*.svg=01;35:*.ico=01;35:\
*.yaml=01;38;5;215:*.yml=01;38;5;215:*.toml=01;38;5;147:*.xml=01;38;5;115:*.json=01;38;5;115:\
*.sql=01;38;5;111:*.csv=01;38;5;115:*.pdf=01;31:\
*rc=01;38;5;147:*_profile=01;38;5;147:*_history=00;38;5;245:*.DS_Store=00;38;5;245:*.zcompdump*=00;38;5;245:\
*.sh=01;38;5;147:*.bash=01;38;5;147:*.zsh=01;38;5;147:*.fish=01;38;5;147:*.alias=01;38;5;147:\
*.gitignore=00;38;5;245:.git=01;38;5;203:Dockerfile=01;38;5;111:docker-compose.yml=01;38;5;215:"
export SSH_AUTH_SOCK="$HOME/.bitwarden-ssh-agent.sock"

if [[ -f "/opt/homebrew/bin/brew" ]]; then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# installing zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# installing starship
zinit ice as"command" from"gh-r" \
  atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
  atpull"%atclone" src"init.zsh"
zinit light starship/starship

export EDITOR="nvim"
export VISUAL="nvim"
export BUN_INSTALL="${XDG_DATA_HOME}/bun"
export BUN_INSTALL_CACHE_DIR="${XDG_DATA_HOME}/bun/cache"
export GOPATH="${XDG_DATA_HOME}/go"
export BAT_THEME="Catppuccin Mocha"
export N_PREFIX="${XDG_DATA_HOME}/n"
export PATH="$PATH:$N_PREFIX/bin"

zinit wait lucid light-mode for \
  atinit"zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' \
    zsh-users/zsh-completions

# Add snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

autoload -Uz compinit && compinit

zinit cdreplay -q

# History
HISTFILE="${XDG_DATA_HOME}/zsh/history"
HISTSIZE=50000
SAVEHIST=$HISTSIZE
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Keybindings
bindkey -e
bindkey '^[[A' history-search-backward
bindkey '^p' history-search-backward
bindkey '^[[B' history-search-forward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

eval "$(zoxide init zsh --cmd cd)"

# Aliases
alias c=clear
alias python=python3
alias pip=pip3
alias g=git
alias lz=lazygit
alias tm=tmux
alias ta='tmux attach'
alias oc="opencode"
alias cat='bat --paging=never --color=always'
alias eza='eza --icons=always --color=always --group-directories-first --header'
alias la='eza -a'
alias ll='eza -la'
alias l="eza -la"
alias ls=eza
alias lt='eza --tree'
alias vimdiff='nvim -d'
alias vim='nvim'
alias vi='nvim'
alias ncf='cd ~/.config/nvim; nvim .'

export FZF_TMUX=true
export FZF_CTRL_T_COMMAND="fd --type f --hidden"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always --group-directories-first {} | head -200'"
export FZF_ALT_C_COMMAND="fd --type d --hidden"

zinit snippet https://raw.githubusercontent.com/catppuccin/fzf/refs/heads/main/themes/catppuccin-fzf-mocha.sh

zinit wait lucid light-mode for Aloxaf/fzf-tab 

# fzf-tab settings
setopt GLOB_DOTS
zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always --all --group-directories-first $realpath'
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
