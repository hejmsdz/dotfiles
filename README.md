# dotfiles

```sh
curl -sfL https://git.io/chezmoi | BINDIR=~/.bin sh
alias chezmoi="~/.bin/chezmoi"

chezmoi init https://github.com/hejmsdz/dotfiles
chezmoi apply
$(chezmoi source-path)/setup.sh
```

