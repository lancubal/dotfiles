source /usr/share/cachyos-fish-config/cachyos-config.fish

function fish_greeting
end

starship init fish | source

# >>> coursier install directory >>>
set -gx PATH "$PATH:/home/luna/.local/share/coursier/bin"
# <<< coursier install directory <<<
