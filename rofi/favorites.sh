#!/usr/bin/env bash

# Launch selected favorite application
case "$1" in
    "Google Chrome")
        coproc ( google-chrome-stable >/dev/null 2>&1 )
        exit 0
        ;;
esac

# Header / prompt
echo -en "\0prompt\x1fFavorites\n"

# Entries format: <Name>\0icon\x1f<Icon>\x1fmeta\x1f<Search Terms>\n
echo -en "Google Chrome\0icon\x1fgoogle-chrome\x1fmeta\x1fchrome web browser internet\n"
