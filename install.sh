#!/bin/bash

# refer  spf13-vim bootstrap.sh`
LVIM_DIR=$HOME/l-vim
cd $LVIM_DIR

lnif() {
    if [ -e "$1" ]; then
        ln -sf "$1" "$2"
    fi
}

echo "Step1: backing up current vim config"
today=`date +%Y%m%d`
for i in $HOME/.vim $HOME/.vimrc $HOME/.gvimrc $HOME/.vimrc.bundles; do [ -e $i ] && [ ! -L $i ] && mv $i $i.$today; done
for i in $HOME/.vim $HOME/.vimrc $HOME/.gvimrc $HOME/.vimrc.bundles; do [ -L $i ] && unlink $i ; done


echo "Step2: setting up symlinks"
lnif $LVIM_DIR/vimrc $HOME/.vimrc
lnif $LVIM_DIR/vimrc.bundles $HOME/.vimrc.bundles
lnif "$LVIM_DIR/" "$HOME/.vim"

echo "Step4: compile YouCompleteMe"
echo "It will take a long time, just be patient!"
echo "If error,you need to compile it yourself"
echo "cd $LVIM_DIR/bundle/YouCompleteMe/ && bash -x install.sh --clang-completer"
cd $LVIM_DIR/bundle/YouCompleteMe/

if [ `which clang` ]   # check system clang
then
    bash -x install.sh --clang-completer --system-libclang   # use system clang
else
    bash -x install.sh --clang-completer
fi


#vim bk and undo dir
if [ ! -d /tmp/vimbk ]
then
    mkdir -p /tmp/vimbk
fi

if [ ! -d /tmp/vimundo ]
then
    mkdir -p /tmp/vimundo
fi

echo "Install Done!"
