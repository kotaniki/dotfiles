
### POWERLEVEL9K SETTINGS ############################################################################

prompt_zsh_showStatus () {
    exist=`osascript -e 'exists application "Spotify"'`;

    if [ $exist = false ]; then
        return
    fi

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
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time zsh_showStatus time)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time time)
