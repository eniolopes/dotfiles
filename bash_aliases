alias pp="cd ~/Projects"
alias tns="tmux -u new-session -s $(basename "$PWD")"
alias source_bash="source ~/.bashrc"

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

GIT_PROMPT_ONLY_IN_REPO=1
source ~/.bash-git-prompt/gitprompt.sh
