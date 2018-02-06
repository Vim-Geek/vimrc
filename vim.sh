#! /bin/sh

function mklink () {
  if [ -f $1 ] || [ -d $1 ]
  then
    if [ -f $2 ] || [ -d $2 ]
    then
      echo 'Existed file:' $2 'will be replaced'
      unlink $2
    fi

    ln -sf $1 $2
  fi
}

# Vim
if [ ! -d ~/.vim ]
then
  mkdir ~/.vim
fi

#mklink $PWD/vim/sessions ~/.vim/sessions
mklink $PWD/vimrc.vim ~/.vim/vimrc
mklink ~/.vim/vimrc  ~/.vimrc
yes | cp -f $PWD/vimrc.private.vim  ~/.vimrc.private
mklink $PWD/plug.vim ~/.vim/plug.vim
mklink $PWD/lib ~/.vim/lib
mklink $PWD/config/vimshrc ~/.vimshrc
mklink $PWD/config/NERDTreeProjects ~/.NERDTreeProjects
mklink $PWD/config/NERDTreeBookmarks ~/.vim/NERDTreeBookmarks
mklink $PWD/UltiSnips ~/.vim/UltiSnips

# curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Tern
#mklink $PWD/config/tern-config.json ~/.tern-config

# eslint
#mklink $PWD/config/eslintrc.json ~/.eslintrc.json
