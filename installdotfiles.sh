########## Variables

symlinks="${HOME}/.zshrc
          ${HOME}/.bash_profile
          ${HOME}/.config/haskell-vim-now/plugins.vim
          ${HOME}/.config/haskell-vim-now/vimrc.local
          ${HOME}/.tmux.conf"                         # symlinks to be built

sourcedir="${HOME}/dotfiles"                          # dotfiles directory
sourcefiles="zshrc
          bash_profile
          config^haskell-vim-now^plugins.vim
          config^haskell-vim-now^vimrc.local
          tmux.conf"                                  # source files^folders

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

# while
#     [ -n "$x" ]
# do
#     set $x
#     current_x=$1
#     shift
#     x="$*"
#
#     set $y
#     current_y=$1
#     shift
#     y="$*"
#
#     set $z
#     current_z=$1
#     shift
#     z="$*"
#
#     echo "x=$current_x y=$current_y z=$current_z"
# done
