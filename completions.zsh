# http://www.clear-code.com/blog/2011/9/5.html

# 補完システムを利用: 補完の挙動が分かりやすくなる2つの設定のみ記述
zstyle ':completion:*' format '%BCompleting %d%b'
zstyle ':completion:*' group-name ''
autoload -U compinit && compinit

# vim: expandtab filetype=zsh shiftwidth=4 softtabstop=4 ts=4
