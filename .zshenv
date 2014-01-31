# 設定ファイルが讀込まれる順番
#
# ログインシェル。
#
# * /etc/zshrc
# * $ZDOTDIE/.zshenv
# * /etc/zprofile
# * $ZDOTDIR/.zprofile
# * /etc/zshrc
# * $ZDOTDIR/.zshrc
# * /etc/zlogin
# * /etc/.zlogin
#
# 通常のシェル。
#
# * /etc/zshenv
# * $ZDOTDIR/.zshrc
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
# * /etc/zlogout
# * $ZDOTDIR/.zlogout
#
# man zshを參照。

export ZDOTDIR=$HOME/.zsh.d

# vim: expandtab filetype=zsh shiftwidth=4 softtabstop=4 ts=4
