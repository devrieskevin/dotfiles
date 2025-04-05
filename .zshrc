unsetopt nomatch

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

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

if command -v symfony &>/dev/null; then
    eval "$(symfony completion)"
fi

alias lg='lazygit'
export LG_CONFIG_FILE="$HOME/.config/lazygit/config.yml"

eval "$(zoxide init zsh)"

alias cd="z"

eval "$(starship init zsh)"

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

eval "$(docker completion zsh)"

export LANG="en_US.UTF-8"

