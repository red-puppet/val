#!/usr/bin/env bash
SCRIPT=$(readlink -f $0)
SCRIPTPATH=`dirname $SCRIPT`
echo "+-----------------------------------------+"
echo "+- MySQL Tables (DDL) MD5 hash generator -+"
echo "+-----------------------------------------+"
#
# Input database details
#
echo "DB username? "
read USER
PROMPT="DB password? "
while IFS= read -p "$PROMPT" -r -s -n 1 char
do
    if [[ $char == $'\0' ]]
    then
        break
    fi
    PROMPT='*'
    PASS+="$char"
done
echo ""
echo "DB hostname? "
read HOST
echo "DB database? "
read DB
echo ""
echo "User    : '$USER'"
echo "Pass    : (hidden) ${#PASS} characters long..."
echo "Host    : '$HOST'"
echo "DB      : '$DB'"
echo ""
#
# --- check before we start
#
echo "is this correct? (yes)"
read CORR
if [ "$CORR" != "yes" ]
then
    echo ""
    echo "OK. Please try again..."
    echo ""
    exit 1
fi
#
# --- Action
#
DATE=`date`;
PROCESSID=`printf '%s' "$DATE" | md5sum | cut -d ' ' -f 1`
echo ""
echo "Run ID  : '$PROCESSID'"
TARGETDIR="$SCRIPTPATH/$PROCESSID"
mkdir $TARGETDIR
echo "Created : '$TARGETDIR'"
echo "[1] Gathering data..."
TABLES_LIST="$TARGETDIR/tables.txt"
SQL1="
USE $DB;
SHOW TABLES;"
mysql -u$USER -p$PASS -D$DB -e "$SQL1" > "$TABLES_LIST"
tail -n +2 "$TABLES_LIST" > "$TABLES_LIST.tmp" && mv "$TABLES_LIST.tmp" "$TABLES_LIST"
echo "" >> "$TABLES_LIST"
TABLES=`cat "$TABLES_LIST"`
while read TAB; do
    echo "   - table: ${TAB}"
done < "$TABLES_LIST"
