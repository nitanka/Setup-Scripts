#!/bin/bash

#Determine the OS family
check_os()
{
    UNAME=$(uname | tr "[:upper:]" "[:lower:]")
    # If Linux, try to determine specific distribution
    if [ "$UNAME" == "linux" ]; then
        # If available, use LSB to identify distribution
        if [ -f /etc/lsb-release -o -d /etc/lsb-release.d ]; then
            export DISTRO=$(lsb_release -i | cut -d: -f2 | sed s/'^\t'//)
    #        echo $DISTRO
        # Otherwise, use release info file
        else
           export DISTRO=$(ls -d /etc/[A-Za-z]*[_-][rv]e[lr]* | grep -v "lsb" | cut -d'/' -f3 | cut -d'-' -f1 | cut -d'_' -f1)
        fi
    fi
    # For everything else (or if above failed), just use generic identifier
    [ "$DISTRO" == "" ] && export DISTRO=$UNAME
    unset UNAME
    eval $1="$DISTRO"
}

check_os OS
echo $OS
if [ OS == 'Ubuntu' -o OS == 'Debian' ]
then
	echo "Its Ubuntu"
fi

if [ OS == 'CentOS' -o OS == 'RedHat' ]
then
	echo "Its Redhat"
fi


