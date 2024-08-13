if status is-interactive
  # Commands to run in interactive sessions can go here

  # Call fetch program
  clear
  macchina
end

# Suppress greeter message
set fish_greeting

# Edit Path Variable
set --global -x PATH = $PATH:/home/james/.local/bin:/home/james/.bun/bin/

# Set aliases
# LunarVim:
alias nvim '~/.local/bin/lvim'

# ls shortcuts
alias l 'ls'
alias sl 'ls'

# Trash shortcut
alias trash 'mv --backup=numbered --force --target-directory=/home/james/.local/share/Trash/files/'

# Setup FZF
fzf --fish | source
set --global FZF_CTRL_T_OPTS '--no-multi 
--bind=tab:down,btab:up --pointer=→ --color=bg+:black'
set --global FZF_DEFAULT_OPTS '
  --color=fg:#ecdcc2,fg+:#ecdcc2,bg:#0E1416,bg+:#0E1416
  --color=hl:#3b5d82,hl+:#5485b9,info:#afaf87,marker:#6e4d73
  --color=prompt:#aa562e,spinner:#e6a53f,pointer:#e6a53f,header:#87afaf
  --color=border:#262626,label:#aeaeae,query:#d9d9d9
  --border="rounded" --border-label="" --preview-window="border-rounded" --prompt="> "
  --marker=">" --pointer="◆" --separator="─" --scrollbar="│"'

# Setup Zoxide
zoxide init fish | source

# Replace cd with zoxide
alias cd z

# Replace cat with bat
alias cat 'bat --theme ansi'

# Replace ls with eza
alias ls 'eza --color=always --long --git --no-filesize --icons=always --no-user --no-permissions -h'

# Set up redo with sudo
function sudo!
  eval sudo $history[1]
end

# Define Fish Prompt
function fish_prompt
  string join '' -- '
' (set_color yellow) $USER (set_color normal) \
  ' @ ' (set_color green) (prompt_pwd --full-length-dirs 2) \
  (set_color normal) (fish_git_prompt) '
' '↪ '
end

function fish_right_prompt
  string join '' -- (set_color blue) (date +%T)
end
