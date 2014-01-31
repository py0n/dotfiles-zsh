# http://www.clear-code.com/blog/2011/9/5.html
if [[ -h $HOME/.zprofenable ]]; then
    zmodload zsh/zprof && zprof
fi

source $ZDOTDIR/sources/env
source $ZDOTDIR/sources/fpath
source $ZDOTDIR/sources/path
source $ZDOTDIR/sources/manpath
source $ZDOTDIR/sources/lscolors

## PulseAudio
#if [ `which pulseaudio 2> /dev/null` ]; then
#	pulseaudio --start --log-target=syslog
#fi

# vim: expandtab filetype=zsh shiftwidth=4 softtabstop=4 ts=4
