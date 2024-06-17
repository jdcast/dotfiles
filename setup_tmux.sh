#!/bin/bash

# Define the tmux plugin directory
TMUX_PLUGIN_DIR="$HOME/.tmux/plugins"

# Create the plugins directory if it doesn't exist
mkdir -p "$TMUX_PLUGIN_DIR"

# Clone TPM (Tmux Plugin Manager) if it isn't already cloned
if [ ! -d "$TMUX_PLUGIN_DIR/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm "$TMUX_PLUGIN_DIR/tpm"
fi

# Reload tmux configuration
tmux source "$HOME/.tmux.conf"

# Install the plugins using TPM
"$TMUX_PLUGIN_DIR/tpm/bin/install_plugins"

echo "Tmux plugins installation and setup completed."
