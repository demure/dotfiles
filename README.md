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

**NOTE:** While I am currently continuing to maintain the [github] repo,  
<strike>I have moved to [gitorious].</strike> Repo link in top comments, of most comment-able confs.  
With the death of gitorious, I am currently using [notabug].  

You may like my blog as well, [demu.red].  


### Install: ###

Aside from installing by hand, you could use [GNU Stow].  
example:  

```
cd path_to_dotfiles_clone/GNU_Stow
stow -t ~ main    ## main programs
stow -t ~ laptop  ## gui programs
```

**NOTE:** `-t PATH` is used as the stow 'packages' are recessed.  


### Improved: ###

* I think my vimrc has improved a good deal ^__^  
    * It will now auto install Vundle if missing, and create undo/backup/swap paths **8APR2013**  
    * Now updated for new vundle syntax **16NOV2014**  
* My PS1 is much simpl.... Err, neater? **25APR2013**  
    * The machine test is much more consise, and the git check quite useful  
* Bashrc is now broken up into sub sourced files, much more orginzation potential **26MAY2013**  
* <strike>Moved to the spectrwm window manager **~18MAY2014** </strike>  
* Killed off my laptop's useless menu key, and now have a `SUPER_R` **21MAY2014**  
* Added test and variable for missing items in bash **12NOV2014**  
* Decided to declare my `$PATH` with everything I want **12NOV2014**  
* Added a MISSING_ITEMS to check if disabled things disabled **13NOV2014**  
* Added [GNU Stow] for installing **06MAR2014**  
* Added mutt with multiple accounts, using offlineimap, not-much, and msmtp **25AUG2015**  
* Moved to i3 window manager<strike>, and set up a sweet lemonbar</strike> **30JAN2016**  
* Got around to updating stow dir to reflect current software. (still needs some work) **16NOV2018**  
* Spent a lot of time refactory my prompt command's git **14MAR2019**  
* Had to get fancy with i3 volume bindings as HDMI output caused sink changes **18JUN2019**  
* Moved from lemonbar to polybar. Things are a lot cleaner and easier to tinker with now. **14JUL2019**  
    * lemonbar files moved to `retired_confs` dir.


### Plans: ###

* One of these days I need to try zsh  

<BR>
**PS.** If you happen to have advice, I certainly would be interested in ways to improve my setup.  
If you do wish to contact me, I guess [twitter] is an ok way (spam mitigation)  

###### Last edit 15JUl2019 ######


[github]: https://gitorious.org/demure/dotfiles
[gitorious]: https://gitorious.org/demure/dotfiles
[notabug]: https://notabug.org/demure/dotfiles/
[GNU Stow]: https://www.gnu.org/software/stow/
[twitter]: https://twitter.com/demure
[demu.red]: http://demu.red
