# ~/.bashrc – interaktive Shells

# Nur interaktive Shells
[[ $- != *i* ]] && return

# Bash-Optionen für besseren Komfort
shopt -s histappend # History wird angehängt
shopt -s cdspell    # Korrigiert Tippfehler bei cd
shopt -s nocaseglob # Dateiglobbing ohne Groß/Kleinschreibung
shopt -s globstar   # Ermöglicht rekursives Globbing mit **
shopt -s autocd     # Nur Verzeichnisnamen = automatisches cd

# Dynamisches Einlesen von optionalen Dotfiles
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
