# autoload -Uz compinit && compinit

# ZSH_THEME="powerlevel9k/powerlevel9k"

# plugins=(git)
# source $HOME/.zsh/powerlevel9k.zsh
# source $ZSH/oh-my-zsh.sh

export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000
setopt hist_ignore_dups
setopt EXTENDED_HISTORY

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

setopt inc_append_history
setopt share_history

# 部分一致補完
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'

for f in powerlevel9k zplug language peco alias
do
  source $HOME/.zsh/${f}.zsh
done
