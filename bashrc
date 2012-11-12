# Univeral Exports #
  export CLICOLOR="YES"
  export TERM='xterm-color'
  export HISTFILESIZE=10000
  export HISTSIZE=10000
  export HISTCONTROL=erasedups
  export EDITOR=vi
  shopt -s histappend

  ### this changes the PS1 ###
  if [ $HOSTNAME == 'moving-computer-of-doom' ]; then
    if [ $LOGNAME != 'root' ]; then
      export PS1="\`if [ \$? != 0 ]; then echo \[\e[31m\]\$?\[\e[0m\]; fi\`\[\e[36m\]\W -> \[\e[0m\]"
    else
      export PS1='\[\e[0;31m\]\W ->\[\e[m\] '
    fi
  elif [ $HOSTNAME == 'ma.sdf.org' ]; then
    if [ $LOGNAME != 'root' ]; then
      export PS1="\`if [ \$? != 0 ]; then echo \[\e[31m\]\$?\[\e[0m\]; fi\`\[\e[34m\]\W -> \[\e[0m\]"
    fi
  elif [[ $HOSTNAME =~ .*\.sdf\.org || $HOSTNAME == "otaku" ]]; then
    if [ $LOGNAME != 'root' ]; then
      export PS1="\`if [ \$? != 0 ]; then echo \[\e[31m\]\$?\[\e[0m\]; fi\`\[\e[33m\]\W -> \[\e[0m\]"
    fi
  else
    export PS1="\h \W -> "
  fi
  ### end PS1 ###

  ### this is for coloring greps ###
  if echo hello | grep --color=auto l >/dev/null 2>&1; then
    export GREP_OPTIONS='--color=auto' GREP_COLOR='1;31'
  fi
  ### ## end of coloring grep ## ###
# End Exports #

# Universal Aliases #
  alias rmds='find . -name ".DS_Store" -depth -exec rm -i {} \;'
  alias google='ping -c 1 www.google.com && growlnotify -m "google pinged"'
  alias bashrc='vim ~/.bashrc'
# end Universal Aliases #

# "Hand-Made" Commands #
# End Hand-Made Commands #

# For Mac
  if [ $OSTYPE == 'darwin12' ]; then
    # Mac Aliases
    alias ardrestart='sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -restart -agent -menu'
    alias manga='find ~/Desktop/manga|cut -d/ -f6-7|grep "\/[cov0-9][0-9]*$"'
    alias vi='vim'
    alias svi='sudo vi'

    ### MPlayer ###
      alias mp='mplayer'
      alias np='sudo nice -n -10 mplayer'
    ### End MPlayer ###

    ### view invisible things in finder on/off ###
      alias visible='defaults write com.apple.finder AppleShowAllFiles Yes; killall Finder'
      alias invisible='defaults write com.apple.finder AppleShowAllFiles No; killall Finder'
    ### end view invisible ###

    ### aliases for nicing ###
      alias fast='sudo nice -n -10'
      alias slow='nice -n 20'
    ### end nicing ###
    # End Mac Aliases

    ### fortune at term ###
    if [ `find $(echo $PATH | tr \: \  ) -name fortune` ]; then
      if [ $LOGNAME != 'root' ]; then
        echo `fortune -a`
      fi
    fi
    ### end fortune ###
  fi
# End For Mac #

# For SDF #
  if [[ $HOSTNAME =~ .*\.sdf\.org || $HOSTNAME == "otaku" ]]; then
    #LSCOLORS='exfxcxdxbxegedabagacad'
    export TZ=EST5EDT
    alias help='/usr/local/bin/help'
    #alias ls='colorls -G'
  fi
# End For sdf #
