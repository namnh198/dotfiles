source $HOME/.zprofile
export XDG_CONFIG_HOME="$HOME/.config"
export VISUAL="nvim"
export EDITOR="nvim"

# zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

zinit wait lucid light-mode for \
  atinit"zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' \
    zsh-users/zsh-completions

zinit snippet https://raw.githubusercontent.com/junegunn/fzf-git.sh/main/fzf-git.sh

HISTSIZE=50000
SAVEHIST=50000

if type brew &>/dev/null 
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
  autoload -Uz compinit
  compinit
fi

# aliases
alias g="git"
alias v="nvim"
alias vim="nvim"
alias c="clear"
alias cls="clear"
alias lz="lazygit"
alias tm="tmux"

ide() {
  tmux split-window -v -l 25%
  tmux split-window -h -l 50%
}

# zoxide
eval "$(zoxide init zsh)"
alias cd="z"

# bat
export BAT_THEME="Catppuccin Mocha"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
alias cat="bat --style=plain --paging=never --color=always"

# eza
alias ll="eza -l -a --icons --group-directories-first"
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions --group-directories-first"
alias tree="eza --tree --all --color=always --icons --group-directories-first"

# fzf
eval "$(fzf --zsh)"
show_file_or_dir_preview="if [ -d {} ]; then eza --tree --all --color=always --icons --group-directories-first {} | head -200; else bat -n --color=always --line-range :500 {}; fi"
# fzf rose-pine
export FZF_DEFAULT_OPTS="
	--color=fg:#908caa,bg:#191724,hl:#ebbcba
	--color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba
	--color=border:#403d52,header:#31748f,gutter:#191724
	--color=spinner:#f6c177,info:#9ccfd8
	--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"

export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="fd --type f --hidden --follow"
export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"


export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
