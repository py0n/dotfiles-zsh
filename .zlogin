# ログイン時に実行される。

debug_echo "(begin) .zlogin"

autoload -Uz start-ssh-ageant && start-ssh-ageant

# zprofモジュールが有効ならプロファイルを表示する。
if [[ -n $ZDEBUG && -n $ZPROFDEBUG ]]; then
    zprof
fi

debug_echo "(end) .zlogin"

# vim: expandtab filetype=zsh shiftwidth=4 softtabstop=4 ts=4
