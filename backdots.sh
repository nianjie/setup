#!/bin/sh
# assuming $HOME as working directory 
BACKUP_DIR_NAME=dotfiles
DOT_FILE_COUNTER=0

if [ -d ./$BACKUP_DIR_NAME ] ; then
	echo "Backup has been already done."
	echo "This process skips."
	return 1
fi

/bin/mkdir $BACKUP_DIR_NAME && {
  for DOT_FILE in .[!.]* ; do
    DOT_FILE_COUNTER=$(($DOT_FILE_COUNTER+1))
    if [ -f $DOT_FILE ] ; then
    	cp "$DOT_FILE" "./$BACKUP_DIR_NAME" >/dev/null 2>&1 \
	   || echo "$DOT_FILE: backup failed."
    fi
  done
  echo "All dotfiles: $DOT_FILE_COUNTER."
}
