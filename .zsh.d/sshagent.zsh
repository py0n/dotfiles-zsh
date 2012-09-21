# ssh-agent
# http://blog.gcd.org/archives/50713097.html
if [ ! -z ${SSH_AGENT_PID} ]; then
	AGENT=${HOME}/.ssh-agent-${USER}
	if [ -S "${SSH_AUTH_SOCK}" -a ! -L "${SSH_AUTH_SOCK}" ]; then
		ln -sfn ${SSH_AUTH_SOCK} ${AGENT} && export SSH_AUTH_SOCK=${AGENT}
	elif [ -S "${AGENT}" ]; then
		export SSH_AUTH_SOCK=${AGENT}
	else
		echo "no ssh-agent"
	fi
fi

# vim: expandtab filetype=zsh shiftwidth=4 softtabstop=4 ts=4
