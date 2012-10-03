# DIR_COLORS, LS_COLORS
# http://journal.mycom.co.jp/column/zsh/009/index.html
case "$TERM" in
    kterm*|xterm*|screen*)
        if [ -z "$LSCOLORS" ]; then
            export LSCOLORS=exfxcxdxbxegedabagacad
            zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
        fi
        if [ -z "$LS_COLORS" ]; then
            export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
            zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
        fi
	;;
cons25)
	unset LANG
    if [ -z "$LSCOLORS" ]; then
        export LSCOLORS=ExFxCxdxBxegedabagacad
        zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    fi
    if [ -z "$LS_COLORS" ]; then
        export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
        zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    fi
	;;
esac

# vim: expandtab filetype=zsh shiftwidth=4 softtabstop=4 ts=4
