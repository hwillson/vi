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
sudo apt install ripgrep
```

## Notes

Preferred shell FZF settings:

```
export FZF_DEFAULT_OPTS='--height=40% --preview="cat\ {}" --preview-window=up:50%:wrap'
```
