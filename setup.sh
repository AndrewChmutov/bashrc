#!/bin/bash

if [ -f ~/.bashrc ]; then
    echo -n ".bashrc exists. Do you want to delete it?[Y/n]: "
    read destiny
    if [ "$destiny" = "" ] || [ "$destiny" = "Y" ] || [ "$destiny" = "y" ]; then
        rm ~/.bashrc
    else
        echo "Exiting..."
        exit
    fi
fi

echo "Copying .bashrc to ~/.bashrc"
cp .bashrc ~/.bashrc
