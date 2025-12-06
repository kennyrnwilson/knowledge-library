#!/bin/bash

# Git Auto-Push Manager
# Manages the background file watcher for automatic git commits and pushes

WATCH_SCRIPT="./watch-and-push.sh"
PID_FILE="/tmp/git-auto-push.pid"

start_watcher() {
    if [ -f "$PID_FILE" ] && kill -0 $(cat "$PID_FILE") 2>/dev/null; then
        echo "Watcher is already running (PID: $(cat "$PID_FILE"))"
        return 1
    fi

    echo "Starting auto-push watcher..."
    nohup "$WATCH_SCRIPT" > /tmp/git-auto-push.log 2>&1 &
    echo $! > "$PID_FILE"
    echo "Watcher started (PID: $(cat "$PID_FILE"))"
    echo "Logs: /tmp/git-auto-push.log"
}

stop_watcher() {
    if [ ! -f "$PID_FILE" ]; then
        echo "Watcher is not running"
        return 1
    fi

    PID=$(cat "$PID_FILE")
    if kill -0 "$PID" 2>/dev/null; then
        echo "Stopping watcher (PID: $PID)..."
        kill "$PID"
        rm "$PID_FILE"
        echo "Watcher stopped"
    else
        echo "Watcher process not found, cleaning up PID file"
        rm "$PID_FILE"
    fi
}

status_watcher() {
    if [ -f "$PID_FILE" ] && kill -0 $(cat "$PID_FILE") 2>/dev/null; then
        echo "Watcher is running (PID: $(cat "$PID_FILE"))"
        echo "Logs: /tmp/git-auto-push.log"
        echo ""
        echo "Recent activity:"
        tail -n 10 /tmp/git-auto-push.log 2>/dev/null || echo "No logs yet"
    else
        echo "Watcher is not running"
        [ -f "$PID_FILE" ] && rm "$PID_FILE"
    fi
}

show_logs() {
    if [ -f /tmp/git-auto-push.log ]; then
        tail -f /tmp/git-auto-push.log
    else
        echo "No logs found. Watcher may not be running."
    fi
}

case "$1" in
    start)
        start_watcher
        ;;
    stop)
        stop_watcher
        ;;
    restart)
        stop_watcher
        sleep 1
        start_watcher
        ;;
    status)
        status_watcher
        ;;
    logs)
        show_logs
        ;;
    *)
        echo "Git Auto-Push Manager"
        echo ""
        echo "Usage: $0 {start|stop|restart|status|logs}"
        echo ""
        echo "Commands:"
        echo "  start   - Start the auto-push watcher"
        echo "  stop    - Stop the auto-push watcher"
        echo "  restart - Restart the auto-push watcher"
        echo "  status  - Check if watcher is running"
        echo "  logs    - Show live logs (Ctrl+C to exit)"
        exit 1
        ;;
esac
