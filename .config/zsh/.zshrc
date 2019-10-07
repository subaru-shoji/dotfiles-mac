# interactive shell settings.

bindkey -e

if [ -d $HOME/.config/zsh/zshrc.d ]; then
  for file in $HOME/.config/zsh/zshrc.d/*.zsh; do
    source $file
  done
fi

export ZPLUG_HOME=$HOME/.zplug
source $ZPLUG_HOME/init.zsh

zplug zsh-users/zsh-syntax-highlighting
zplug zsh-users/zsh-autosuggestions, defer:2  
zplug zsh-users/zsh-completions
zplug migutw42/zsh-fzf-ghq
zplug mollifier/cd-gitroot
zplug themes/simple, from:oh-my-zsh

if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
      echo; zplug install
  fi
fi
zplug load

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
