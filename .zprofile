# http://www.clear-code.com/blog/2011/9/5.html
if [[ -h $HOME/.zprofenable ]]; then
    zmodload zsh/zprof && zprof
fi

# http://qiita.com/mollifier/items/6fdeff2750fe80f830c8
fpath=(
    $HOME/.zsh.d/functions(N-/)
    $fpath
)
autoload -Uz config-env      && config-env
autoload -Uz config-path     && config-path
autoload -Uz config-manpath  && config-manpath
autoload -Uz config-lscolors && config-lscolors

## PulseAudio
#if [ `which pulseaudio 2> /dev/null` ]; then
#	pulseaudio --start --log-target=syslog
#fi

# vim: expandtab filetype=zsh shiftwidth=4 softtabstop=4 ts=4
