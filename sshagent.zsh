# ssh-agent

AGENT=${HOME}/.ssh-agent-${USER}

UNAME=`uname`
case "$UNAME" in
    # http://cuviper.github.io/ssh-pageant/
    CYGWIN*)
        SSH_PAGEANT=`which ssh-pageant`
        SSH_PAGEANT_SOCK=$HOME/.ssh-pagent.sock

        eval $($SSH_PAGEANT -q -r -a $SSH_PAGEANT_SOCK)

        #trap 'eval $($SSH_PAGEANT -qk 2>/dev/null)' EXIT
        trap 'logout' HUP
        ;;
    *)
        ;;
esac

# http://blog.gcd.org/archives/50713097.html
if [ -S "$SSH_AUTH_SOCK" -a ! -L "$SSH_AUTH_SOCK" ]; then
    ln -sfn $SSH_AUTH_SOCK $AGENT && export SSH_AUTH_SOCK=$AGENT
elif [ -S "$AGENT" ]; then
    export SSH_AUTH_SOCK=$AGENT
else
    echo "no ssh-agent"
fi

# vim: expandtab filetype=zsh shiftwidth=4 softtabstop=4 ts=4
