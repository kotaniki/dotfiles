# zplug
source ~/.zplug/init.zsh

# theme
zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme

# highlight
zplug "zsh-users/zsh-syntax-highlighting"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose