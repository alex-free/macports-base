#!/bin/bash

prefix=/opt/local

for arg
do
    case "$arg" in
        --prefix=*)
            prefix=${arg#--prefix=}
            ;;
    esac
done

cd "$(dirname "$0")"

if [[ ! -e "$prefix/share/macports/setupenv.bash" ]]; then
    echo "Error: did not find $prefix/share/macports/setupenv.bash. If you have a prefix instead of /opt/local, you need to specify it with:"
    echo "$0 --prefix=/your/prefix"
    exit 1
fi

if [[ ! -e "~/.bash_profile" ]]; then                     
    echo "export TERM=xterm-color" > ~/.bash_profile
    echo "export DISPLAY=:0.0" >> ~/.bash_profile
    echo "source $prefix/share/macports/setupenv.bash" >> ~/.bash_profile
    echo "Wrote $HOME/.bash_profile, starting  a new shell for it to apply..."
    bash
else
    echo "Existing $HOME/.bash_profile already exists, so it has not been replaced. If you wish to backup and replace your $HOME/.bash_profile:"
    echo "mv $HOME/.bash_profile $HOME/.bash_profile.orig"
    echo "$0"
fi
