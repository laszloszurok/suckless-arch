PROMPT_PREFIX="%Bcwd:%b "
PROMPT_PREFIX_COLOR="%F{69}"

CWD_COLOR="%F{141}"

PROMPT_SYMBOL="%B%b "
PROMPT_SYMBOL_COLOR="%F{141}"

GIT_BRANCH_PREFIX="%Bon%b "
GIT_BRANCH_PREFIX_COLOR="%F{69}"

GIT_BRANCH_SYMBOL=" "
GIT_BRANCH_SYMBOL_COLOR="%F{141}"

# registering precmd function (executes every time before the prompt is drawn)
# if cwd=$HOME --> display /home/username, else display ~/current/path 
# usage: %v in PROMPT
autoload -Uz add-zsh-hook
print_cwd () {
    cwd=$(pwd)
    [[ "$cwd" == "$HOME/"* ]] && cwd="~${$(pwd)#$HOME} " # somewhere in $HOME/*, replace $HOME with ~
    psvar[1]="$cwd"
}
add-zsh-hook precmd print_cwd

# Show git branch in git directories

setopt prompt_subst
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '%F{172}✚%f'
zstyle ':vcs_info:*' unstagedstr '%F{172}●%f'

zstyle ':vcs_info:*' actionformats \
   '%F{141}%b%f %u %c (%a)'

zstyle ':vcs_info:*' formats \
   '%F{141}%b%f %u %c'

vcs_info_wrapper() {
  vcs_info
  if [ -n "$vcs_info_msg_0_" ]; then
    echo "$GIT_BRANCH_PREFIX_COLOR$GIT_BRANCH_PREFIX%f$GIT_BRANCH_SYMBOL_COLOR$GIT_BRANCH_SYMBOL%f${vcs_info_msg_0_}%f$del"
  fi
}

PROMPT="$PROMPT_PREFIX_COLOR$PROMPT_PREFIX$CWD_COLOR%v"$'$(vcs_info_wrapper)'$'\n'"%f$PROMPT_SYMBOL_COLOR$PROMPT_SYMBOL%f"
RPROMPT="%F{141}  %m    %n%f"
