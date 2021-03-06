# 設定ファイルが讀込まれる順番
#
# ログインシェル。
#
# * /etc/zshenv
# * $ZDOTDIR/.zshenv
# * /etc/zprofile
# * $ZDOTDIR/.zprofile
# * /etc/zshrc
# * $ZDOTDIR/.zshrc
# * /etc/zlogin
# * $ZDOTDIR/.zlogin
#
# 通常のシェル。
#
# * /etc/zshenv
# * $ZDOTDIR/.zshenv
# * /etc/zshrc
# * $ZDOTDIR/.zshrc
#
# シェルスクリプト實行時。
#
# * /etc/zshenv
# * $ZDOTDIR/.zshenv
#
# ログインシェルを抜ける時。
#
# * $ZDOTDIR/.zlogout
# * /etc/zlogout
#
# man zsh (STARTUP/SHUTDOWN FILES)を參照。

ZDOTDIR=$HOME/.zsh.d

debug_echo () {
    if [[ -n $ZDEBUG ]]; then
        echo $* > /dev/stderr
    fi
}

debug_echo '(begin) .zshenv'

debug_echo '(end) .zshenv'

# vim: expandtab filetype=zsh shiftwidth=4 softtabstop=4 ts=4
