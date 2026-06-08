#!/usr/bin/env sh
set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
backup_dir="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

install_file() {
  src="$1"
  dest="$2"

  mkdir -p "$(dirname "$dest")"
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    mkdir -p "$backup_dir/$(dirname "${dest#$HOME/}")"
    cp -R "$dest" "$backup_dir/${dest#$HOME/}"
  fi
  cp "$src" "$dest"
}

install_file "$repo_dir/.zshrc" "$HOME/.zshrc"
install_file "$repo_dir/.gitconfig" "$HOME/.gitconfig"
install_file "$repo_dir/.tmux.conf" "$HOME/.tmux.conf"
install_file "$repo_dir/.config/tmux/aesthetic.conf" "$HOME/.config/tmux/aesthetic.conf"
install_file "$repo_dir/.config/tmux/tmux-pane-context" "$HOME/.config/tmux/tmux-pane-context"
install_file "$repo_dir/.config/nvim/init.lua" "$HOME/.config/nvim/init.lua"
install_file "$repo_dir/.config/nvim/lazy-lock.json" "$HOME/.config/nvim/lazy-lock.json"

chmod +x "$HOME/.config/tmux/tmux-pane-context"

printf 'Installed dotfiles.'
if [ -d "${backup_dir:-}" ]; then
  printf ' Backups are in %s.' "$backup_dir"
fi
printf '\n'
