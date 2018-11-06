# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/yuki.kotani/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git)

# source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

### POWERLEVEL9K SETTINGS ############################################################################

prompt_zsh_showStatus () {
    local color='%F{white}'
    state=`osascript -e 'tell application "Spotify" to player state as string'`;
    if [ $state = "playing" ]; then
        artist=`osascript -e 'tell application "Spotify" to artist of current track as string'`;
        track=`osascript -e 'tell application "Spotify" to name of current track as string'`;

        echo -n "  %{$color%}\uf1bc $artist - $track"; 

    fi
}

# prompt_zsh_showStatus () {
#     state=`osascript -e 'tell application "Spotify" to player state as string'`;
#     if [ $state = "playing" ]; then
#         artist=`osascript -e 'tell application "Spotify" to artist of current track as string'`;
#         track=`osascript -e 'tell application "Spotify" to name of current track as string'`;

#         echo -n "$artist - $track";
#     fi
# }

zsh_internet_signal(){
  #source on quality levels - http://www.wireless-nets.com/resources/tutorials/define_SNR_values.html
  #source on signal levels  - http://www.speedguide.net/faq/how-to-read-rssisignal-and-snrnoise-ratings-440
	local signal=$(airport -I | grep agrCtlRSSI | awk '{print $2}' | sed 's/-//g')
  local noise=$(airport -I | grep agrCtlNoise | awk '{print $2}' | sed 's/-//g')
  local SNR=$(bc <<<"scale=2; $signal / $noise")

  local net=$(curl -D- -o /dev/null -s http://www.google.com | grep HTTP/1.1 | awk '{print $2}')
  local color='%F{yellow}'
  local symbol="\uf197"

  # Excellent Signal (5 bars)
  if [[ ! -z "${signal// }" ]] && [[ $SNR -gt .40 ]] ; 
    then color='%F{blue}' ; symbol="\uf1eb" ;
  fi

  # Good Signal (3-4 bars)
  if [[ ! -z "${signal// }" ]] && [[ ! $SNR -gt .40 ]] && [[ $SNR -gt .25 ]] ; 
    then color='%F{green}' ; symbol="\uf1eb" ;
  fi

  # Low Signal (2 bars)
  if [[ ! -z "${signal// }" ]] && [[ ! $SNR -gt .25 ]] && [[ $SNR -gt .15 ]] ; 
    then color='%F{yellow}' ; symbol="\uf1eb" ;
  fi

  # Very Low Signal (1 bar)
  if [[ ! -z "${signal// }" ]] && [[ ! $SNR -gt .15 ]] && [[ $SNR -gt .10 ]] ; 
    then color='%F{red}' ; symbol="\uf1eb" ;
  fi

  # No Signal - No Internet
  if [[ ! -z "${signal// }" ]] && [[ ! $SNR -gt .10 ]] ; 
    then color='%F{red}' ; symbol="\uf011";
  fi

  if [[ -z "${signal// }" ]] && [[ "$net" -ne 200 ]] ; 
    then color='%F{red}' ; symbol="\uf011" ;
  fi

  # Ethernet Connection (no wifi, hardline)
  if [[ -z "${signal// }" ]] && [[ "$net" -eq 200 ]] ; 
    then color='%F{blue}' ; symbol="\uf197" ;
  fi

  echo -n "%{$color%}$symbol " # \f1eb is wifi bars
}

# #POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
# #POWERLEVEL9K_SHORTEN_DELIMITER=""
# #POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"
# POWERLEVEL9K_PROMPT_ON_NEWLINE=true
# POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=''
# POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=''
# POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=''
# POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=''
# POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{blue}\u256D\u2500%F{white}"
# POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{blue}\u2570\uf460%F{white} "
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(root_indicator dir dir_writable_joined)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(command_execution_time vcs background_jobs_joined time_joined)
# POWERLEVEL9K_VCS_MODIFIED_BACKGROUND="clear"
# POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND="clear"
# POWERLEVEL9K_VCS_MODIFIED_FOREGROUND="yellow"
# POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND="yellow"
# POWERLEVEL9K_DIR_HOME_BACKGROUND="clear"
# POWERLEVEL9K_DIR_HOME_FOREGROUND="blue"
# POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="clear"
# POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="blue"
# POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND="clear"
# POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND="red"
# POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="clear"
# POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="white"
# POWERLEVEL9K_ROOT_INDICATOR_BACKGROUND="red"
# POWERLEVEL9K_ROOT_INDICATOR_FOREGROUND="white"
# POWERLEVEL9K_STATUS_OK_BACKGROUND="clear"
# POWERLEVEL9K_STATUS_OK_FOREGROUND="green"
# POWERLEVEL9K_STATUS_ERROR_BACKGROUND="clear"
# POWERLEVEL9K_STATUS_ERROR_FOREGROUND="red"
# POWERLEVEL9K_TIME_BACKGROUND="clear"
# POWERLEVEL9K_TIME_FOREGROUND="cyan"
# POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='clear'
# POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='magenta'
# POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND='clear'
# POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND='green'

POWERLEVEL9K_MODE='nerdfont-complete'

# Double-Lined Prompt
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_RPROMPT_ON_NEWLINE=false
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{014}╭%F{cyan}"
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{014}\u2570%F{cyan}\uF460%F{073}\uF460%F{109}\uF460%f "

# SHORTEN
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"

# NVM
POWERLEVEL9K_NVM_BACKGROUND='28'
POWERLEVEL9K_NVM_FOREGROUND='15'

#OS Icon
POWERLEVEL9K_OS_ICON_BACKGROUND="white"
POWERLEVEL9K_OS_ICON_FOREGROUND="blue"

# Time
#POWERLEVEL9K_TIME_FORMAT="\UF43A %D{%H:%M  \UF133  %m.%d.%y}"
POWERLEVEL9K_TIME_FORMAT="\UF43A %D{%H:%M}"
POWERLEVEL9K_TIME_BACKGROUND='white'
POWERLEVEL9K_TIME_FOREGROUND='black'

# CommandExecutionTime
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='red'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='yellow'

# Side
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon root_indicator dir nvm vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time zsh_showStatus time)

plugins=(git)

source $ZSH/oh-my-zsh.sh


# peco
function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

function find_cd() {
    cd "$(find . -type d | peco)"  
}
alias fc="find_cd"

#export PATH="$HOME/.rbenv/:$PATH"
#eval "$(rbenv init -)"
#export PATH="$PATH:/Users/yuki.kotani/Library/Android/sdk/platform-tools"
#export PATH="$HOME/.rbenv/bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"