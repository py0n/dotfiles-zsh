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

# {{{ PATH
# http://www.clear-code.com/blog/2011/9/5.html
# 重複したパスを除外する
typeset -U path PATH

# (N-/): 存在しないディレクトリは登録しない。
#    パス(...): ...という条件にマッチするパスのみ残す。
#            N: NULL_GLOBオプションを設定。
#               globがマッチしなかったり存在しないパスを無視する。
#            -: シンボリックリンク先のパスを評価。
#            /: ディレクトリのみ残す。
path=(
    # anyenv
    $HOME/.anyenv/bin(N-/)
    $HOME/.hsenv/bin(N-/)
    # cabal
    $HOME/.cabal/bin(N-/)
    $HOME/cabal-dev/bin(N-/)
    # 自分用
    $HOME/.local/bin(N-/)
    $LOCALBIN(N-/)
    # システム用
    /usr/local/bin(N-/)
    /usr/bin(N-/)
    /bin(N-/)
    $path
)
# }}}

# {{{ MANPATH
# http://www.clear-code.com/blog/2011/9/5.html
# 重複したパスを除外する
typeset -U manpath MANPATH

# (N-/) 存在しないディレクトリは登録しない。
#    パス(...): ...という条件にマッチするパスのみ残す。
#            N: NULL_GLOBオプションを設定。
#               globがマッチしなかったり存在しないパスを無視する。
#            -: シンボリックリンク先のパスを評価。
#            /: ディレクトリのみ残す。
manpath=(
    # 自分用
    $HOME/.local/**/man(N-/)
    $HOME/local/**/man(N-/)
    # システム用
    /usr/local/man(N-/)
    /usr/man(N-/)
    /usr/share/man(N-/)
    /var/**/man(N-/)
    $manpath
)
# }}}

# {{{ FPATH

# http://qiita.com/mollifier/items/6fdeff2750fe80f830c8

typeset -U fpath FPATH  # 重複したパスを除外する
#typeset -x FPATH       # 環境変数にexportする

# http://www.clear-code.com/blog/2011/9/5.html
# (N-/): 存在しないディレクトリは登録しない。
#    パス(...): ...という条件にマッチするパスのみ残す。
#            N: NULL_GLOBオプションを設定。
#               globがマッチしなかったり存在しないパスを無視する。
#            -: シンボリックリンク先のパスを評価。
#            /: ディレクトリのみ残す。

# FPATHはサブシェルに引繼がれないので此處で設定する。
fpath=(
    $ZDOTDIR/functions(N-/)
    $fpath
)
# }}}

# {{{ RCFILES
autoload -Uz setup-rc && setup-rc
# }}}

# {{{ LSCOLORS
# ls (lscolors)
# DIR_COLORS, LS_COLORS
# http://journal.mycom.co.jp/column/zsh/009/index.html
case "$TERM" in
    kterm*|xterm*|screen*)
        if [[ -f $HOME/.dir_colors ]]; then
            case "${OSTYPE}" in
                darwin*)
                    # need 'brew install coreutils'
                    if [[ -x $(whence gdircolors) ]]; then
                        eval $(gdircolors $HOME/.dir_colors)
                    fi
                    ;;
                *)
                    eval $(dircolors $HOME/.dir_colors)
                    ;;
            esac
        fi
        if [[ -z "$LSCOLORS" ]]; then
            LSCOLORS=exfxcxdxbxegedabagacad
            zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
        fi
        if [[ -z "$LS_COLORS" ]]; then
            LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
            zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
        fi
    ;;
cons25)
    unset LANG
    if [[ -z "$LSCOLORS" ]]; then
        LSCOLORS=ExFxCxdxBxegedabagacad
        zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    fi
    if [[ -z "$LS_COLORS" ]]; then
        LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
        zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    fi
    ;;
esac
# }}}

# {{{ anyenv関連 (anyenv)
if [ -d $HOME/.anyenv ]; then
    eval "$(anyenv init -)"
fi
# }}}

## PulseAudio
#if [ `which pulseaudio 2> /dev/null` ]; then
#	pulseaudio --start --log-target=syslog
#fi

debug_echo "(end) .zprofile"

# vim: expandtab filetype=zsh foldmethod=marker shiftwidth=4 softtabstop=4 ts=4
