# http://www.clear-code.com/blog/2011/9/5.html

# set shell variable
# WORDCHARS=$WORDCHARS:s,/,,
HISTSIZE=1000000
HISTFILE=~/.zhistory
SAVEHIST=1000000

# set enviroment variables
#export BLOCKSIZE=k
export JLESSCHARSET=japanese
export LANG=ja_JP.UTF-8
export LESS='-iscj5'
export SVN_SSH='ssh'

# 優先的にvimを使用する
if type vim > /dev/null 2>&1; then
    export EDITOR=vim
fi

# 優先的にlvを使用する
if type lv > /dev/null 2>&1; then
    export PAGER=lv
else
    export PAGER=less
fi

# vim: expandtab filetype=zsh shiftwidth=4 softtabstop=4 ts=4
