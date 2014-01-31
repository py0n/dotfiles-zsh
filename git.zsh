# Gitのviewer設定。
git_config() {
    local DIFF=`which diff-highlight`
    local GIT=`which git`
    local LESS=`which less`
    local LV=`which lv`
    local NKF=`which nkf`

    if [[ -n "$GIT" && -x "$GIT" && -n "$DIFF" && -x "$DIFF" ]]; then
        if [[ -n "$LESS" && -x "$LESS" ]]; then
            git config --global --replace-all color.ui true
            if [[ -n "$NKF" && -x "$NKF" ]]; then
                git config --global --replace-all pager.diff "diff-highlight | nkf -w | LESS=-r less"
                git config --global --replace-all pager.log "diff-highlight | nkf -w | LESS=-r less"
                git config --global --replace-all pager.show "diff-highlight | nkf -w | LESS=-r less"
            elif [[ -n "$LV" && -x "$LV" ]]; then
                git config --global --replace-all pager.diff "diff-highlight | lv -Ou | LESS=-r less"
                git config --global --replace-all pager.log "diff-highlight | lv -Ou | LESS=-r less"
                git config --global --replace-all pager.show "diff-highlight | lv -Ou | LESS=-r less"
            else
                git config --global --replace-all pager.diff "diff-highlight | LESS=-r less"
                git config --global --replace-all pager.log "diff-highlight | LESS=-r less"
                git config --global --replace-all pager.show "diff-highlight | LESS=-r less"
            fi
        fi
    fi
}

git_config
