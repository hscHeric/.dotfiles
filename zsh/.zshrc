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
if [ "$TMUX" = "" ]; then tmux; fi
