if test -f /usr/share/cachyos-fish-config/cachyos-config.fish
    source /usr/share/cachyos-fish-config/cachyos-config.fish
end

function fish_greeting
end

# Catppuccin Mocha theme colors for Fish
set -g fish_color_normal cdd6f4
set -g fish_color_command 89b4fa
set -g fish_color_param f2cdcd
set -g fish_color_keyword f38ba8
set -g fish_color_quote a6e3a1
set -g fish_color_redirection f5e0dc
set -g fish_color_end fab387
set -g fish_color_comment 7f849c
set -g fish_color_error f38ba8
set -g fish_color_gray 6c7086
set -g fish_color_selection --background=313244
set -g fish_color_search_match --background=313244
set -g fish_color_operator 94e2d5
set -g fish_color_escape eb6f92
set -g fish_color_autosuggestion 6c7086

starship init fish | source

# >>> coursier install directory >>>
set -gx PATH "$PATH:/home/luna/.local/share/coursier/bin"
# <<< coursier install directory <<<

# Add ~/.local/bin to PATH (for agy and user binaries)
fish_add_path ~/.local/bin
