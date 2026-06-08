# Portable shell defaults for work machines.

export EDITOR="${EDITOR:-nvim}"
export VISUAL="${VISUAL:-nvim}"

# Keep terminal tabs readable.
precmd() {
  print -Pn "\e]1;%~\a"
}

autoload -Uz compinit && compinit
setopt autocd
setopt correct

# Colors: macOS ls supports -G; GNU ls uses --color.
export CLICOLOR=1
if ls -G . >/dev/null 2>&1; then
  alias ls='ls -G'
  alias ll='ls -lahG'
elif ls --color=auto . >/dev/null 2>&1; then
  alias ls='ls --color=auto'
  alias ll='ls -lah --color=auto'
else
  alias ll='ls -lah'
fi

# fzf integration, when present.
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_OPTS="
  --height=80%
  --layout=reverse
  --border
  --cycle
  --prompt='> '
"

# Git aliases.
alias gs='git status'
alias gl='git log --oneline --decorate -n 20'
alias gd='git diff'
alias gds='git diff --staged'
alias ga='git add'
alias gc='git commit -m'
alias gpl='git pull'
alias gp='git push'

_gac() {
  git add -A && git commit -m "$1"
}
alias gac='nocorrect _gac'

_gcmp() {
  git add -A && git commit -m "$1" && git push
}
alias gcmp='nocorrect _gcmp'

# f [query] - fuzzy-find files with only find, fzf, and nvim.
f() {
  local file
  file=$(
    find "${1:-.}" \
      -path '*/.git' -prune -o \
      -type f -print 2>/dev/null |
      fzf
  ) && nvim "$file"
}

# Terminal line-editing keys for common terminal emulators.
for keymap in viins vicmd emacs; do
  bindkey -M "$keymap" "^[[1~" beginning-of-line
  bindkey -M "$keymap" "^[[4~" end-of-line
  bindkey -M "$keymap" "^[[H" beginning-of-line
  bindkey -M "$keymap" "^[[F" end-of-line
  bindkey -M "$keymap" "^[OH" beginning-of-line
  bindkey -M "$keymap" "^[OF" end-of-line
  bindkey -M "$keymap" "^[[1;5D" backward-word
  bindkey -M "$keymap" "^[[1;5C" forward-word
done
