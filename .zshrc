export ZSH=/Users/yuki.kotani/.oh-my-zsh
ZSH_THEME="powerlevel9k/powerlevel9k"

plugins=(git)
source $HOME/.zsh/powerlevel9k.zsh
source $ZSH/oh-my-zsh.sh

for f in language peco
do
  source $HOME/.zsh/${f}.zsh
done

