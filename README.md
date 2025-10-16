<!--My (demuredemeanor) readme
# vim: set expandtab ts=4 sw=4: ## Since this is markdown
# https://notabug.org/demure/dotfiles
# legacy repo http://github.com/demure/dotfiles
-->

<!--
      ██                                            ██        
     ░██                                           ░░█        
     ░██  █████  ██████████  ██   ██ ██████  █████  ░   ██████
  ██████ ██░░░██░░██░░██░░██░██  ░██░░██░░█ ██░░░██    ██░░░░ 
 ██░░░██░███████ ░██ ░██ ░██░██  ░██ ░██ ░ ░███████   ░░█████ 
░██  ░██░██░░░░  ░██ ░██ ░██░██  ░██ ░██   ░██░░░░     ░░░░░██
░░██████░░██████ ███ ░██ ░██░░██████░███   ░░██████    ██████ 
 ░░░░░░  ░░░░░░ ░░░  ░░  ░░  ░░░░░░ ░░░     ░░░░░░    ░░░░░░  
      ██            ██     ████ ██  ██                        
     ░██           ░██    ░██░ ░░  ░██                        
     ░██  ██████  ██████ ██████ ██ ░██  █████   ██████        
  ██████ ██░░░░██░░░██░ ░░░██░ ░██ ░██ ██░░░██ ██░░░░         
 ██░░░██░██   ░██  ░██    ░██  ░██ ░██░███████░░█████         
░██  ░██░██   ░██  ░██    ░██  ░██ ░██░██░░░░  ░░░░░██        
░░██████░░██████   ░░██   ░██  ░██ ███░░██████ ██████         
 ░░░░░░  ░░░░░░     ░░    ░░   ░░ ░░░  ░░░░░░ ░░░░░░          
-->


## Demure's Dotfiles ##

This is a repo of my dot files, to help me keep them organized,  
and in-sync between computers and servers.  

I am in the *long* process of revamping all of my files, adding useful plugins,  
organizing snippets, improving comments, and trying making one conf work for  
all my systems (when/where possible).  

If you like what you see here, you may like my blog as well, [demu.red] -- though its been a while since I've posted.  


### Repo: ###
[tildegit] is now the primary location my dotfiles live.  

For historical purposes I still push into the [github] and [notabug] instance.  
This is mostly due to wanting to keep off github, [gitorious] dying, and notabug's webui becoming spotty.  



### Install: ###

Aside from installing by hand, you could use [GNU Stow].  
example:  

```
cd path_to_dotfiles_clone/GNU_Stow
stow -t ~ cli     ## main programs
stow -t ~ gui     ## gui programs
```

**NOTE:** `-t PATH` is used as the stow 'packages' are recessed.  


### Notable Setups: ###
* bash  
  * bashrc is now broken up into sub sourced files, much more orginzation potential  
  * Fancy PS1  
    * `dotconf` framework for override files  
* vim  
  * auto install Vundle if missing  
* tmux  
  * Nested instance binding/mode  
  * Binding to 'mark' window names, for workflow tracking  
  * Fancy status  
  * Dynamic padding removal from status, if too little space due to high window count  
* ssh  
  * <3 ssh conf file  


### Plans: ###

* One of these days I need to try zsh  

<BR>
**PS.** If you happen to have advice, I certainly would be interested in ways to improve my setup.  
If you do wish to contact me I am on IRC on sdf, tilde, and libera  


###### Last edit 2025-09-30 ######


[demu.red]: http://demu.red
[tildegit]: https://tildegit.org/demure/dotfiles
[github]: https://gitorious.org/demure/dotfiles
[gitorious]: https://en.wikipedia.org/wiki/Gitorious
[notabug]: https://notabug.org/demure/dotfiles/
[GNU Stow]: https://www.gnu.org/software/stow/
