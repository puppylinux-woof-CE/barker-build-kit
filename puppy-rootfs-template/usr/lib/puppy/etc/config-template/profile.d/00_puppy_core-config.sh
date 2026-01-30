[ "$LC_ALL" == "" ] && export LC_ALL=C
[ "$LC_CTYPE" == "" ] && export LC_CTYPE=C

export PATH="/usr/lib/puppy/bin:/usr/lib/puppy/sbin:/usr/bin/overrides:/usr/sbin/overrides:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:/usr/bin/32:/usr/sbin/32:/usr/games:/root/my-applications/bin"


if [ "$LD_LIBRARY_PATH" == "" ]; then

	LD_LIBRARY_PATH32="/usr/local/lib32:/usr/local/libx32:/usr/local/lib/i386-linux-gnu:/usr/local/lib:/usr/lib32:/usr/libx32:/usr/lib/i386-linux-gnu:/usr/lib:/lib32:/libx32:/lib/i386-linux-gnu:/lib:/root/my-applications/lib"
	LD_LIBRARY_PATH64="/usr/local/lib64:/usr/local/lib/x86_64-linux-gnu:/usr/local/lib:/usr/lib64:/usr/lib/x86_64-linux-gnu:/usr/lib:/lib64:/lib/x86_64-linux-gnu:/lib:/root/my-applications/lib"
	LD_LIBRARY_PATH64_COMPAT="/usr/local/lib32:/usr/local/libx32:/usr/local/lib/i386-linux-gnu:/usr/lib32:/usr/libx32:/usr/lib/i386-linux-gnu:/lib32:/libx32:/lib/i386-linux-gnu"
		
	if [ -e /lib64/libc.so.6 ] || [ -e /lib/x86_64-linux-gnu/libc.so.6 ]; then #slackware64
		LD_LIBRARY_PATH="${LD_LIBRARY_PATH64}:${LD_LIBRARY_PATH64_COMPAT}"
	elif [ -e /libx32/libc.so.6 ] || [ -e /lib32/libc.so.6 ] || [ -e /lib/i386-linux-gnu/libc.so.6 ]; then #32-bit
		LD_LIBRARY_PATH="${LD_LIBRARY_PATH32}"
	else
	  if [ "$(uname -m | grep "64")" != "" ]; then
	   LD_LIBRARY_PATH="${LD_LIBRARY_PATH64}:${LD_LIBRARY_PATH64_COMPAT}"
	  else
	   LD_LIBRARY_PATH="${LD_LIBRARY_PATH32}"
	  fi
	fi
	
	LD_LIBRARY_PATH="/usr/lib/overrides:${LD_LIBRARY_PATH}"
	
	export LD_LIBRARY_PATH

fi
	
#[ -L /etc/localtime ] && export TZ="$(readlink /etc/localtime | sed -e 's,/usr/share/zoneinfo/,,' -e 's,Etc/,,')" 

#freedesktop base directory spec: standards.freedesktop.org/basedir-spec/latest/
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_DIRS=/usr/lib/puppy/share:/usr/local/share:/usr/share
export XDG_CONFIG_DIRS=/usr/lib/puppy/etc/xdg:/usr/local/etc/xdg:/usr/etc/xdg:/etc/xdg #v2.14 changed from /usr/etc
export XDG_CACHE_HOME=$HOME/.cache
export XDG_STATE_HOME="$HOME/.local/state"
#export XDG_RUNTIME_DIR=/run/runtime-${USER}

export XDG_VTNR=1

#[ ! -d $XDG_RUNTIME_DIR ] && mkdir -p $XDG_RUNTIME_DIR && chmod 0700 $XDG_RUNTIME_DIR

if [ -d /opt/vc ];then # this is for raspberry pi
	export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/opt/vc/lib"
	[ -d /opt/vc/bin ] && export PATH="$PATH:/opt/vc/bin"
fi

ulimit -c 0

if [ `id -gn` = `id -un` -a `id -u` -gt 14 ]; then
	umask 002
else
	umask 022
fi

export HISTSIZE=1000
export HISTFILE="$XDG_CONFIG_HOME"/bash-history
export HISTFILESIZE=2000
export HISTCONTROL=ignoredups

export LOGNAME=$USER
export INPUTRC=/etc/inputrc
export TERM=xterm

[ -d /usr/share/terminfo ] && export TERMINFO=/usr/share/terminfo


#this line gets edited by chooselocale script...

[ -f /etc/hostname ] && read HOSTNAME < /etc/hostname

export HOSTNAME

export PREFIX='/usr' #convenient to set this i think...

alias ls='ls --color=auto'

export LS_COLORS='bd=33:cd=33'

if [ "$WGET_ALIAS" == "" ]; then
 if [ "$(wget --help 2>&1 | grep "\-\-hsts\-file")" != "" ]; then
  alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"
  export WGET_ALIAS="1"
 fi
fi

if [ "$GTK_MODULES" != "" ] && [ "$(echo "$GTK_MODULES" | grep "canberra\-gtk\-module")" == "" ];then 
 export GTK_MODULES="$GTK_MODULES:canberra-gtk-module"
elif [ "$GTK_MODULES" == "" ]; then
 export GTK_MODULES="canberra-gtk-module"
fi
