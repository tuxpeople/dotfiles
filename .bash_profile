# Grundlegende Umgebungsvariablen
export GPG_TTY=$(tty)
export HASTE_SERVER=https://paste.eighty-three.me
export SOPS_AGE_KEY_FILE=~/.config/sops/age/keys.txt

# Homebrew Pfad setzen (nur ARM Mac)
if [ "$(uname -m)" == "arm64" ]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# 1Password CLI (falls vorhanden)
[ -f "$HOME/.op" ] && source "$HOME/.op"

# PATH-Erweiterungen
export PATH="$HOME/bin:$HOME/iCloudDrive/Allgemein/bin:$HOME/.krew/bin:$PATH"

# Pyenv-Konfiguration
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"
eval "$(pyenv virtualenv-init -)"

# Direnv
eval "$(direnv hook bash)"

# Bash Completion (Homebrew oder System)
if which brew &>/dev/null && [ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]; then
	source "$(brew --prefix)/etc/profile.d/bash_completion.sh"
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion
fi

# Zusätzliche Tab-Completions
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh

# .bashrc laden, wenn vorhanden
if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi

# Bash Completion Kompatibilitätsverzeichnis
export BASH_COMPLETION_COMPAT_DIR="$(brew --prefix)/etc/bash_completion.d"

# Tab-Completion für 'defaults' (z. B. defaults write NSGlobalDomain ...)
complete -W "NSGlobalDomain" defaults

# Git-Alias-Completion (z. B. alias g='git')
if type _git &>/dev/null; then
	complete -o default -o nospace -F _git g
fi
