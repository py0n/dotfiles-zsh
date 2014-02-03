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
