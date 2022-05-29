#!/usr/bin/env bash
# pass login - Password Store Extension (https://www.passwordstore.org/)
# Copyright (C) 2017 Guangxiong Lin <hi@gxlin.org>
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

VERSION="0.1.0"

cmd_login_usage () {
    cat <<-_EOF
Usage: 

    $PROGRAM login [show] [--clip,-c] pass-name
        Show existing username and optionally put it on the clipboard.
        If put on the clipboard, it will be cleared in 45 seconds.
    $PROGRAM help
        Show this text.

More information may be found in the pass-login(1) man page.
_EOF
    exit 0
}

cmd_login_version () {
    echo $VERSION
    exit 0
}

cmd_login_show () {
    local opts clip=0
    opts="$($GETOPT -o c -l clip -n "$PROGRAM" -- "$@")"
    local err=$?
    eval set -- "$opts"
    
    while true; do 
        case $1 in
            -c|--clip) clip=1; shift;;
            --) shift; break;;
        esac
    done

    [[ $err -ne 0 || $# -ne 1 ]] && die "Usage: $PROGRAM $COMMAND [--clip,-c] pass-name"

    local path="${1%/}"
    local passfile="$PREFIX/$path.gpg"
    check_sneaky_paths "$path"
    [[ ! -f $passfile ]] && die "$path: passfile not found"

    local out contents
    contents=$($GPG -d "${GPG_OPTS[@]}" "$passfile")
    out=$(echo "$contents" | awk '/^(login|Login|Username|username):/ { print $2 }')
    [ -z "$out" ] && out=$path

    if [[ $clip -ne 0 ]]; then
        clip "$out" "login/username for $path"
    else
        echo "$out"
    fi

    exit 0
}

case "$1" in
    help|--help|-h) shift; cmd_login_usage "$@";;
    *) cmd_login_show "$@";;
esac

exit 0
