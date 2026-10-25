#!/usr/bin/env bash
# PreToolUse hook (Bash): block commands that would print decrypted secrets
# into Claude's context. An accident guard, not a security boundary.
# Exit 2 = block; stderr is shown to Claude as the reason.

input=$(cat)
cmd=$(printf '%s' "$input" | jq -r '.tool_input.command // empty' 2>/dev/null) || cmd=$input
[ -n "$cmd" ] || cmd=$input

block() {
  printf 'Blocked by ~/.claude/hooks/block-secret-output.sh: %s\n' "$1" >&2
  exit 2
}

# Output fully discarded (e.g. `sops -d f >/dev/null && echo ok`) is fine.
discarded() { printf '%s' "$cmd" | grep -Eq '(^|[^0-9])>[[:space:]]*/dev/null|&>[[:space:]]*/dev/null'; }

has() { printf '%s' "$cmd" | grep -Eq -e "$1"; }

# The age key file itself
has '\.config/sops/age|sops/age/keys\.txt' &&
  block "the SOPS age key file must not be read."

# ansible-inventory resolves SOPS vars plugin values into plaintext
if has '\bansible-inventory\b'; then
  if ! { has '--graph' && ! has '--vars'; } && ! discarded; then
    block "ansible-inventory prints decrypted vars. Use 'ansible-inventory --graph' (no --vars), or ANSIBLE_VARS_ENABLED=host_group_vars to skip the SOPS plugin."
  fi
fi

# ad-hoc debug of variables
has '\bansible\b.*(-m|--module-name)[[:space:]=]*(ansible\.builtin\.)?debug\b' &&
  block "ansible -m debug prints variable values. Check variable names in the vars files instead."

# sops / ansible-vault decryption to stdout
if has '\bsops\b[^|;&]*([[:space:]](-d|--decrypt|decrypt)\b)' && ! discarded; then
  block "sops decrypt to stdout. Redirect to /dev/null to test decryption, or inspect key names in the encrypted file."
fi
has '\bansible-vault[[:space:]]+(view|decrypt)\b' && ! discarded &&
  block "ansible-vault view/decrypt prints secrets."

# 1Password reads to stdout
if has '\bop[[:space:]]+read\b|\bop[[:space:]]+item[[:space:]]+get\b.*--reveal' && ! discarded; then
  block "1Password secret read to stdout. Redirect to /dev/null to test access."
fi

exit 0
