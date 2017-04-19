#!/bin/bash
SCRIPT=$(readlink -f $0)
#SCRIPT_DIR=`dirname $SCRIPT`
SCRIPT_NAME="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
SCRIPT_MD5=`md5sum $SCRIPT | cut -d ' ' -f 1`
echo "Script full:      $SCRIPT"
echo "Script basename:  $SCRIPT_NAME"
echo "Script MD5:       $SCRIPT_MD5"
