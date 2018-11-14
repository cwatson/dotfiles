# cgwatson's dotfiles
Repository to hold my dotfiles for various utilities and a few machines I do work on. There are 3 branches besides `master`:
1. `laptop` is merged into `master` since it is what I use 95% of the time. The system is [`CentOS 7`](https://www.centos.org).
2. `parietal` is a workstation running `CentOS 6`.
3. `desktop` is my personal desktop running `CentOS 6`. This is probably the most out-of-date.

## Prerequisites
There are really only 2 tools that are needed at the outset:
1. You need `git`, of course, to clone the repository in the first place.
2. I use [GNU stow](https://www.gnu.org/software/stow/) to "install" each set of dotfiles. For example, to link the [`Bash`](https://www.gnu.org/software/bash/)-related dotfiles:
``` bash
stow bash
```

## Tools with dotfiles
There are a few that are, e.g., only on the `master`/`laptop` branch, but the tools are:
* `bash` -- the shell
* [`dircolors`](https://www.gnu.org/software/coreutils/dircolors) -- colors in the terminal
* `git` -- version control system
* [`gitk`](https://git-scm.com/docs/gitk) -- a graphical repository browser for `git`
* [`octave`](https://www.gnu.org/software/octave) -- GNU software compatible with Matlab
* [`pentadactyl`](https://github.com/5digits/dactyl) -- add-on for Firefox with vim-like keybindings
* [`R`](https://cran.r-project.org) -- statistical programming language and environment
* [`rtv`](https://github.com/michael-lazar/rtv) -- Reddit Terminal Viewer
* [`tmux`](https://github.com/tmux/tmux) -- terminal multiplexer
* [`vim`](https://www.vim.org) -- the best text editor
* [`xpdf`](https://www.xpdfreader.com/) -- a lightweight PDF viewer
* [`xterm`](https://invisible-island.net/xterm/) -- terminal emulator for X
* [`zathura`](https://pwmt.org/projects/zathura/) -- a PDF viewer with vim-like keybindings
