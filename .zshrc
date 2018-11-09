# autoload -Uz compinit && compinit

# ZSH_THEME="powerlevel9k/powerlevel9k"

# plugins=(git)
# source $HOME/.zsh/powerlevel9k.zsh
# source $ZSH/oh-my-zsh.sh

export HISTFILE=${HOME}/.zsh_history
export SAVEHIST=100000

for f in powerlevel9k zplug language peco alias
do
  source $HOME/.zsh/${f}.zsh
done