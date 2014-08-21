#!/bin/sh
# using sudoers to set up environment for sudo invocation.

# fist check if there is any varialbe related to proxy 
VARIABLE_NAME_LIST="http_proxy ftp_proxy https_proxy"
V_NAME=
PROXY_FLG=

for V_NAME in $VARIABLE_NAME_LIST ; do
    eval V_VALUE='$'$V_NAME
    if [ -n "$V_VALUE" ] ; then
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
sudo -k

# run inside sudo
sudo VARIABLE_NAME_LIST="http_proxy ftp_proxy https_proxy" sh <<"SCRIPT"
  V_NAME=
  PROXY_FLG=

  # already available?
for V_NAME in $VARIABLE_NAME_LIST ; do
    eval V_VALUE='$'$V_NAME
    if [ -n "$V_VALUE" ] ; then
	 PROXY_FLG="T"
    fi
done

  if [ "$PROXY_FLG" = "T" ] ; then
	 echo "The proxy environment has been set up already."
	 return 0
  else
	 echo "The proxy environment is goinig to set up."
	 if [ ! -d /etc/sudoers.d/ ] ; then
		echo "The system seems have not been configured for sudoers inclusion."
		echo "This script will not work without appropriate configuration."
		return 1
	 fi
	 if [ ! -f /etc/sudoers.d/00_custenv ] ; then
		 CURRENT_UMASK=$(umask)
		 umask 0226
		 echo "Defaults env_keep += \"$VARIABLE_NAME_LIST\"" > /etc/sudoers.d/00_custenv 
		 echo "The sudoers is appended."
		 umask $CURRENT_UMASK
	 fi
  fi

SCRIPT

