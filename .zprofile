# ログイン時に實行される。

debug_echo "(begin) .zprofile"

# http://www.clear-code.com/blog/2011/9/5.html
if [[ -n $ZDEBUG && -n $ZPROFDEBUG ]]; then
    zmodload zsh/zprof && zprof
fi

# {{{ ENVIRONMENTS
# http://koyudoon.hatenablog.com/entry/20120205/1328401222
# http://walf443.hatenablog.com/entry/20071119/1195487813
# http://www.clear-code.com/blog/2011/9/5.html

export LANG=ja_JP.UTF-8

export JLESSCHARSET=japanese
export LESS='-iscj5'

export SVN_SSH='ssh'

# `/'を単語の區切りにする
export WORDCHARS="*?_-.[]~=&;!#$%^(){}<>"

export LOCALBIN=$HOME/local/bin

# lvを優先。
if [[ -x $(whence lv) ]]; then
    export PAGER=$(whence lv)
elif [[ -x $(whence less) ]]; then
    export PAGER=$(whence less)
fi
export MANPAGER=${MANPAGER:-$(whence less)}

# vimを優先
if [[ -x $(whence vim) ]]; then
    export EDITOR=$(whence vim)
fi
# }}}

# {{{ DIRECTORIES
if [[ -n $LOCALBIN ]]; then
    mkdir -p $LOCALBIN
fi
# }}}

## PulseAudio
#if [ `which pulseaudio 2> /dev/null` ]; then
#	pulseaudio --start --log-target=syslog
#fi

debug_echo "(end) .zprofile"

# vim: expandtab filetype=zsh foldmethod=marker shiftwidth=4 softtabstop=4 ts=4
