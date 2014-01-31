# Gitのviewer設定。
git_config() {
    local DIFF=`which diff-highlight`
    local GIT=`which git`
    local LESS=`which less`
    local LV=`which lv`
    local NKF=`which nkf`

    if [[ -x "$GIT" && -x "$DIFF" && -x "$LESS" ]]; then
        # 色設定。
        git config --global --replace-all color.ui true

        # viewer設定。
        if [[ -x "$NKF" ]]; then
            local PAGER="diff-highlight | nkf -w | LESS=-R less"
        elif [[ -x "$LV" ]]; then
            local PAGER="diff-highlight | lv -Ou | LESS=-R less"
        else
            local PAGER="diff-highlight | LESS=-R less"
        fi
        git config --global --replace-all pager.diff "$PAGER"
        git config --global --replace-all pager.log "$PAGER"
        git config --global --replace-all pager.show "$PAGER"
    fi
}

git_config
