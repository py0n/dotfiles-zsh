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
setopt sh_word_split
# 便利だが副作用の強いものはコメントアウト
#setopt auto_menu
#setopt correct
#setopt inc_append_history
#setopt rm_star_silent
#setopt share_history
#setopt sun_keyboard_hack

autoload -Uz add-zsh-hook # hookを有効に。

# {{{ FPATH関連 (fpath)

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
# }}}

# {{{ ディレクトリ移動関連 (chpwd)
setopt auto_cd # ディレクトリ名だけでcd
setopt auto_pushd # cdするたびにスタックに積む
setopt cdable_vars
setopt pushd_ignore_dups # 重複してスタックに積まない

# cdコマンドに対する検索対象に$HOMEを追加。
cdpath=(
    ~
    ~/scm(N-/)
)

# cdの後でlsを実行
autoload -Uz ls_after_cd && add-zsh-hook chpwd ls_after_cd
# }}}

# {{{ 履歴関連 (history)
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
# }}}

autoload -Uz config-aliases     && config-aliases
autoload -Uz config-bindkeys    && config-bindkeys
autoload -Uz config-completions && config-completions
autoload -Uz git-setup          && git-setup

autoload -Uz zman

# {{{ プロンプト関連 (prompt)
# http://blog.8-p.info/2009/01/red-prompt
# http://d.hatena.ne.jp/kakurasan/20100407/p1
# http://kitak.hatenablog.jp/entry/2013/05/25/103059
# http://less.carbonfairy.org/post/17714419750
# http://usami-k.seesaa.net/article/253493442.html
# http://www.clear-code.com/blog/2011/9/5.html
# http://www.slideshare.net/tetutaro/zsh-20923001

setopt always_last_prompt # 補完のときプロンプトの位置を変えない
setopt prompt_subst       # プロンプトでエスケープシーケンスを有効に
setopt transient_rprompt  # コマンド実行rprompt消去

autoload -Uz colors && colors # プロンプトのカラー表示を有効

# VCS
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%s/%b)'
zstyle ':vcs_info:*' actionformats '(%s/%b|%a)'
# commitしていない変更をチェックする
zstyle ":vcs_info:git:*" check-for-changes true
# gitリポジトリに対して、変更情報とリポジトリ情報を表示する
zstyle ":vcs_info:git:*" formats "%s/%b%c%u"
# gitリポジトリに対して、コンフリクトなどの情報を表示する
zstyle ":vcs_info:git:*" actionformats "%s/%b:%a%c%u"
# addしていない変更があることを示す文字列
zstyle ":vcs_info:git:*" unstagedstr ":U"
# commitしていないstageがあることを示す文字列
zstyle ":vcs_info:git:*" stagedstr ":S"

autoload -Uz my_vcs_info && add-zsh-hook precmd my_vcs_info

case "$UID" in
0)
    PROMPT='%B%m{%n}%%%b '
    RPROMPT='%B[%~]%b'
    PATH=/bin:/sbin:/usr/bin:/usr/sbin
    ;;
*)
    # 直前のコマンドが失敗時にステータスを表示
    local _exitst=$'%(?..%F{red}(%0?%) %f)'
    local _prompt=$'%F{yellow}%n%f%F{green}@%m%f ${_exitst}%# '

    # psvar[1]が存在すれば緑色で表示 (See `man zshmics')
    local _vcs=$'%1(v.%F{green}%1v%f.)'
    local _cwd=$'%F{cyan}[%~]%f'
    local _rprompt='${_vcs}${_cwd}'

    local _lf=$'\n'
    # ディレクトリに三階層目が存在すれば
    # ${_rprompt}と${_lf}を表示
    PROMPT="%3(~.${_rprompt}${_lf}.)${_prompt}"
    # ディレクトリに三階層目が存在しなければ
    # ${_rpromt}を表示
    RPROMPT="%3(~..${_rprompt})"
    ;;
esac
# }}}

# zprofモジュールが有効ならプロファイルを表示する。
if which zprof > /dev/null 2>&1; then
    zprof
fi

debug_echo "(end) .zshrc"

# vim: expandtab filetype=zsh foldmethod=marker shiftwidth=4 softtabstop=4 ts=4
