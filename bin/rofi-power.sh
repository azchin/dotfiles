#!/bin/sh
HELP="usage: $0 (--suspend|--restart|--shutdown)"

rofi_test() {
    prompt=$1
    [ $(echo "Yes\nNo" | rofi -dmenu -i -p "$1" -width 20) = "Yes" ]
}

case $1 in
    --suspend)
        rofi_test "Suspend the system?" && systemctl suspend
        ;;
    --restart)
        rofi_test "Restart the system?" && systemctl reboot
        ;;
    --shutdown)
        rofi_test "Shut down the system?" && systemctl poweroff
        ;;
    --hibernate)
        rofi_test "Hibernate the system?" && systemctl hibernate
        ;;
    *)
        echo "$HELP"
        exit 0
        ;;
esac
