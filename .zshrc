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
setopt list_types
setopt no_beep
setopt sh_word_split
# 便利だが副作用の強いものはコメントアウト
#setopt auto_menu
#setopt correct
#setopt rm_star_silent
#setopt sun_keyboard_hack

autoload -Uz add-zsh-hook # hookを有効に。

# {{{ キー關聯
# http://www.clear-code.com/blog/2011/9/5.html
# EDITOR=vimだとviキーバインドになってしまう為、
# emacsキーバインドを使用するように明示。
bindkey -e
# }}}

# {{{ 補完關聯
# http://www.clear-code.com/blog/2011/9/5.html
# 補完システムを利用: 補完の挙動が分かりやすくなる2つの設定のみ記述
zstyle ':completion:*' format '%BCompleting %d%b'
zstyle ':completion:*' group-name ''
autoload -U compinit && compinit
# }}}

# 環境変数 {{{
export GOOS=$HOME/go
export GOPATH=$HOME/goenv
# }}}

# {{{ PATH
# http://www.clear-code.com/blog/2011/9/5.html
# 重複したパスを除外する
typeset -U path PATH

# (N-/): 存在しないディレクトリは登録しない。
#    パス(...): ...という条件にマッチするパスのみ残す。
#            N: NULL_GLOBオプションを設定。
#               globがマッチしなかったり存在しないパスを無視する。
#            -: シンボリックリンク先のパスを評価。
#            /: ディレクトリのみ残す。
path=(
    # ndenv
    $HOME/.ndenv/bin(N-/)
    $HOME/.ndenv/shims(N-/)
    # go
    $GOOS/bin(N-/)
    $GOPATH/bin(N-/)
    # anyenv
    $HOME/.anyenv/bin(N-/)
    $HOME/.hsenv/bin(N-/)
    # cabal
    $HOME/.cabal/bin(N-/)
    $HOME/cabal-dev/bin(N-/)
    # 自分用
    $HOME/.local/bin(N-/)
    $LOCALBIN(N-/)
    # システム用
    /usr/local/bin(N-/)
    /usr/bin(N-/)
    /bin(N-/)
    $path
)
# }}}

# {{{ MANPATH
# http://www.clear-code.com/blog/2011/9/5.html
# 重複したパスを除外する
typeset -U manpath MANPATH

# (N-/) 存在しないディレクトリは登録しない。
#    パス(...): ...という条件にマッチするパスのみ残す。
#            N: NULL_GLOBオプションを設定。
#               globがマッチしなかったり存在しないパスを無視する。
#            -: シンボリックリンク先のパスを評価。
#            /: ディレクトリのみ残す。
manpath=(
    # 自分用
    $HOME/.local/**/man(N-/)
    $HOME/local/**/man(N-/)
    # システム用
    /usr/local/man(N-/)
    /usr/man(N-/)
    /usr/share/man(N-/)
    /var/**/man(N-/)
    $manpath
)
# }}}

# {{{ FPATH

# http://qiita.com/mollifier/items/6fdeff2750fe80f830c8

typeset -U fpath FPATH  # 重複したパスを除外する
#typeset -x FPATH       # 環境変数にexportする

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

# {{{ RCFILES
autoload -Uz setup-rc && setup-rc
# }}}

# {{{ LSCOLORS
# ls (lscolors)
# DIR_COLORS, LS_COLORS
# http://journal.mycom.co.jp/column/zsh/009/index.html
case "$TERM" in
    kterm*|xterm*|screen*)
        local dircolorspath=$HOME/.dir_colors
        if [[ -f ${dircolorspath} ]]; then
            case "${OSTYPE}" in
                darwin*)
                    # need 'brew install coreutils'
                    if [[ -x $(whence gdircolors) ]]; then
                        eval $(gdircolors ${dircolorspath})
                    fi
                    ;;
                *)
                    if [[ -x $(whence dircolors) ]]; then
                        eval $(dircolors ${dircolorspath})
                    fi
                    ;;
            esac
        fi
        if [[ -z $LSCOLORS ]]; then
            LSCOLORS=exfxcxdxbxegedabagacad
            zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
        fi
        if [[ -z $LS_COLORS ]]; then
            LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
            zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
        fi
        ;;
    cons25)
        unset LANG
        if [[ -z $LSCOLORS ]]; then
            LSCOLORS=ExFxCxdxBxegedabagacad
            zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
        fi
        if [[ -z $LS_COLORS ]]; then
            LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
            zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
        fi
        ;;
esac
# }}}

# {{{ ディレクトリ移動関連 (chpwd)
setopt auto_cd # ディレクトリ名だけでcd
setopt auto_pushd # cdするたびにスタックに積む
setopt cdable_vars
setopt pushd_ignore_dups # 重複してスタックに積まない

mdcd(){mkdir -p "$@" && cd "$*[-1]"}
mdpu(){mkdir -p "$@" && pushd "$*[-1]"}

# cdコマンドに対する検索対象に$HOMEを追加。
cdpath=(
    ~
    ~/scm(N-/)
)

# cdの後でlsを実行
# http://qiita.com/yuyuchu3333/items/b10542db482c3ac8b059
autoload -Uz ls_after_cd && add-zsh-hook chpwd ls_after_cd

# 自動でhsenvをactivate/deactivate
# http://qiita.com/saturday06/items/3b67861b8ebcadeb01cd
autoload -Uz auto_hsenv && add-zsh-hook precmd auto_hsenv
# }}}

# {{{ history (履歴関連)
# `zsh` の `history` は `fc -l` のエイリアス (man zshbuiltins)
# http://qiita.com/syui/items/c1a1567b2b76051f50c4
# http://www.clear-code.com/blog/2011/9/5.html
#setopt hist_ignore_dups
#setopt hist_ignore_space
#setopt inc_append_history
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_verify
setopt share_history

bindkey '^p' history-beginning-search-backward
bindkey '^n' history-beginning-search-forward

HISTFILE=$HOME/.zhistory
HISTSIZE=1000000
SAVEHIST=1000000

# 陳腐な履歴は殘さず。
# http://d.hatena.ne.jp/UDONCHAN/20100618/1276842846
# 失敗したコマンドは履歴に残したくないが、下記の記事を読むと無理そう。
# http://qiita.com/mollifier/items/558712f1a93ee07e22e2
add-my-history() {
    unsetopt sh_word_split # sh_word_splitが有効だとエラーになる。
    local line=${1%%$'\n'}
    local cmd=${line%% *}
    [[ ${cmd} != (cd|exit|history|kill|l|l[asl]|rm|sudo|/) ]]
}
add-zsh-hook zshaddhistory add-my-history

# `peco` と連携。
# http://qiita.com/shepabashi/items/f2bc2be37a31df49bca5
if [[ -x $(whence peco) ]]; then
    peco-history-selection() {
        BUFFER=$(fc -lnr 1 | awk '!a[$0]++' | peco)
        CURSOR=$#BUFFER
        zle reset-prompt
    }
    zle -N peco-history-selection
    bindkey '^R' peco-history-selection
fi
# }}}

# {{{ エイリアス關聯 (alias)
# http://www.clear-code.com/blog/2011/9/5.html

alias copy='cp -ip'
alias del='rm -i'
alias dirs='dirs -v'
alias fullreset='echo "\ec\ec"'
alias ja='LANG=ja_JP.eucJP XMODIFIERS=@im=kinput2'
alias la='ls -a'
alias ll='ls -la'
alias move='mv -i'
alias po='popd'
alias pu='pushd'

# lvがなくてもlvでページャーを起動する。
if [[ -n $PAGER && $PAGER != "lv" ]]; then
    alias lv=$PAGER
fi

# Alias and functions
case "$OSTYPE" in
    freebsd*|darwin*)
        alias man='env -u LANG man'
        if [[ -x $(whence gls) ]]; then
            alias ls='gls -F --color=auto'
        else
            alias ls='ls -F -G -w'
        fi
        ;;
    *)
        alias man='env --unset LANG man'
        alias ls='ls -F --color=auto'
        ;;
esac

# Suffix aliases(起動コマンドは環境によって変更する)
alias -s pdf=acroread dvi=xdvi
alias -s {odt,ods,odp,doc,xls,ppt}=soffice
alias -s {tgz,lzh,zip,arc}=file-roller
# }}}

autoload -Uz setup-widgets && setup-widgets
autoload -Uz setup-direnv  && setup-direnv
autoload -Uz setup-git     && setup-git
autoload -Uz setup-go      && setup-go
autoload -Uz setup-less    && setup-less
autoload -Uz setup-ndenv   && setup-ndenv
autoload -Uz setup-stack   && setup-stack

autoload -Uz 256colortest
autoload -Uz man
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

autoload -Uz prompt_with_git && add-zsh-hook precmd prompt_with_git

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

if [[ $SHELL =~ "/zsh$" ]]; then
    restart-zsh () {
        echo "restart $SHELL"
        exec $SHELL -l
    }
fi

debug_echo "(end) .zshrc"

# vim: expandtab filetype=zsh foldmethod=marker shiftwidth=4 softtabstop=4 ts=4
