#!/bin/bash

Filesystem=/dev/vda1
MinAvail=$[7*1024*1024]
MaxMtime=365
CleanDir="/usr/local/services/storageTransfer/history/ \
/home/cube/cube2.2/record/"

remove() {
    log $*
    rm -rf $*
}

log() {
    echo `date '+%Y-%m-%d %H:%M:%S'` $*
}

getAvail() {
    df -Th | grep $1 | awk '{print $5}' | awk -F 'G' '{print $1}'
}

log "start clean old files"
for dir in $CleanDir
do
    files=`find $dir -mtime +$MaxMtime -prune | egrep -v "^${dir}$"`
    SAVEIFS=$IFS
    IFS=$(echo -en "\n\b")
    for file in $files
    do  
        remove $file
    done
    # restore $IFS
    IFS=$SAVEIFS
done
log "clean old files done"

Avail=`getAvail ${Filesystem}`

if (($Avail < $MinAvail))
then
    log "insufficient available space"
    for dir in $CleanDir
    do  
        files=`ls -dltr ${dir}* | awk -F ' /' '{print "/" $2}'`
        SAVEIFS=$IFS
        IFS=$(echo -en "\n\b")
        for file in $files
        do  
            Avail=`getAvail ${Filesystem}`
            if (($Avail < $MinAvail))
            then
                remove $file
            fi  
        done
        # restore $IFS
        IFS=$SAVEIFS
    done
    log "disk cleanup done"
fi

log "bye bye"
