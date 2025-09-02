. "$HOME/.cargo/env" 
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$(go env GOPATH)/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"
export KERL_BUILD_DOCS=yes
DOTFILES_DIR="$HOME/.dotfiles"

ZSH_THEME="bira"

plugins=(
	asdf
	git
	you-should-use
	zsh-autosuggestions
	zsh-syntax-highlighting
)

fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)
autoload -Uz compinit && compinit

source $ZSH/oh-my-zsh.sh

#shell
source <(fzf --zsh)
eval "$(zoxide init zsh)"

#aliases
alias cd="z"
alias reload-zsh="source ~/.zshrc"
alias edit-zsh="nvim ~/.zshrc"
alias ls='eza -lh --group-directories-first --icons=auto'
alias lsa='ls -a'
alias lt='eza --tree --level=2 --long --icons --git'
alias lta='lt -a'
alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

if [ "$TMUX" = "" ]; then tmux; fi
