# dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## What's in here

| File | Description |
|------|-------------|
| `dot_gitconfig.tmpl` | Git config — GPG path per architecture, GitLab shortcuts on business Macs only |
| `dot_config/ghorg/conf.yaml.tmpl` | ghorg config — GitHub token from 1Password, clone path from `$HOME` |
| `private_dot_ssh/private_config.tmpl` | SSH config — business vs. private host sections |
| `dot_bash_profile`, `dot_aliases`, … | Shell config, functions, exports |
| `dot_k9s/` | k9s skin and config |

## Templates

Two files use chezmoi templates (`.tmpl` suffix):

- **`dot_gitconfig.tmpl`**: Renders `[gpg] program` path based on architecture (`arm64` → `/opt/homebrew/bin/gpg`), includes GitLab URL shortcuts only on business Macs
- **`dot_config/ghorg/conf.yaml.tmpl`**: Injects GitHub token via `onepasswordRead`, sets clone path via `.chezmoi.homeDir`
- **`private_dot_ssh/private_config.tmpl`**: Includes private sections (NAS, LAB, Jump Hosts) only on private Macs

Machine type (`is_business`) is determined by hostname — see `.chezmoi.toml.tmpl`.

## Setup on a new Mac

chezmoi is installed and initialized automatically by [mac-dev-playbook](https://github.com/tuxpeople/mac-dev-playbook) during Phase 3. 1Password must be signed in before `chezmoi apply` runs (needed for secret injection).

Manual setup:

```bash
brew install chezmoi
chezmoi init https://github.com/tuxpeople/dotfiles.git
chezmoi apply
```

## Daily usage

```bash
# Edit a dotfile
chezmoi edit ~/.gitconfig

# Preview changes before applying
chezmoi diff

# Apply changes
chezmoi apply

# Pull latest from GitHub and apply
chezmoi update
```

## Adding a new dotfile

```bash
chezmoi add ~/.newfile
chezmoi edit ~/.newfile
chezmoi apply
cd $(chezmoi source-path) && git add . && git commit -m "Add .newfile" && git push
```

## Secrets

Secrets use 1Password via `onepasswordRead`:

```
{{ onepasswordRead "op://vault/item/field" }}
```

Requires 1Password CLI (`op`) to be installed and signed in.
