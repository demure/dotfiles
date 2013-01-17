# Univeral Exports #
  export CLICOLOR="YES"
#  export TERM='xterm-color'
  export HISTFILESIZE=10000
  export HISTSIZE=10000
  export HISTCONTROL=erasedups
  export EDITOR=vim
  shopt -s histappend

  if [ -e /usr/share/terminfo/x/xterm-256color ]; then
    export TERM='xterm-256color'
  else
    export TERM='xterm-color'
  fi

  ### this changes the PS1 ###
  ## for main computer
  if [ $HOSTNAME == 'moving-computer-of-doom' ]; then
    if [ $LOGNAME != 'root' ]; then
      export PS1="\`if [ \$? != 0 ]; then echo \[\e[31m\]\$?\[\e[0m\]; fi\`\[\e[36m\]\W -> \[\e[0m\]"
    else
      export PS1='\[\e[0;31m\]\W ->\[\e[m\] '
    fi
  ## for MetaArray
  elif [ $HOSTNAME == 'ma.sdf.org' ]; then
    if [ $LOGNAME != 'root' ]; then
      export PS1="\`if [ \$? != 0 ]; then echo \[\e[31m\]\$?\[\e[0m\]; fi\`\[\e[34m\]\W -> \[\e[0m\]"
    fi

  ## for iOS
  if [[ MACHTYPE =~ arm-apple-darwin ]]; then
    if [ $LOGNAME != 'root' ]; then
      export PS1="\`if [ \$? != 0 ]; then echo \[\e[31m\]\$?\[\e[0m\]; fi\`\[\e[36m\]\h \W -> \[\e[0m\]"
    else
      export PS1='\[\e[0;31m\]\h \W ->\[\e[m\] '
    fi

  ## for main cluster
  elif [[ $HOSTNAME =~ .*\.sdf\.org || $HOSTNAME == "otaku" || $HOSTNAME == "sdf" ]]; then
    if [ $LOGNAME != 'root' ]; then
      export PS1="\`if [ \$? != 0 ]; then echo \[\e[31m\]\$?\[\e[0m\]; fi\`\[\e[33m\]\W -> \[\e[0m\]"
    fi
  ## if not designated, use catch-all
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
  alias bashrc='vim ~/.bashrc'
  alias filetree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/ /' -e 's/-/|/'"
# end Universal Aliases #

# "Hand-Made" Commands #
# End Hand-Made Commands #

# For Mac
  if [ $OSTYPE == 'darwin12' ]; then
    # Mac Aliases
    alias google='ping -c 1 www.google.com && growlnotify -m "google pinged"'
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
