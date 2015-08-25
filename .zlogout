# ログインシェルを抜ける際に實行される。

debug_echo "(begin) .zlogout"

autoload -Uz stop-ssh-ageant && stop-ssh-ageant

debug_echo "(end) .zlogout"

# vim: expandtab filetype=zsh shiftwidth=4 softtabstop=4 ts=4
