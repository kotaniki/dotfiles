# zplug
source ~/.zplug/init.zsh

# theme
zplug romkatv/powerlevel10k, as:theme, depth:1

# highlight
zplug "zsh-users/zsh-syntax-highlighting"

# git
# zplug "plugins/git",   from:oh-my-zsh
# zplug "peterhurford/git-aliases.zsh"

# completion
zplug "zsh-users/zsh-completions"

# enhancd
zplug "b4b4r07/enhancd", use:init.sh

# suggestion
# 現在のテーマだと見えない
# zplug "zsh-users/zsh-autosuggestions"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose