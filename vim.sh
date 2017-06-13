#! /bin/sh

function mklink () {
  #Backup existed file
  if [ -f $2 ]
  then
    echo 'Existed file:' $2 'will be replaced'
    #mv -f $2 $2_bkp
  fi

  if [ -f $1 ]
  then
    ln -sf $1 $2
  fi
}

# Vim
if [ ! -d ~/.vim ]
then
  mkdir ~/.vim
fi

#mklink $PWD/vim/sessions ~/.vim/sessions
mklink $PWD/vimrc ~/.vimrc
mklink $PWD/vimshrc ~/.vimshrc
mklink $PWD/plug.vim ~/.vim/plug.vim
mklink $PWD/abbreviations.vim ~/.vim/abbreviations.vim
mklink $PWD/nop.vim ~/.vim/nop.vim
mklink $PWD/NERDTreeProjects ~/.NERDTreeProjects
mklink $PWD/NERDTreeBookmarks ~/.vim/NERDTreeBookmarks
mklink $PWD/UltiSnips ~/.vim/UltiSnips

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Tern
#mklink $PWD/config/tern-config.json ~/.tern-config

# eslint
#mklink $PWD/config/eslintrc.json ~/.eslintrc.json
