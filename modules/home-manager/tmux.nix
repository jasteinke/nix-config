{ config, lib, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    historyLimit = 10000;
    keyMode = "vi";
    mouse = true;
    escapeTime = 0;
    baseIndex = 1;
    
    # Use Ctrl+Space as prefix (consistent with neovim leader key)
    prefix = "C-Space";
    
    extraConfig = ''
      # Enable true color support
      set-option -sa terminal-overrides ",xterm*:Tc"
      
      # Enable mouse support
      set -g mouse on
      
      # Start windows and panes at 1, not 0
      set -g base-index 1
      set -g pane-base-index 1
      set-window-option -g pane-base-index 1
      
      # Renumber windows when a window is closed
      set -g renumber-windows on
      
      # Increase repeat time for repeatable commands
      set -g repeat-time 1000
      
      # Status bar styling (solarized light theme to match neovim)
      set -g status-style 'bg=#fdf6e3 fg=#657b83'
      set -g status-left '#[bg=#268bd2,fg=#fdf6e3,bold] #S #[bg=#fdf6e3,fg=#268bd2]'
      set -g status-right '#[fg=#268bd2,bg=#fdf6e3]#[fg=#fdf6e3,bg=#268bd2] %Y-%m-%d %H:%M '
      set -g window-status-current-style 'bg=#268bd2 fg=#fdf6e3 bold'
      set -g window-status-style 'bg=#eee8d5 fg=#657b83'
      
      # Pane borders (solarized light)
      set -g pane-border-style 'fg=#93a1a1'
      set -g pane-active-border-style 'fg=#268bd2'
      
      # COLEMAK-DH NAVIGATION (consistent with i3 and neovim)
      # Pane navigation with Super+a prefix
      bind-key n select-pane -L  # left
      bind-key e select-pane -D  # down  
      bind-key i select-pane -U  # up
      bind-key o select-pane -R  # right
      
      # Pane splitting (intuitive symbols)
      bind-key | split-window -h -c "#{pane_current_path}"
      bind-key - split-window -v -c "#{pane_current_path}"
      
      # Window management
      bind-key c new-window -c "#{pane_current_path}"
      bind-key q kill-pane
      bind-key Q kill-window
      
      # Resize mode (similar to i3)
      bind-key r switch-client -T resize
      bind-key -T resize n resize-pane -L 5
      bind-key -T resize e resize-pane -D 5
      bind-key -T resize i resize-pane -U 5
      bind-key -T resize o resize-pane -R 5
      bind-key -T resize Escape switch-client -T root
      
      # Copy mode with vi keys (using 's' for insert like in neovim)
      bind-key s copy-mode
      bind-key -T copy-mode-vi 'v' send-keys -X begin-selection
      bind-key -T copy-mode-vi 'y' send-keys -X copy-selection-and-cancel
      
      # Colemak-DH movement in copy mode
      bind-key -T copy-mode-vi 'n' send-keys -X cursor-left
      bind-key -T copy-mode-vi 'e' send-keys -X cursor-down
      bind-key -T copy-mode-vi 'i' send-keys -X cursor-up
      bind-key -T copy-mode-vi 'o' send-keys -X cursor-right
      
      # Quick window switching (like i3 workspaces)
      bind-key 1 select-window -t 1
      bind-key 2 select-window -t 2
      bind-key 3 select-window -t 3
      bind-key 4 select-window -t 4
      bind-key 5 select-window -t 5
      bind-key 6 select-window -t 6
      bind-key 7 select-window -t 7
      bind-key 8 select-window -t 8
      bind-key 9 select-window -t 9
      
      # Session management
      bind-key S choose-session
      
      # Reload config
      bind-key R source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded!"
      
      # Clear screen (like in terminal)
      bind-key C-l send-keys 'C-l'
      
      # Synchronize panes toggle
      bind-key y setw synchronize-panes
    '';
  };
}