#!/bin/bash
#
# install.sh        Script d'installation et de configuration
#               du portail captif
#
# by RALAIKOA Falinirina Raphael Joseph
#

# Adding file in the sudoers to allow www-data to execute
# some script that use sudo
PATH=/etc/sudoers.d
echo "www-data ALL=NOPASSWD: `pwd`/addUser.sh" > $PATH/captiveportal 

