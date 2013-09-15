# http://www.clear-code.com/blog/2011/9/5.html

alias copy='cp -ip'
alias del='rm -i'
alias dirs='dirs -v'
alias fullreset='echo "\ec\ec"'
alias ja='LANG=ja_JP.eucJP XMODIFIERS=@im=kinput2'
alias la='ls -a'
alias ll='ls -la'
alias lv="$PAGER" # lvがなくてもlvでページャーを起動する。
alias move='mv -i'
alias po='popd'
alias pu='pushd'
alias zprofoff="rm $HOME/.zprofenable"
alias zprofon="ln -s dummy $HOME/.zprofenable"

# Alias and functions
case "$OSTYPE" in
    freebsd*|darwin*)
        alias man='env -u LANG man'
        alias ls='ls -F -G -w'
        ;;
    *)
        alias man='env --unset LANG man'
        alias ls='ls -F --color=auto'
        ;;
esac

h () 		{history "$*" | lv}
mdcd ()		{mkdir -p "$@" && cd "$*[-1]"}
mdpu ()		{mkdir -p "$@" && pushd "$*[-1]"}

# gvim
alias gvim="env GTM_IM_MODULE=xim gvim"
alias gvimdiff="env GTK_IM_MODULE=xim gvimdiff"

# Suffix aliases(起動コマンドは環境によって変更する)
alias -s pdf=acroread dvi=xdvi
alias -s {odt,ods,odp,doc,xls,ppt}=soffice
alias -s {tgz,lzh,zip,arc}=file-roller

# vim: expandtab filetype=zsh shiftwidth=4 softtabstop=4 ts=4
