# config-files
## dotfiles respository for use with GNU Stow
.vimrc, .tmux.conf, etc.

NOTE: assumes tmux, cmake, python development headers, npm, c++ compiler and java are installed

1. sudo add-apt-repository ppa:jonathonf/vim
2. sudo apt update
3. sudo apt install vim 
4. install go: https://go.dev/doc/install
5. sudo apt install stow
6. git clone --recursive git@github.com:jdcast/config-files.git ~/config-files
7. cd config-files
8. git submodule update --init --recursive
9. cd ~/config-files/common/.vim/bundle/YouCompleteMe
10. python3 install.py --all 
11. cd ~/config-files  
12. stow -t ~ common
13. stow -t ~ `<machine-specific-folder-in-repo>`
14. vim
15. :PluginInstall 
16. chmod +x setup_tmux.sh
17. ./setup_tmux.sh
18. tmux source ~/.tmux.conf

### YouCompleteMe:
1. Further configure according to https://github.com/Briancbn/ros_vim_autocomplete#ycm-ros-configuration for ROS workspaces and added styling
