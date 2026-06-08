# dotfiles

Portable shell, git, tmux, and nvim config for a restrained work machine.

Assumed tools:

- `git`
- `zsh`
- `fzf`
- `delta`
- `tmux`
- `nvim`

This intentionally leaves out machine-local workflows, package manager setup, GitHub CLI helpers, credential helpers, project-specific worktree tooling, and private path assumptions.

## Install

```sh
git clone https://github.com/heidaraliy/dotfiles.git ~/dotfiles
cd ~/dotfiles
sh install.sh
```

The installer copies files into place and backs up any existing targets under `~/.dotfiles-backup/`.

## Included

- `.zshrc` with portable git aliases, fzf defaults, `nvim` editor defaults, and terminal navigation keys
- `.gitconfig` with `delta` settings and git aliases
- `.tmux.conf` plus the purple/blue tmux theme, heavy pane borders, pane labels, powerline arrows, and repo/branch status context
- `.config/nvim/init.lua` and `lazy-lock.json`
