#!/bin/sh
# assuming $HOME as working directory 
BACKUP_DIR_NAME=dotfiles
DOT_FILE_COUNTER=0
FAILED_COUNTER=0
FAILED_FILE_LIST=""

if [ -d ./$BACKUP_DIR_NAME ] ; then
	echo "Backup has been already done."
	echo "This process skips."
	return 1
fi

/bin/mkdir $BACKUP_DIR_NAME && {
  for DOT_FILE in .[!.]* ; do
    if [ -f $DOT_FILE ] ; then
        DOT_FILE_COUNTER=$(($DOT_FILE_COUNTER+1))
    	cp "$DOT_FILE" "./$BACKUP_DIR_NAME" >/dev/null 2>&1  || \
		{ FAILED_COUNTER=$(($FAILED_COUNTER+1))         \
        	FAILED_FILE_LIST="$FAILED_FILE_LIST, $DOT_FILE"	; }
    fi
  done
  echo "All dotfiles: $DOT_FILE_COUNTER."
  if [ $FAILED_COUNTER -gt 0 ] ; then 
	  echo "$FAILED_COUNTER file(s) failed on backup: $FAILED_FILE_LIST."
  fi
}
