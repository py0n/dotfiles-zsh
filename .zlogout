# ログインシェルを抜ける際に實行される。

debug_echo "(begin) .zlogout"

autoload -Uz ssh-ageant-stop && ssh-ageant-stop

debug_echo "(end) .zlogout"

# vim: expandtab filetype=zsh shiftwidth=4 softtabstop=4 ts=4
