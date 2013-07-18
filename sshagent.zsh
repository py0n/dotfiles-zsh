# ssh-agent
# http://blog.gcd.org/archives/50713097.html

AGENT=${HOME}/.ssh-agent-${USER}
if [ -S "${SSH_AUTH_SOCK}" -a ! -L "${SSH_AUTH_SOCK}" ]; then
    ln -sfn ${SSH_AUTH_SOCK} ${AGENT} && export SSH_AUTH_SOCK=${AGENT}
elif [ -S "${AGENT}" ]; then
    export SSH_AUTH_SOCK=${AGENT}
elif [ ! -z ${SSH_AGENT_PID} ]; then
    echo "no ssh-agent"
fi

# vim: expandtab filetype=zsh shiftwidth=4 softtabstop=4 ts=4
