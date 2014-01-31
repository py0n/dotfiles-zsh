# http://journal.mycom.co.jp/column/zsh/index.html
# http://www.clear-code.com/blog/2011/9/5.html
# http://www.gentei.org/~yuuji/support/zsh/files/zshrc

# Set shell options
# 有効にしてあるのは副作用の少ないもの
setopt auto_name_dirs
setopt auto_param_keys
setopt auto_remove_slash
setopt extended_glob
setopt extended_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt list_types
setopt no_beep
setopt pushd_ignore_dups
setopt sh_word_split
# 便利だが副作用の強いものはコメントアウト
#setopt auto_menu
#setopt correct
#setopt inc_append_history
#setopt rm_star_silent
#setopt share_history
#setopt sun_keyboard_hack

source $HOME/.zsh.d/prompt.zsh

# http://qiita.com/mollifier/items/6fdeff2750fe80f830c8
autoload -Uz config-aliases     && config-aliases
autoload -Uz config-bindkeys    && config-bindkeys
autoload -Uz config-chpwd       && config-chpwd
autoload -Uz config-completions && config-completions
autoload -Uz config-git         && config-git
autoload -Uz config-sshagent    && config-sshagent

# zprofモジュールが有効ならプロファイルを表示する。
if which zprof > /dev/null 2>&1; then
    zprof
fi

# vim: expandtab filetype=zsh shiftwidth=4 softtabstop=4 ts=4
