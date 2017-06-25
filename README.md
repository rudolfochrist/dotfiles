# My dotfiles

Nothing special....

## Installation

    git clone <dotfiles-repo> ~/.dotfiles
    alias homegit="GIT_DIR=~/.dotfiles/.git GIT_WORK_TREE=~ git" 
    homegit checkout -- .   # checkout all files
    <do stuff when error occurs>
    homegit config --local status.showUntrackedFiles no
    rm README.md   # We don't need that in $HOME
    homegit update-index --assume-unchanged README.md  # doesn't show the README deletion in git status.
     
After that you can add new files like

    homegit add .somerc
    homegit commit -m "Add .somerc"
    
See the branches for different platforms. 

.cf
https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
http://chneukirchen.org/blog/archive/2013/01/a-grab-bag-of-git-tricks.html
