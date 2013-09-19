# http://d.hatena.ne.jp/kakurasan/20100407/p1
# http://kitak.hatenablog.jp/entry/2013/05/25/103059
# http://less.carbonfairy.org/post/17714419750
# http://usami-k.seesaa.net/article/253493442.html
# http://www.clear-code.com/blog/2011/9/5.html

setopt always_last_prompt # 補完のときプロンプトの位置を変えない
setopt prompt_subst       # プロンプトでエスケープシーケンスを有効に

autoload -Uz add-zsh-hook     # hookを有効に。
autoload -Uz colors && colors # プロンプトのカラー表示を有効

# VCS
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%s/%b)'
zstyle ':vcs_info:*' actionformats '(%s/%b|%a)'
# commitしていない変更をチェックする
zstyle ":vcs_info:git:*" check-for-changes true
# gitリポジトリに対して、変更情報とリポジトリ情報を表示する
zstyle ":vcs_info:git:*" formats "%s/%b%c%u"
# gitリポジトリに対して、コンフリクトなどの情報を表示する
zstyle ":vcs_info:git:*" actionformats "%s/%b:%a%c%u"
# addしていない変更があることを示す文字列
zstyle ":vcs_info:git:*" unstagedstr ":U"
# commitしていないstageがあることを示す文字列
zstyle ":vcs_info:git:*" stagedstr ":S"

# git：まだpushしていないcommitあるかチェックする
my_git_info_push () {
    if [ -n "$(git remote 2>/dev/null)" ]; then
        local head="$(git rev-parse HEAD)"
        local remote
        for remote in $(git rev-parse --remotes) ; do
            if [ "$head" = "$remote" ]; then return 0 ; fi
        done
        # pushしていないcommitがあることを示す文字列
        echo ":P"
    fi
}

# git：stashに退避したものがあるかチェックする
my_git_info_stash () {
    if [ -n "$(git stash list 2>/dev/null)" ]; then
        # stashがあることを示す文字列
        echo ":s"
    fi
}

# vcs_infoの出力に独自の出力を付加する
my_vcs_info () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    if [ -n "$vcs_info_msg_0_" ]; then
        psvar[1]="(${vcs_info_msg_0_}$(my_git_info_push)$(my_git_info_stash))"
    fi
}

add-zsh-hook precmd my_vcs_info

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
    PROMPT="%3(~|%1(v|%F{green}%1v%f|)${_rprompt}${_lf}|)${_prompt}"
    RPROMPT="%3(~||%1(v|%F{green}%1v%f|)${_rprompt})"
	;;
esac
