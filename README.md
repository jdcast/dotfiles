# dotfiles
## dotfiles respository for use with GNU Stow

1. git clone --recursive git@github.com:jdcast/dotfiles.git ~/dotfiles
2. `chmod +x setup_dotfiles.sh`
3. `./setup_dotfiles.sh <machine-specific-folder-in-repo>`
    1. You'll have to add an appropriate stow folder for your device if one is not present

### Stow
#### Workflow
1. stow -t ~ common
2. stow -t ~ `<machine-specific-folder-in-repo>`

### YouCompleteMe
1. Further configure according to https://github.com/Briancbn/ros_vim_autocomplete#ycm-ros-configuration for ROS workspaces and added styling
