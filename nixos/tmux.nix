{ ... }:

{
  programs.tmux = {
    enable = true;
    extraConfig = ''
      # Set term color
      set-option -g default-terminal "screen-256color"
      set-option -sa terminal-overrides ',screen-256color:RGB'

      # Rebinding prefix to C-a
      set -g prefix C-a
      unbind C-b

      # Ensure that we can send Ctrl-A to other apps
      bind C-a send-prefix

      # Setting the delay between prefix and command
      set -s escape-time 1

      # Set the base index for windows to 1 instead of 0
      set -g base-index 1

      # Set the base index for panes to 1 instead of 0
      setw -g pane-base-index 1

      # Key bindings
      bind r source-file ~/.tmux.conf \; display "Reloaded!"

      # splitting panes with | and -
      bind \\ split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"

      # Quick window selection
      bind -r C-h select-window -t :-
      bind -r C-l select-window -t :+

      # Pane resizing panes with Prefix H,J,K,L
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5

      # mouse support - set to on if you want to use the mouse
      set -g mouse on

      # set colors for the active window
      setw -g window-status-current-style fg=white,bold,bg=yellow

      #Status line left side to show Session:window:pane
      set -g status-left-length 40
      set -g status-left "#[fg=black]Session: #S #[fg=colour243]#I #[fg=black]#P | "

      # Status line right side - 21-Oct 13:37
      set -g status-right "#[fg=black]%d %b %R"

      # Center the window list in the staus line
      set -g status-justify centre

      # enable activity alerts
      setw -g monitor-activity on
      set -g visual-activity on

      # enable vi keys.
      setw -g mode-keys vi

      bind-key -r h select-pane -L
      bind-key -r j select-pane -D
      bind-key -r k select-pane -U
      bind-key -r l select-pane -R

      bind-key -T copy-mode-vi 'v' send-keys -X begin-selection
      bind-key -T copy-mode-vi 'y' send-keys -X copy-selection

      # better yanking
      unbind p
      bind p paste-buffer

      # shortcut for synchronize-panes toggle
      bind C-s set-window-option synchronize-panes

      # copy
      bind-key -n -T copy-mode-vi Enter send-keys -X copy-pipe 'xclip -i -sel p -f | xclip -i -sel c'
      bind-key -n -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe 'xclip -i -sel p -f | xclip -i -sel c'
    '';
  };
}
