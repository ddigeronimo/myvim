set nocompatible

"========vim-plug setup========
" If vim-plug isn't installed, install it automatically
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin()
Plug 'tpope/vim-surround'        " Easily add, change, and delete quotes, parens, tags, etc.
Plug 'airblade/vim-gitgutter'    " Show file changes in the file gutter
Plug 'tpope/vim-commentary'      " Function to comment/uncomment lines.
Plug 'easymotion/vim-easymotion' " Multichar jumping.
Plug 'junegunn/vim-easy-align'   " Align around characters of your choice.
Plug 'tpope/vim-git'             " Git filetype support.
Plug 'tpope/vim-fugitive'        " Better Git commands than :!git.
Plug 'townk/vim-autoclose'       " Automatically close quotes, parens, tags, etc.
Plug 'ctrlpvim/ctrlp.vim'        " Fuzzy file finder.
call plug#end()

" Autoinstall missing plugins on startup
autocmd VimEnter *
  \  if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall | q
  \| endif

filetype indent plugin on
syntax on

set ruler
set number
set relativenumber

" Allows you to leave a file in the background regardless of save status
" Also saves undo history even after saving and changing files
set hidden

" Show partial commands in the bottom right corner
set showcmd

" Wildcard completion for the command line
set wildmenu

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" Use visual bell instead of beeping when doing something wrong
set visualbell
" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=

" Indentation settings for using 4 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=4
set softtabstop=4
set expandtab

" Make the command line to chars high to add space for long commands
set cmdheight=2

set history=200		" keep 200 lines of command line history
set ttimeout		" time out for key codes
set ttimeoutlen=100	" wait up to 100ms after Esc for special key

" Show @@@ in the last line if it is truncated.
set display=truncate

" When the cursor reaches the top or bottom, leave one line of padding
set scrolloff=1

" Add ** to the path to enable :find to search recursively/tab complete.
" This works best when you launch Vim from within your project directory.
set path+=**

" Search highlighting and inc. search (searches as you type)
set hlsearch
if has('reltime')
  set incsearch
endif

" In many terminal emulators the mouse works just fine.  By enabling it you
" can position the cursor, Visually select and scroll with the mouse.
" Only xterm can grab the mouse events when using the shift key, for other
" terminals use ":", select text and press Esc.
if has('mouse')
  if &term =~ 'xterm'
    set mouse=a
  else
    set mouse=nvi
  endif
endif

" Set leader to space
let mapleader = " "

" Don't use Ex mode, use Q for formatting.
" Revert with ":unmap Q".
map Q gq

" Reload .vimrc with space-s.
map <leader>s :source ~/.vimrc<CR>

" Hitting Ctrl-w for split window functions is a hard stretch for me.
" Remapping it to leader w makes it easier.
nnoremap <Leader>w <C-w>

" Search sticking around can be annoying, so mapping :noh to a key is useful.
" However, on the next reload of the file the highlights will return.
nnoremap <Leader>n :noh<CR>

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" Revert with ":iunmap <C-U>".
inoremap <C-U> <C-G>u<C-U>

" Do the same with CTRL-W.
inoremap <C-W> <C-G>u<C-W>

" Map pressing j & k quickly (in any order) exit insert mode
inoremap jk <Esc> 
inoremap kj <Esc> 

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Put these in an autocmd group, so that you can revert them with:
" ":augroup vimStartup | au! | augroup END"
augroup vimStartup
    au!
    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid, when inside an event handler
    " (happens when dropping a file on gvim) and for a commit message (it's
    " likely a different one than last time).
    autocmd BufReadPost *
      \ if line("'\"") >= 0 && line("'\"") <= line("$") && &filetype != "gitcommit"
      \ |   execute ("normal `\"")
      \ | endif
augroup END

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
	  \ | wincmd p | diffthis
endif
