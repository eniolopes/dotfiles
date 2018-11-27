alias pp="cd ~/Projects"
alias source_bash="source ~/.bash_profile"
alias nt="cd ~/Dropbox/Bhaktabandhav/newsletter_gen"
alias battery="acpi"

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

GIT_PROMPT_ONLY_IN_REPO=1
source ~/.bash-git-prompt/gitprompt.sh

export PATH="$PATH:/home/enio/Projects/dotfiles/bin"
