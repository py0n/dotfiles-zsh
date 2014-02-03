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

source $ZDOTDIR/sources/path
source $ZDOTDIR/sources/manpath
source $ZDOTDIR/sources/lscolors

## PulseAudio
#if [ `which pulseaudio 2> /dev/null` ]; then
#	pulseaudio --start --log-target=syslog
#fi

debug_echo "(end) .zprofile"

# vim: expandtab filetype=zsh shiftwidth=4 softtabstop=4 ts=4
