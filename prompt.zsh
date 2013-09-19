# http://www.clear-code.com/blog/2011/9/5.html

setopt always_last_prompt # 補完のときプロンプトの位置を変えない
setopt prompt_subst       # プロンプトでエスケープシーケンスを有効に。

# プロンプトのカラー表示を有効
autoload -U colors && colors

# Git
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%s/%b)'
zstyle ':vcs_info:*' actionformats '(%s/%b|%a)'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

# Set Shell variable
# WORDCHARS=$WORDCHARS:s,/,,
HISTSIZE=1000000
HISTFILE=~/.zhistory
SAVEHIST=1000000

case "$UID" in
0)
	PROMPT='%B%m{%n}%%%b '
	RPROMPT='%B[%~]%b'
	PATH=/bin:/sbin:/usr/bin:/usr/sbin
	;;
*)
	local _prompt=$'%{${fg[yellow]}%}%n%{${reset_color}%}%{${fg[green]}%}@%m%{${reset_color}%} %% '
	local _rprompt=$'%{${fg[cyan]}%}[%~]%{${reset_color}%}'
	local _lf=$'\n'
    PROMPT="%3(~|$_rprompt%1(v|%F{green}%1v%f|)$_lf|)$_prompt"
    RPROMPT="%3(~||$_rprompt%1(v|%F{green}%1v%f|))"
	;;
esac
