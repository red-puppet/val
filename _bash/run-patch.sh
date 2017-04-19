#!/bin/bash
PATCH=$1
PATCH_BASENAME=$(basename $PATCH)
MD5=`md5sum $1 | cut -d ' ' -f 1`
MD5_FROM="'%MD5'"
MD5_TO="'$MD5'"
FILE_FROM="'%FILE'"
FILE_TO="'$PATCH_BASENAME'"
PREPARED=`cat $1 | sed s/$MD5_FROM/$MD5_TO/ | sed s/$FILE_FROM/$FILE_TO/`
# --- your user here
mysql -u root -p -D dev -e "$PREPARED"
#
# By running it like this:
# $ ./run-patch.sh patch-01.sql
#
# You should expect this output:
#
# +----------------------------------+-------------------+
# | my_patch_md5_hash                | my_patch_basename |
# +----------------------------------+-------------------+
# | 54b011c432601952740b33e150bd41d3 | patch-01.sql      |
# +----------------------------------+-------------------+
#

