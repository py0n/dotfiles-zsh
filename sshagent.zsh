# ssh-agent
# http://blog.gcd.org/archives/50713097.html

AGENT=${HOME}/.ssh-agent-${USER}

UNAME=`uname`
case "$UNAME" in
    CYGWIN*)
        SSH_PAGEANT=`which ssh-pageant`

        killall -0 $SSH_PAGEANT 2>/dev/null && killall $SSH_PAGEANT

        eval $($SSH_PAGEANT -q)
        ln -sfn $SSH_AUTH_SOCK $AGENT && export SSH_AUTH_SOCK=$AGENT

        #trap 'eval $($SSH_PAGEANT -qk 2>/dev/null)' EXIT
        trap 'logout' HUP
        ;;
    *)
        ;;
esac

if [ -S "$SSH_AUTH_SOCK" -a ! -L "$SSH_AUTH_SOCK" ]; then
    ln -sfn $SSH_AUTH_SOCK $AGENT && export SSH_AUTH_SOCK=$AGENT
elif [ -S "$AGENT" ]; then
    export SSH_AUTH_SOCK=$AGENT
else
    echo "no ssh-agent"
fi

# vim: expandtab filetype=zsh shiftwidth=4 softtabstop=4 ts=4
