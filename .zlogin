# ログイン時に実行される。

debug_echo "(begin) .zlogin"

autoload -Uz ssh-ageant-start && ssh-ageant-start

debug_echo "(end) .zlogin"

# vim: expandtab filetype=zsh shiftwidth=4 softtabstop=4 ts=4
