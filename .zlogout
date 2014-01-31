# ログインシェルを抜ける際に實行される。

debug_echo "(begin) .zlogout"

() {
    local UNAME=`uname`
    case "$UNAME" in
        # http://cuviper.github.io/ssh-pageant/
        CYGWIN*)
        if [ -n "$SSH_PAGEANT_PID" ]; then
            ssh-pageant -q -k
        elif killall -0 ssh-pageant > /dev/null 2>&1; then
            sleep 3
            echo "kill ssh-pageant !"
        fi
        ;;
    *)
        ;;
    esac
}

debug_echo "(end) .zlogout"

# vim: expandtab filetype=zsh shiftwidth=4 softtabstop=4 ts=4
