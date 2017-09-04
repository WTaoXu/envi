au BufRead,BufNewFile *.scala set filetype=scala  " use custom scala syntax in .scala files.
"set textwidth=72              " lines longer than 79 columns will be broken, in latex opinin set 66 characters is best.
set colorcolumn=73
set shiftround                " round indent to multiple of 'shiftwidth'
set nocompatible              " no compatible with vi
set autoindent                " autoindent
filetype plugin indent on     " use files in .vim/ftplugin/ and .vim/indent/
set expandtab
set nobackup                  " no backup files
set history=100               " num of command line history
set ruler                     " show the cursor position all the time
set showcmd                   " display incomplete commands
set incsearch                 " do incremental searching
syntax on                     " use color for code
set hlsearch                  " high light search
set t_Co=256                  " use 256 colors
"colorscheme desert256         " if no extral color set use desert color
colorscheme desert         " if no extral color set use desert color
"colorscheme molokai
set mouse=""                  " do not use mouse
"set mouse=a                   " use mouse
"set shiftwidth=2              " shiftwidth
"set tabstop=2                 " tabstop
set encoding=utf-8            " encoding
set fileencoding=utf-8
set fileencodings=utf-8,gbk,ucs-bom,gb18030,gb2312,cp936,big5,euc-jp,euc-kr,latin1
