export ZSH_THEME="lambda-gitster/lambda-gitster"
export XTERM="xterm-256color"
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh
plugins=(git)

export EDITOR='nvim'
bindkey -e
bindkey '^[[C' forward-word
bindkey '^[[D' backward-word

[[ ! -f ~/.zshrc_aliases ]] || source ~/.zshrc_aliases
[[ ! -f ~/.zshrc_local ]] || source ~/.zshrc_local

export PATH="/usr/local/sbin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
