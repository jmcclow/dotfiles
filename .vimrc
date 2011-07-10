" .vimrc by Jay McClow 2011
" This file is intended for personal use 
" but feel free to use any portion of it if you like
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
syntax on
colorscheme habilight
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set history=150		" keep 150 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else
  set autoindent		" always set autoindenting on
endif
" Preferences {{{1
set visualbell t_vb=
set number
set cursorline
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set hidden
set nojoinspaces
set wildmode=longest,list
" perl tidy webservice
" to use it:
" - exit insert mode
" - type the characters ',' 'p' and then 't'
" - profit
map ,pt :%! lwp-request -m POST https://tools.mediatemple.net/cgi-bin/perltidy/index.cgi<CR>
if has("autocmd")
  autocmd FileType html,css,scss,ruby,pml,yaml,coffee,vim setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab
  autocmd FileType markdown setlocal wrap linebreak nolist
  autocmd BufNewFile,BufRead *.rss setfiletype xml
  autocmd BufNewFile,BufRead Rakefile,Capfile,Gemfile,Termfile,config.ru setfiletype ruby
  autocmd FileType ruby :Abolish -buffer initialise initialize
  autocmd FileType vo_base :colorscheme solarized
endif
