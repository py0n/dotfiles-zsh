# ログイン時に實行される。

debug_echo "(begin) .zprofile"

# http://www.clear-code.com/blog/2011/9/5.html
if [[ -h $HOME/.zprofenable ]]; then
    zmodload zsh/zprof && zprof
fi

# {{{ 環境変数 (environment)
# http://koyudoon.hatenablog.com/entry/20120205/1328401222
# http://www.clear-code.com/blog/2011/9/5.html

export LANG=ja_JP.UTF-8

export JLESSCHARSET=japanese
export LESS='-iscj5'

export SVN_SSH='ssh'

# 優先的にvimを使用する
if [[ -x `whence vim` ]]; then
    export EDITOR=vim
fi

# 優先的にlvを使用する
if [[ -x `whence lv` ]]; then
    export PAGER=lv
else
    export PAGER=less
fi
# }}}

# {{{ パス関連 (path)
# http://www.clear-code.com/blog/2011/9/5.html
# 重複したパスを除外する
typeset -U path

# (N-/): 存在しないディレクトリは登録しない。
#    パス(...): ...という条件にマッチするパスのみ残す。
#            N: NULL_GLOBオプションを設定。
#               globがマッチしなかったり存在しないパスを無視する。
#            -: シンボリックリンク先のパスを評価。
#            /: ディレクトリのみ残す。
path=(
    # cabal
    $HOME/cabal-dev/bin(N-/)
    $HOME/.cabal/bin(N-/)
    # 自分用
    $HOME/local/bin(N-/)
    $HOME/.local/bin(N-/)
    # システム用
    /usr/local/**/bin(N-/)
    /usr/bin(N-/)
    /bin(N-/)
)
# }}}

source $ZDOTDIR/sources/manpath
source $ZDOTDIR/sources/lscolors

## PulseAudio
#if [ `which pulseaudio 2> /dev/null` ]; then
#	pulseaudio --start --log-target=syslog
#fi

debug_echo "(end) .zprofile"

# vim: expandtab filetype=zsh foldmethod=marker shiftwidth=4 softtabstop=4 ts=4
