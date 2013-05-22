##### My (demuredemeanor) bashrc
# Uses tabstop=4; shiftwidth=4 tabs; foldmarker={{{,}}};
# http://github.com/demure/dotfiles

### Exports ### {{{
	### Universal Exports ### {{{
	export PROMPT_COMMAND=__prompt_command	# Func to gen PS1 after CMDs
	export CLICOLOR="YES"				# Color 'ls', etc.
	export EDITOR=vim

		### History Settings ### {{{
		export HISTSIZE=10000			# Size of shells hist
		export HISTFILESIZE=10000		# Size of Hist file
		export HISTCONTROL=ignoreboth:erasedups
		export HISTTIMEFORMAT="%F %T "	# Adds time to history
		export HISTIGNORE='ls:bg:fg:history'	# Hist ignores exact match
		### End History Settings ### }}}
	### End Universal Exports ### }}}

	### Universal Shopts ### {{{
	shopt -s histappend					# Appends hist on exit
	shopt -s cmdhist					# Save multi-line hist as one line
	shopt -s checkwinsize				# Update col/lines after commands

		### Completion ### {{{
		shopt -s autocd					# Can change dir without `cd`
		shopt -s cdspell				# Fixes minor spelling errors in cd paths
		shopt -s no_empty_cmd_completion	# Stops empty line tab comp
		shopt -s dirspell				# Tab comp can fix dir name typos
		### End Completion ### }}}
	### End Universal Shopts ### }}}

	### Fortune At Login ### {{{
	## Tests for fortune, root, interactive shell, and dumb term
	if [[ `command -v fortune` && $UID != '0' && $- == *i* && $TERM != 'dumb' ]]; then
		fortune -a
	fi
	### End Fortune ### }}}

	### Grep Options ### {{{
	## Colored Greps
	if echo hello | grep --color=auto l >/dev/null 2>&1; then
		GREP_OPTIONS+="--color=auto " GREP_COLOR='1;31'
	fi

	## Exclude annoying dirs
	## http://blog.sanctum.geek.nz/default-grep-options/
	if echo hello | grep --exclude-dir=a l >/dev/null 2>&1; then
		for PATTERN in .cvs .git .hg .svn; do
			GREP_OPTIONS+="--exclude-dir=$PATTERN "
		done
	fi
	export GREP_OPTIONS
	### End Grep Options ### }}}

	### TERM color ### {{{
	## Disabled, as forcing is kind of bad >_>
	## http://blog.sanctum.geek.nz/term-strings/
#	if [ -e /usr/share/terminfo/x/xterm-256color ]; then
#		export TERM='xterm-256color'
#	  else
#		export TERM='xterm-color'
#	fi
	### End TERM ### }}}
#### End Exports ### }}}

### Settings ### {{{
	### Universal Aliases ### {{{
	alias rmds='find . -name ".DS_Store" -depth -exec rm -i {} \;'
	alias bashrc='vim ~/.bashrc'
	alias filetree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/ /' -e 's/-/|/'"
	alias reset_display='export DISPLAY=$(tmux showenv|grep ^DISPLAY|cut -d = -f 2)'
	alias ed='ed -p:'

		### Git Aliases ### {{{
		alias git_force_reset='git fetch --all && git reset --hard origin/master'
		### End Git Aliases ### }}}
	### End Universal Aliases ### }}}

	### Universal Custom Commands ### {{{
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

	## Color man pages with less (is a `most` way too...)
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

	function git_files_hist() {
	git log --pretty=%h | while read hash; do git ls-tree -r $hash | awk '{print $4}'; done | sort -u
}
	###End Universal Commands ### }}}

	### Mac Settings ### {{{
	if [ $OSTYPE == 'darwin12' ]; then
		### Mac Sourcing ### {{{
		## Add git completion
		if [ -f `brew --prefix`/etc/bash_completion ]; then
			source `brew --prefix`/etc/bash_completion
		fi

		## Brew completion
		source `brew --prefix`/Library/Contributions/brew_bash_completion.sh
		### End Mac Sourcing ### }}}

		### Mac Aliases ### {{{
		alias google='ping -c 1 www.google.com && growlnotify -m "google pinged"'
		alias ardrestart='sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -restart -agent -menu'
		alias vi='vim'
		alias svi='sudo vi'
		alias fvreboot='sudo fdesetup authrestart'
		alias rebuild_open_with='/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -kill -r -domain local -domain user;killall Finder;echo "Open With has been rebuilt, Finder will relaunch"'

		## MPlayer
		alias mp='mplayer'
		alias mp2='mplayer2'
		alias np='sudo nice -n -10 mplayer'

		## Aliases for nicing
		alias fast='sudo nice -n -10'
		alias slow='nice -n 20'
		### End Mac Aliases ### }}}
	fi
	### End Mac Settings ### }}}

	### MA Settings ### {{{
	if [ $HOSTNAME == 'ma.sdf.org' ]; then
		export TZ=EST5EDT
		source /etc/bash_completion.d/git		## Add git completion

		alias bb='bboard'

			### SSH Agent ### {{{
			SSH_ENV="$HOME/.ssh/environment"

			function start_agent {
				echo "Initialising new SSH agent..."
				/usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
				echo succeeded
				chmod 600 "${SSH_ENV}"
				. "${SSH_ENV}" > /dev/null
				/usr/bin/ssh-add;
			}

			## Source SSH settings, if applicable
			if [ -f "${SSH_ENV}" ]; then
				. "${SSH_ENV}" > /dev/null
				ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
					start_agent;
				}
			  else
				start_agent;
			fi
		### End SSH Agent ### }}}
	fi
	### End MA Settings ### }}}

	### For pi ### {{{
	if [ $HOSTTYPE == 'arm' ]; then
		source /etc/bash_completion.d/git		## Add git completion
		alias ls='ls --color=auto'
		alias vi='vim'
		alias svi='sudo vim'
		alias vnc='vncserver :1 -geometry 1024x700 -depth 24'
	fi
	### End For pi ### }}}

	### For iOS ### {{{
	if [ $OSTYPE == 'darwin9' ]; then
		alias svi='sudo vi'
	fi
	### End For iOS ### }}}

	### For Netbook ### {{{
	if [ $OSTYPE == 'linux-gnu' ]; then
		alias ls='ls --color=auto'
	fi
	### End For Netbook ### }}}

	### For SDF Main Cluster ### {{{
	if [[ "$MACHTYPE" == "x86_64--netbsd" && "$OSTYPE" == "netbsd" ]]; then
		#LSCOLORS='exfxcxdxbxegedabagacad'
		export TZ=EST5EDT
		alias help='/usr/local/bin/help'
		#alias ls='colorls -G'
	fi
	### End For SDF Main Cluster ### }}}

	### Testing ### {{{
	## Fix tmux DISPLAY
	# "Yubinkim.com totally wrote this one herself"
	# "Run this script outside of tmux!"
#	for name in `tmux ls -F '#{session_name}'`; do
#		tmux setenv -g -t $name DISPLAY $DISPLAY #set display for all sessions
#	done
	### End Testing ### }}}
### End Settings ### }}}

### Big Functions ### {{{
	### This Changes The PS1 ### {{{
	function __prompt_command() {
		local EXIT="$?"							# This needs to be first
		PS1=""
		### Colors to Vars ### {{{
		## Inspired by http://wiki.archlinux.org/index.php/Color_Bash_Prompt#List_of_colors_for_prompt_and_Bash
		## Can unset with `unset -v {,B,U,I,BI,On_,On_I}{Bla,Red,Gre,Yel,Blu,Pur,Cya,Whi} RCol`
		RCol='\[\e[0m\]'	# Text Reset

		# Regular					Bold						Underline					High Intensity				BoldHigh Intensity			Background				High Intensity Backgrounds
		local Bla='\[\e[0;30m\]';	local BBla='\[\e[1;30m\]';	local UBla='\[\e[4;30m\]';	local IBla='\[\e[0;90m\]';	local BIBla='\[\e[1;90m\]';	local On_Bla='\e[40m';	local On_IBla='\[\e[0;100m\]';
		local Red='\[\e[0;31m\]';	local BRed='\[\e[1;31m\]';	local URed='\[\e[4;31m\]';	local IRed='\[\e[0;91m\]';	local BIRed='\[\e[1;91m\]';	local On_Red='\e[41m';	local On_IRed='\[\e[0;101m\]';
		local Gre='\[\e[0;32m\]';	local BGre='\[\e[1;32m\]';	local UGre='\[\e[4;32m\]';	local IGre='\[\e[0;92m\]';	local BIGre='\[\e[1;92m\]';	local On_Gre='\e[42m';	local On_IGre='\[\e[0;102m\]';
		local Yel='\[\e[0;33m\]';	local BYel='\[\e[1;33m\]';	local UYel='\[\e[4;33m\]';	local IYel='\[\e[0;93m\]';	local BIYel='\[\e[1;93m\]';	local On_Yel='\e[43m';	local On_IYel='\[\e[0;103m\]';
		local Blu='\[\e[0;34m\]';	local BBlu='\[\e[1;34m\]';	local UBlu='\[\e[4;34m\]';	local IBlu='\[\e[0;94m\]';	local BIBlu='\[\e[1;94m\]';	local On_Blu='\e[44m';	local On_IBlu='\[\e[0;104m\]';
		local Pur='\[\e[0;35m\]';	local BPur='\[\e[1;35m\]';	local UPur='\[\e[4;35m\]';	local IPur='\[\e[0;95m\]';	local BIPur='\[\e[1;95m\]';	local On_Pur='\e[45m';	local On_IPur='\[\e[0;105m\]';
		local Cya='\[\e[0;36m\]';	local BCya='\[\e[1;36m\]';	local UCya='\[\e[4;36m\]';	local ICya='\[\e[0;96m\]';	local BICya='\[\e[1;96m\]';	local On_Cya='\e[46m';	local On_ICya='\[\e[0;106m\]';
		local Whi='\[\e[0;37m\]';	local BWhi='\[\e[1;37m\]';	local UWhi='\[\e[4;37m\]';	local IWhi='\[\e[0;97m\]';	local BIWhi='\[\e[1;97m\]';	local On_Whi='\e[47m';	local On_IWhi='\[\e[0;107m\]';
		### End Color Vars ### }}}

		if [ $UID -eq "0" ];then
			PS1+="${Red}\h \W ->${RCol} "		# Set prompt for root
		  else
			local PSCol=""						# Declare so null var fine

			if [ $EXIT != 0 ]; then
				## can add `kill -l $?` to test to filter backgrounded
				PS1+="${Red}${EXIT}${RCol}"		# Add exit code, if non 0
			fi

			### Machine Test ### {{{
			if [ $HOSTNAME == 'moving-computer-of-doom' ]; then
				local PSCol="$Cya"				# For Main Computer
			elif [ $HOSTTYPE == 'arm' ]; then
				local PSCol="$Gre"				# For pi
			elif [ $HOSTNAME == 'ma.sdf.org' ]; then
				local PSCol="$Blu"				# For MetaArray
			elif [[ $MACHTYPE =~ arm-apple-darwin ]]; then
				local PSCol="$Gre"				# For iOS
			elif [ $MACHTYPE == 'i486-pc-linux-gnu' ]; then
				local PSCol="$BBla"				# For Netbook
			elif [[ "$MACHTYPE" == "x86_64--netbsd" && "$OSTYPE" == "netbsd" ]]; then
				local PSCol="$Yel"				# For Main Cluster
			  else
				PS1+="\h "						# Un-designated catch-all
			fi
			### End Machine Test ### }}}

			PS1+="${PSCol}\W${RCol}"			# Current working dir

			### Check Jobs ### {{{
			## Backgrounded running jobs
			local BKGJBS=$(jobs -r | wc -l | tr -d ' ')
			if [ ${BKGJBS} -gt 2 ]; then
				PS1+=" ${Red}[bg:${BKGJBS}]${RCol}"
			elif [ ${BKGJBS} -gt 0 ]; then
				PS1+=" ${Yel}[bg:${BKGJBS}]${RCol}"
			fi

			## Stopped Jobs
			local STPJBS=$(jobs -s | wc -l | tr -d ' ')
			if [ ${STPJBS} -gt 2 ]; then
				PS1+=" ${Red}[stp:${STPJBS}]${RCol}"
			elif [ ${STPJBS} -gt 0 ]; then
				PS1+=" ${Yel}[stp:${STPJBS}]${RCol}"
			fi
			### End Jobs ### }}}

			### Add Git Status ### {{{
			## Inspired by http://www.terminally-incoherent.com/blog/2013/01/14/whats-in-your-bash-prompt/
			local GStat="$(git status --porcelain -b 2>/dev/null | tr '\n' ':')"

			if [ "$GStat" ]; then
				### Fetch Time Check ### {{{
				local LAST=$(stat -c %Y $(git rev-parse --git-dir 2>/dev/null)/FETCH_HEAD 2>/dev/null)
				if [ "${LAST}" ]; then
					local TIME=$(echo $(date +"%s") - ${LAST} | bc)
					## Check if more than ten minutes since last
					if [ "${TIME}" -gt "600" ]; then
						git fetch 2>/dev/null
						PS1+=' +'
						## Refresh var
						local GStat="$(git status --porcelain -b 2>/dev/null | tr '\n' ':')"
					fi
				fi
				### End Fetch Check ### }}}

				### Test For Changes ### {{{
				local GChanges="$(echo ${GStat} | tr ':' '\n' | grep -v "^$" | grep -v "^\#\#" | wc -l | tr -d ' ')"
				if [ "$GChanges" == "0" ]; then
					local GitCol=$Gre
				  else
					local GitCol=$Red
				fi
				### End Test Changes ### }}}

				### Find Branch ### {{{
				local GBra="$(echo ${GStat} | tr ':' '\n' | grep "^##" | cut -c4- | grep -o "^[a-zA-Z]\{1,\}[^\.]")"
				if [ "$GBra" ]; then
					if [ "$GBra" == "master" ]; then
						local GBra="M"			# Because why waste space
					fi
				  else
					local GBra="ERROR"			# It could happen supposedly?
				fi
				### End Branch ### }}}

				PS1+=" ${GitCol}[$GBra]${RCol}"	# Add result to prompt

				### Find Commit Status ### {{{
					## Test Modified and Untracked for "0"
#					# local GDel="$(echo ${GStat} | tr ':' '\n' | grep -c "^[ MARC]D")"

				local GAhe="$(echo ${GStat} | tr ':' '\n' | grep "^##" | grep -o "ahead [0-9]\{1,\}" | grep -o "[0-9]\{1,\}")"
				if [ "$GAhe" ]; then
					PS1+="${Gre}↑${RCol}${GAhe}"	# Ahead
				fi

				## Needs a `git fetch`
				local GBeh="$(echo ${GStat} | tr ':' '\n' | grep "^##" | grep -o "behind [0-9]\{1,\}" | grep -o "[0-9]\{1,\}")"
				if [ "$GBeh" ]; then
					PS1+="${Red}↓${RCol}${GBeh}"	# Behind
				fi

				local GMod="$(echo ${GStat} | tr ':' '\n' | grep -c "^[ MARC]M")"
				if [ "$GMod" -gt "0" ]; then
					PS1+="${Pur}≠${RCol}${GMod}"	# Modified
				fi

				local GUnt="$(echo ${GStat} | tr ':' '\n' | grep -c "^\?")"
				if [ "$GUnt" -gt "0" ]; then
					PS1+="${Yel}?${RCol}${GUnt}"	# Untracked
				fi
				### End Commit Status ### }}}
			fi
			### End Git Status ### }}}

			PS1+=" ${PSCol}-> ${RCol}"			## End of PS1
		fi
	}

	### End PS1 ### }}}

#	### SSH Agent ### {{{
#	## Might move from MA to here
#	__ssh_agent() {
#
#	}
#	### End SSH Agent ### }}}
### End Big Functions ### }}}
