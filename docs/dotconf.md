<!--
##### My (demuredemeanor) list of my dotconf override settings
# vim: set expandtab ts=4 sw=4: ## Since this is markdown
# https://notabug.org/demure/dotfiles/
# legacy repo http://github.com/demure/dotfiles
-->

## dotconf ##
While my desire with my dotfiles is to have one set to rule them all, this is occasionally not possible due to:

* limitations of various config file tests
* there can be a need to disable certain niceties on systems
* some systems just have idiosyncrasies


### Overrides ###
The existence of these files will be checked in `${HOME}/.config/dotconf/`

|---------------|---------------------------------------------------|
| File          | Purpose                                           |
|---------------|---------------------------------------------------|
| no_git_prompt | disable subbash prompt from adding git to prompt, |
|               | which can be annoying on ssh keyless systems      |
| no_agent      | disable subbash export loading ssh/gpg ssh agent  |
| no_path       | disable subbash export changing PATH              |
|---------------|---------------------------------------------------|


### Extras ###
The existence of these files will be checked in `${HOME}/.config/dotconf/`

|---------------|-----------------------------|
| File          | Purpose                     |
|---------------|-----------------------------|
| prompt_date   | add date to PS1             |
| sudo_preserve | preserve user ENV with sudo |
|---------------|-----------------------------|


### bashrc.local ###
The subbash sourcer script will load either `~/.bashrc.local` or `~/.subbash/bashrc.local` if present for one off settings.
Additionally `~/.subbash/hosts/HOSTNAME_conf` files will be read on hostname match
