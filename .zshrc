# http://journal.mycom.co.jp/column/zsh/index.html
# http://www.clear-code.com/blog/2011/9/5.html
# http://www.gentei.org/~yuuji/support/zsh/files/zshrc

# Set shell options
# 有効にしてあるのは副作用の少ないもの
setopt always_last_prompt
setopt auto_cd
setopt auto_pushd
setopt auto_name_dirs
setopt auto_param_keys
setopt auto_remove_slash
setopt cdable_vars
setopt extended_glob
setopt extended_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt list_types
setopt no_beep
setopt prompt_subst
setopt pushd_ignore_dups
setopt sh_word_split
# 便利だが副作用の強いものはコメントアウト
#setopt auto_menu
#setopt correct
#setopt inc_append_history
#setopt rm_star_silent
#setopt share_history
#setopt sun_keyboard_hack

source $HOME/.zsh.d/aliases.zsh
source $HOME/.zsh.d/bindkeys.zsh
source $HOME/.zsh.d/completions.zsh

source $HOME/.zsh.d/sshagent.zsh
source $HOME/.zsh.d/prompt.zsh

cdpath=(~)
chpwd_functions=($chpwd_functions dirs)

# vim: expandtab filetype=zsh shiftwidth=4 softtabstop=4 ts=4