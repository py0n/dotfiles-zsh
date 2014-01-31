# http://www.clear-code.com/blog/2011/9/5.html
if [ -h $HOME/.zprofenable ]; then
    zmodload zsh/zprof && zprof
fi
# http://qiita.com/mollifier/items/6fdeff2750fe80f830c8
fpath=(
    $HOME/.zsh.d/functions(N-/)
    $fpath
)
#
source $HOME/.zsh.d/env.zsh
source $HOME/.zsh.d/path.zsh
source $HOME/.zsh.d/manpath.zsh
source $HOME/.zsh.d/lscolors.zsh

## PulseAudio
#if [ `which pulseaudio 2> /dev/null` ]; then
#	pulseaudio --start --log-target=syslog
#fi

# vim: expandtab filetype=zsh shiftwidth=4 softtabstop=4 ts=4
