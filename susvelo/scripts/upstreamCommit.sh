#!/usr/bin/env bash
(
set -e
PS1="$"

function changelog() {
    base=$(git ls-tree HEAD $1  | cut -d' ' -f3 | cut -f1)
    cd $1 && git log --oneline ${base}...HEAD
}
upstream=$(changelog Velocity)

updated=""
logsuffix=""
if [ ! -z "$upstream" ]; then
    logsuffix="$logsuffix\n\nupstream changes:\n$upstream)"
    if [ -z "$updated" ]; then updated="Velocity"; else updated="$updated/Velocity"; fi
fi
disclaimer="Upstream has released updates that appears to apply and compile correctly.\nThis update has not been tested"

if [ ! -z "$1" ]; then
    disclaimer="$@"
fi

log="${UP_LOG_PREFIX}update upstream ($updated)\n\n${disclaimer}${logsuffix}"

echo -e "$log" | git commit -F -

) || exit 1
