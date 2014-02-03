# http://journal.mycom.co.jp/column/zsh/index.html
# http://www.clear-code.com/blog/2011/9/5.html
# http://www.gentei.org/~yuuji/support/zsh/files/zshrc

debug_echo "(begin) .zshrc"

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

source $ZDOTDIR/prompt.zsh

# 履歴設定
HISTFILE=$HOME/.zhistory
HISTSIZE=1000000
SAVEHIST=1000000

# 陳腐な履歴は殘さず。
# http://d.hatena.ne.jp/UDONCHAN/20100618/1276842846
add-my-history() {
    unsetopt sh_word_split # sh_word_splitが有効だとエラーになる。
    local line=${1%%$'\n'}
    local cmd=${line%% *}
    [[ ${cmd} != (cd|exit|history|l|l[asl]|rm) ]]
}

add-zsh-hook zshaddhistory add-my-history

# http://qiita.com/mollifier/items/6fdeff2750fe80f830c8

typeset -U fpath # 重複したパスを除外する

# http://www.clear-code.com/blog/2011/9/5.html
# (N-/): 存在しないディレクトリは登録しない。
#    パス(...): ...という条件にマッチするパスのみ残す。
#            N: NULL_GLOBオプションを設定。
#               globがマッチしなかったり存在しないパスを無視する。
#            -: シンボリックリンク先のパスを評価。
#            /: ディレクトリのみ残す。

# FPATHはサブシェルに引繼がれないので此處で設定する。
fpath=(
    $ZDOTDIR/functions(N-/)
    $fpath
)

autoload -Uz config-aliases     && config-aliases
autoload -Uz config-bindkeys    && config-bindkeys
autoload -Uz config-chpwd       && config-chpwd
autoload -Uz config-completions && config-completions
autoload -Uz config-git         && config-git

autoload -Uz zman

# zprofモジュールが有効ならプロファイルを表示する。
if which zprof > /dev/null 2>&1; then
    zprof
fi

debug_echo "(end) .zshrc"

# vim: expandtab filetype=zsh shiftwidth=4 softtabstop=4 ts=4
