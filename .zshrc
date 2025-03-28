unsetopt nomatch

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
export PATH="/usr/local/sbin:$PATH"

# Xdebug aliases
alias xd_on='export XDEBUG_CONFIG="idekey=PHPSTORM"'
alias xd_off='unset XDEBUG_CONFIG'

# Add .local/bin to path env variable
export PATH="$HOME/.local/bin:$PATH"

# Global composer alias
export PATH="$HOME/.composer/vendor/bin:$PATH"

# ATOM OTAP username
export ATOM_OTAP_USER=kevin

# Prevent homebrew auto update
export HOMEBREW_NO_AUTO_UPDATE=1

# Volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# Uses single quotes to prevent variable expansion
alias dr='$(git rev-parse --show-toplevel)/vendor/bin/drush'

alias lg='lazygit'
export LG_CONFIG_FILE="$HOME/dotfiles/.config/lazygit/config.yml"

eval "$(zoxide init zsh)"

alias cd="z"

eval "$(starship init zsh)"

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export LANG="en_US.UTF-8"

