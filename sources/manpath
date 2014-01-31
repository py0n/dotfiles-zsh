# http://www.clear-code.com/blog/2011/9/5.html
# 重複したパスを除外する
typeset -U manpath

# (N-/) 存在しないディレクトリは登録しない。
#    パス(...): ...という条件にマッチするパスのみ残す。
#            N: NULL_GLOBオプションを設定。
#               globがマッチしなかったり存在しないパスを無視する。
#            -: シンボリックリンク先のパスを評価。
#            /: ディレクトリのみ残す。
manpath=(
    # 自分用
    $HOME/local/**/man(N-/)
    # システム用
    /usr/local/man(N-/)
    /usr/man(N-/)
    /usr/share/man(N-/)
    /var/**/man(N-/)
)

# vim: expandtab filetype=zsh shiftwidth=4 softtabstop=4 ts=4
