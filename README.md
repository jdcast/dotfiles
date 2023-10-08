# config-files
.vimrc, .tmux.conf, etc.

1. install tmux: https://github.com/tmux/tmux/wiki/Installing
2. install tmux plugin manager: https://github.com/tmux-plugins/tpm
3. install vundle: https://stackoverflow.com/questions/25444680/unknown-function-vundlebegin -> top answer
    ```
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    ```
4. install coloscheme `solarized`: 
    ```
    cd ~/.vim/bundle
    git clone git@github.com:altercation/vim-colors-solarized.git
    ```
5. install YouCompleteMe
    1. Follow official instructions: https://github.com/ycm-core/YouCompleteMe#linux-64-bit and use option `--all` if possible (if not, fall back to `--clangd-completer`) (may require other installations such as Go, JDK, etc.)
    2. further configure according to https://github.com/Briancbn/ros_vim_autocomplete#ycm-ros-configuration for ROS workspaces and added styling
