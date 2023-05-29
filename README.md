# vi

vi stuff

## Installation

1. Clone this repo.

2. Symlink ~/.vimrc to the vimrc from this repo.

3. Install vim-plug:

```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

4. Make sure Node is installed.

5. Install ripgrep:

```
brew install ripgrep
```

or

```
sudo apt install ripgrep
```

6. Make sure prettier is installed globally:

```
npm i -g prettier
```

7. If using WSL2 (Windows), install powerline fonts:

a. [Download](https://github.com/powerline/fonts/blob/master/DejaVuSansMono/DejaVu%20Sans%20Mono%20for%20Powerline.ttf) the required .ttf file from the powerline github repo.
b. In Windows, open the file by double-clicking on it. It will show two options: Print and Install. Choose Install.
c. Right-click on the WSL terminal's title-bar; in settings for Ubuntu go into appearance, then set the font to "DejaVu Sans Mono for Powerline".

## Notes

Preferred shell FZF settings:

```
export FZF_DEFAULT_OPTS='--height=40% --preview="cat\ {}" --preview-window=up:50%:wrap'
```
