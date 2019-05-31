#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
HOME_DIR="$DIR/home"
BACKUP_DIR="$HOME/bash-backups/"
FILES=`find ${HOME_DIR} -maxdepth 1 -exec echo {} \;`

# Loop over all files and folders and create symlinks in home folder
for fullpath in ${FILES}; do
 file=`basename ${fullpath}`
 dest="$HOME/$file"
 if [ "$file" != 'home' ]; then
   # Check if source exists, if so move to backup dir
   if [ -f $dest ]; then
     mkdir -p "$BACKUP_DIR"
     mv ${dest} ${BACKUP_DIR}
     echo "Moved $file to ~/bash-backups"
   fi;
   # Create symlinks for each file or dir in home dir
   ln -s $fullpath $dest
   echo "Created symlink for $file"
 fi;
done
