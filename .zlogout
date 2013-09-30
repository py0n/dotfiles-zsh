UNAME=`uname`
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
