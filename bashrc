##### My (demuredemeanor) bashrc
# http://github.com/demure/dotfiles

### Exports ###
	### Universal Exports ###
	export CLICOLOR="YES"				## Color 'ls', etc.
#	export TERM='xterm-color'
	export HISTFILESIZE=10000
	export HISTSIZE=10000
	export HISTCONTROL=ignoreboth:erasedups
	export EDITOR=vim
	shopt -s histappend
	### End Universal Exports ###

	### Grep Options ###
	GREP_OPTIONS=
	## Colored Greps
	if echo hello | grep --color=auto l >/dev/null 2>&1; then
		export GREP_OPTIONS="$GREP_OPTIONS --color=auto" GREP_COLOR='1;31'
	fi
	## Exclude annoying dirs
	## http://blog.sanctum.geek.nz/default-grep-options/
		for PATTERN in .cvs .git .hg .svn; do
			GREP_OPTIONS="$GREP_OPTIONS --exclude-dir=$PATTERN"
		done
export GREP_OPTIONS
	### End Grep Options ###

	## For term color.
	## Disabled, as forcing is kind of bad >_>
	## http://blog.sanctum.geek.nz/term-strings/
#	if [ -e /usr/share/terminfo/x/xterm-256color ]; then
#		export TERM='xterm-256color'
#	  else
#		export TERM='xterm-color'
#	fi

	### This Changes The PS1 ###
	######
	##Positioning the cursor
	##The following sequence sets the cursor position: \[\033[<row>;<column>f\]
	##The current cursor position can be saved using: \[\033[s\]
	##To restore a position, use the following sequence: \[\033[u\]
	##The following example uses these sequences to display the time in the upper right corner:
	##PS1=">\[\033[s\]\[\033[1;\$((COLUMNS-4))f\]\$(date +%H:%M)\[\033[u\]"
	##The environment variable COLUMNS contains the number of columns of the terminal. The above example substracts 4 from its value in order to justify the five character wide output of date at the right border.
	######
	######
	## Inspired by http://wiki.archlinux.org/index.php/Color_Bash_Prompt#List_of_colors_for_prompt_and_Bash
	# Reset
	RCol='\[\e[0m\]'	# Text Reset

	# Regular			Bold					Underline				High Intensity			BoldHigh Intensity	Background				High Intensity Backgrounds
	Bla='\[\e[0;30m\]';	BBla='\[\e[1;30m\]';	UBla='\[\e[4;30m\]';	IBla='\[\e[0;90m\]';	BIBla='\[\e[1;90m\]';	On_Bla='\e[40m';	On_IBla='\[\e[0;100m\]';
	Red='\[\e[0;31m\]';	BRed='\[\e[1;31m\]';	URed='\[\e[4;31m\]';	IRed='\[\e[0;91m\]';	BIRed='\[\e[1;91m\]';	On_Red='\e[41m';	On_IRed='\[\e[0;101m\]';
	Gre='\[\e[0;32m\]';	BGre='\[\e[1;32m\]';	UGre='\[\e[4;32m\]';	IGre='\[\e[0;92m\]';	BIGre='\[\e[1;92m\]';	On_Gre='\e[42m';	On_IGre='\[\e[0;102m\]';
	Yel='\[\e[0;33m\]';	BYel='\[\e[1;33m\]';	UYel='\[\e[4;33m\]';	IYel='\[\e[0;93m\]';	BIYel='\[\e[1;93m\]';	On_Yel='\e[43m';	On_IYel='\[\e[0;103m\]';
	Blu='\[\e[0;34m\]';	BBlu='\[\e[1;34m\]';	UBlu='\[\e[4;34m\]';	IBlu='\[\e[0;94m\]';	BIBlu='\[\e[1;94m\]';	On_Blu='\e[44m';	On_IBlu='\[\e[0;104m\]';
	Pur='\[\e[0;35m\]';	BPur='\[\e[1;35m\]';	UPur='\[\e[4;35m\]';	IPur='\[\e[0;95m\]';	BIPur='\[\e[1;95m\]';	On_Pur='\e[45m';	On_IPur='\[\e[0;105m\]';
	Cya='\[\e[0;36m\]';	BCya='\[\e[1;36m\]';	UCya='\[\e[4;36m\]';	ICya='\[\e[0;96m\]';	BICya='\[\e[1;96m\]';	On_Cya='\e[46m';	On_ICya='\[\e[0;106m\]';
	Whi='\[\e[0;37m\]';	BWhi='\[\e[1;37m\]';	UWhi='\[\e[4;37m\]';	IWhi='\[\e[0;97m\]';	BIWhi='\[\e[1;97m\]';	On_Whi='\e[47m';	On_IWhi='\[\e[0;107m\]';

	#####
	## For Main Computer
	if [ $HOSTNAME == 'moving-computer-of-doom' ]; then
		if [ $LOGNAME != 'root' ]; then
			export PS1="\`if [ \$? != 0 ]; then echo \[\e[31m\]\$?${RCol}; fi\`${Cya}\W -> ${RCol}"
		  else
			export PS1="${Red}\h \W ->${RCol} "
		fi

	## For pi
	elif [ $HOSTTYPE == 'arm' ]; then
		if [ $LOGNAME != 'root' ]; then
			export PS1="\`if [ \$? != 0 ]; then echo \[\e[31m\]\$?${RCol}; fi\`${Gre}\W -> ${RCol}"
		  else
			export PS1="${Red}\h \W ->${RCol} "
		fi

	## For MetaArray
	elif [ $HOSTNAME == 'ma.sdf.org' ]; then
		if [ $LOGNAME != 'root' ]; then
			export PS1="\`if [ \$? != 0 ]; then echo \[\e[31m\]\$?${RCol}; fi\`${Blu}\W -> ${RCol}"
		fi

	## For iOS
	elif [[ $MACHTYPE =~ arm-apple-darwin ]]; then
		if [ $LOGNAME != 'root' ]; then
			export PS1="\`if [ \$? != 0 ]; then echo \[\e[31m\]\$?${RCol}; fi\`${Gre}\W -> ${RCol}"
		  else
			export PS1="${Red}\h \W ->${RCol} "
		fi

	## For Netbook
	elif [ $MACHTYPE == 'i486-pc-linux-gnu' ]; then
		if [ $LOGNAME != 'root' ]; then
			export PS1="\`if [ \$? != 0 ]; then echo \[\e[31m\]\$?${RCol}; fi\`${BBla}\W -> ${RCol}"
		  else
			export PS1="${Red}\h \W ->${RCol} "
		fi

	## For Main Cluster
	elif [[ $HOSTNAME =~ .*\.sdf\.org || $HOSTNAME == "otaku" || $HOSTNAME == "sdf" || $HOSTNAME == "faeroes" ]]; then
		if [ $LOGNAME != 'root' ]; then
			export PS1="\`if [ \$? != 0 ]; then echo \[\e[31m\]\$?${RCol}; fi\`${Yel}\W -> ${RCol}"
		fi

	## If not designated, use catch-all
	else
	  export PS1="\h \W -> "
	fi
	
	unset -v {,B,U,I,BI,On_,On_I}{Bla,Red,Gre,Yel,Blu,Pur,Cya,Whi} RCol
	### End PS1 ###
### End Exports ###

### Settings ###
	### Universal Aliases ###
	alias rmds='find . -name ".DS_Store" -depth -exec rm -i {} \;'
	alias bashrc='vim ~/.bashrc'
	alias filetree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/ /' -e 's/-/|/'"
	alias reset_display='export DISPLAY=$(tmux showenv|grep ^DISPLAY|cut -d = -f 2)'
	alias ed='ed -p:'
	### End Universal Aliases ###

	### Universal Custom Commands ###
	## Extract most types of compressed files
	function extract {
		echo Extracting $1 ...
		if [ -f $1 ] ; then
			case $1 in
				*.tar.bz2)	tar xjf $1		;;
				*.tar.gz)	tar xzf $1		;;
				*.bz2)		bunzip2 $1		;;
				*.rar)		rar x $1		;;
				*.gz) 		gunzip $1		;;
				*.tar)		tar xf $1		;;
				*.tbz2)		tar xjf $1		;;
				*.tgz)		tar xzf $1		;;
				*.zip)		unzip $1		;;
				*.Z)		uncompress $1	;;
				*.7z)		7z x $1			;;
				*)			echo "'$1' cannot be extracted via extract()" ;;
			esac
		  else
			echo "'$1' is not a valid file"
		fi
	}

	## Color man pages with less (is a most way too...)
	man() {
		env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
		man "$@"
	}

	## For resyncing DISPLAY
	# used to refresh ssh connection for tmux
	# http://justinchouinard.com/blog/2010/04/10/fix-stale-ssh-environment-variables-in-gnu-screen-and-tmux
	function r() {
		if [[ -n $TMUX ]]; then
			NEW_DISPLAY=`tmux showenv|grep ^DISPLAY|cut -d = -f 2`
			if [[ -n $NEW_DISPLAY ]] && [[ -S $NEW_DISPLAY ]]; then
				DISPLAY=$NEW_DISPLAY
			fi
		fi
	}
	###End Universal Commands ###

	### Mac Settings ###
	if [ $OSTYPE == 'darwin12' ]; then
		### Mac Aliases ###
		alias google='ping -c 1 www.google.com && growlnotify -m "google pinged"'
		alias ardrestart='sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -restart -agent -menu'
		alias manga='find ~/Desktop/manga|cut -d/ -f6-7|grep "\/[cov0-9][0-9]*$"'
		alias vi='vim'
		alias svi='sudo vi'
		alias rebuild_open_with='/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -kill -r -domain local -domain user;killall Finder;echo "Open With has been rebuilt, Finder will relaunch"'

		## MPlayer
		alias mp='mplayer'
		alias mp2='mplayer2'
		alias np='sudo nice -n -10 mplayer'

		## View invisible things in finder on/off
		alias visible='defaults write com.apple.finder AppleShowAllFiles Yes; killall Finder'
		alias invisible='defaults write com.apple.finder AppleShowAllFiles No; killall Finder'

		## Aliases for nicing
		alias fast='sudo nice -n -10'
		alias slow='nice -n 20'
		### End Mac Aliases ###

		### Fortune At Term ###
		if [ `find $(echo $PATH | tr \: \  ) -name fortune` ]; then
			if [ $LOGNAME != 'root' ]; then
				echo `fortune -a`
			fi
		fi
		### End Fortune ###
	fi
	### End Mac Settings ###

	### For pi ###
	if [ $HOSTTYPE == 'arm' ]; then
		alias ls='ls --color=auto'
		alias vi='vim'
		alias svi='sudo vim'
		alias vnc='vncserver :1 -geometry 1024x700 -depth 24'
	fi
	### End For pi ###

	### For iOS ###
	if [ $OSTYPE == 'darwin9' ]; then
		alias svi='sudo vi'
	fi
	### End For iOS ###

	### For Netbook ###
	if [ $OSTYPE == 'linux-gnu' ]; then
		alias ls='ls --color'
	fi
	### End For Netbook ###

	### For SDF Main Cluster ###
	if [[ $HOSTNAME =~ .*\.sdf\.org || $HOSTNAME == "otaku" || $HOSTNAME == "sdf" ]]; then
		#LSCOLORS='exfxcxdxbxegedabagacad'
		export TZ=EST5EDT
		alias help='/usr/local/bin/help'
		#alias ls='colorls -G'
	fi
	### End For SDF Main Cluster ###

	### Testing ###
	## Fix tmux DISPLAY
	# "Yubinkim.com totally wrote this one herself"
	# "Run this script outside of tmux!"
#	for name in `tmux ls -F '#{session_name}'`; do
#		tmux setenv -g -t $name DISPLAY $DISPLAY #set display for all sessions
#	done
	### End Testing ###
### End Settings ###
