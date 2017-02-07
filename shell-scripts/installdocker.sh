#!/bin/bash

#########################################################################################################
# MANTAINER: Nitanka Gogoi                                                                              #
# SUPPORTED OS: Ubuntu                                                                                  #
# SUPPORTED KERNEL: 4.4.0-62-generic                                                                    #
# PRE-REWUISITE:                                                                                        #
#    - all docker dependencies as .deb packages should be present in DOCKER_DEB directory               #
#########################################################################################################

#PATH WHERE DOCKER .deb SHOULD BE PRESENT
DOCKER_DEB=/opt/packages/debian/docker

#OS WHERE DOCKER INSTALLATION IS SUPPORTED
REQUIRED_OS=14.04

#OBTAINING THE CURRENT UBUNTU RELEASE OF THE TARGET MACHINE
CURRENT_OS=`lsb_release -r | awk -F " " '{print $2}'`

#SUPPORTED KERNEL VERSION FOR DOCKER INSTALLATION
KERNEL=4.4.0-62-generic

#OBTAINING THE CURRENT UBUNTU KERNEL VERSION
CURRENT_KERNEL=`uname -r`

REQ=${REQUIRED_OS//[a-z.-]} #CONVERTING THE STRING FORMAT TO INTER BY REMOVING CHARACTERS AND '.'
PRE=${CURRENT_OS//[a-z.-]}  #CONVERTING THE STRING FORMAT TO INTER BY REMOVING CHARACTERS AND '.'



#CHECKING WHETHER THE REQUIRED OS VERSION IS INSTALLED ON THE SYSTEM OR NOT
#IF NOT PRESENT THE SCRIPT WILL EXIT, OTHERWISE CONTINUE TO THE NEXT STEP 
if [ $REQ -ne $PRE ]
then
    echo "The required os version is $REQUIRED_OS!"
    echo "The required os version is not found!!"
    exit -1
fi


REQ=${KERNEL//[a-z.-]} #CONVERTING THE STRING FORMAT TO INTER BY REMOVING CHARACTERS AND '.'
PRE=${CURRENT_KERNEL//[a-z.-]} #CONVERTING THE STRING FORMAT TO INTER BY REMOVING CHARACTERS AND '.'


#CHECKING WHETHER THE REQUIRED KERNEL VERSION IS PRESENT OR NOT
#IF NOT PRESENT THE SCRIPT WILL EXIT, OTHERWISE IT WILL TRY TO INSTALL DOCKER
if [ $REQ -lt $PRE ]
then
    echo "Kernel version is no supported"
    exit -1
else
    echo "Installing docker on the machine" 
    dpkg -i $DOCKER_DEB/*
    if [ $? -eq 0 ]
    then
        echo "Installation of docker successful....!"
        docker info #PROVIDE DOCKER INSTALLATION INFO, OUTPUT ABOUT THE SERVER AND CLIENT
        exit 0
   else
        echo "Installation was not successful"
        exit -1
    fi  
fi

