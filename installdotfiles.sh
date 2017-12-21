## TODO: bug such that original .zhrc was not deleted
##       the symlink was not created

########## Variables

symlinks="${HOME}/.zshrc
          ${HOME}/.bash_profile
          ${HOME}/.config/nvim/init.vim
          ${HOME}/.tmux.conf"                         # symlinks to be built

sourcedir="${HOME}/dotfiles"                          # where the dot files are

sourcefiles="zshrc
             bash_profile
             init.vim
             tmux.conf"                               # source files^folders

backupdir="${HOME}/dotfiles_old"                      # old dotfiles backup directory

##########

cd ${HOME}

# create backup dir
echo "Creating $backupdir for backups"
mkdir -p $backupdir
echo "...done"
#
## change to the dotfiles directory
echo "Changing to the $sourcedir"
cd $sourcedir
echo "...done"

## copy dotfiles in homedir to the backup directory
for sourcefile in $sourcefiles; do
    echo "Backing up a dotfile to $backupdir"
    cp $sourcedir/$sourcefile $backupdir/$sourcefile
done

## create the symlinks
while
  [ -n "$sourcefiles" ]
do
  set $sourcefiles
  sourcefile=$1
  shift
  sourcefiles="$*"

  set $symlinks
  symlink=$1
  shift
  symlinks="$*"

  echo "Creating symlink $sourcedir/$sourcefile -> $symlink"
  ln -s $sourcedir/$sourcefile $symlink
  echo "...done"

done
