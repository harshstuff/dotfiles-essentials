
# Variables
######################################################

DOTFILES_HOME="$HOME/.homesick/repos/dotfiles"
DOTFILES_SCRIPTS="$DOTFILES_HOME/scripts"


# Import all dotfiles
######################################################

cat "$HOME/resources/ascii-art/dog"
echo "I loaded a profile just the way you like it..."
echo ""

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra,alias_completion}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Load custom dotfiles (machine specific and not in repo)
if [ -f "$HOME/.bash_overrides" ]; then
    source "$HOME/.bash_overrides"
fi

# Shell options
######################################################

# Colour promt
force_color_prompt=yes

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null
done


# Auto complete
######################################################

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall

# If possible, add tab completion for many more commands
[ -f /etc/bash_completion ] && source /etc/bash_completion

# Add git completion as of http://code-worrier.com/blog/autocomplete-git/
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh

# Personal bash completion files
for file in ~/bash_completion.d/* ; do
  source "$file"
done

# Misc (Ubuntu defaults)
######################################################

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Drush imports
######################################################

# Include Drush bash customizations.
if [ -f "$HOME/.drush/drush.bashrc" ] ; then
  source "$HOME/.drush/drush.bashrc"
fi

# Include Drush completion.
if [ -f "$HOME/.drush/drush.complete.sh" ] ; then
  source "$HOME/.drush/drush.complete.sh"
fi

# External includes
######################################################

# Include NVM.
if [ -f "$HOME/.nvm/nvm.sh" ] ; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

# RBEnv
if [ -f "$HOME/.rbenv/bin/rbenv" ] ; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# Drupal console
if [ -f "$HOME/.console/console.rc" ] ; then
  source "$HOME/.console/console.rc" 2>/dev/null
fi

# Pyenv
if [ -f "$HOME/.pyenv/bin/pyenv" ] ; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

# Go code
if [ -d "$HOME/gocode" ] ; then
  export GOPATH=$HOME/gocode
fi
