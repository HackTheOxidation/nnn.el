# nnn.el

nnn.el is a wrapper for [nnn](https://github.com/jarun/nnn) that allows you to use `nnn` in a term buffer.
If you like vim-like keybindings and evil-mode you will love the speed and ergonomics of nnn.
It can serve as an alternative to dired.

## Installation

nnn.el can be installed through [MELPA](https://melpa.org).

It requires that you have `nnn` installed on your system.
See [Usage](https://github.com/jarun/nnn/wiki/Usage) on nnn's own wiki.

## Features

Currently, nnn is executed in a new term buffer where it start up in the current directory.
Once you quit nnn, the buffer is killed and automatically switches back to the previous buffer.

## Usage

Just execute nnn with the command:

```elisp
M-x nnn
```

## Goals

To provide a quality wrapper for nnn inside emacs.

## License

GNU GPL v3
