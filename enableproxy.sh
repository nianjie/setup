#!/bin/sh
# using sudoers to set up environment for sudo invocation.

# fist check if there is any varialbe related to proxy 
VARIABLE_NAME_LIST="http_proxy ftp_proxy https_proxy"
PROXY_FLG=

for PROXY_FLG in $VARIABLE_NAME_LIST ; do
    if [ -n "$PROXY_FLG" ] ; then
	 PROXY_FLG="T"
    fi
done

if [ "$PROXY_FLG" != "T" ] ; then 
    echo "There is no proxy environment in the sysmte."
    echo "This script will stop."
    return 1
fi

echo "This script requires superuser access to set up proxy environment for sudo invocation."
echo "You will be prompted for your password by sudo."

# clear any previous sudo permission
#sudo -k

# run inside sudo
#sudo sh <<SCRIPT
  
  # already available?
#  if [[ 
