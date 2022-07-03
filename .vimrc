set nocompatible

"========vim-plug setup========
" If vim-plug isn't installed, install it automatically
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin()
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-commentary'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive'
Plug 'townk/vim-autoclose'
Plug 'bling/vim-bufferline'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'bling/vim-airline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'preservim/nerdtree'
Plug 'morhetz/gruvbox'
Plug 'mileszs/ack.vim'
Plug 'machakann/vim-highlightedyank'
call plug#end()

" Autoinstall missing plugins on startup
autocmd VimEnter *
  \  if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall | q
  \| endif

" Basic Setup
if has('autocmd')
    filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
    syntax enable
endif

set number
set relativenumber

" Color scheme setup
if (has("termguicolors"))
    set termguicolors
endif
set background=dark
colorscheme gruvbox


" Airline setup
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

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
set shiftwidth=4
set softtabstop=4
set expandtab
" When tabs are used, make sure they display as 4 spaces instead of 8
set tabstop=4

" Make the command line to chars high to add space for long commands
" set cmdheight=2

set history=200		" keep 200 lines of command line history
set ttimeout		" time out for key codes
set ttimeoutlen=100	" wait up to 100ms after Esc for special key
set updatetime=2000

" Show @@@ in the last line if it is truncated.
set display=truncate

" When the cursor reaches the top or bottom, leave one line of padding
" set scrolloff=1

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
" map Q gq

" Reload current Vimscript file (inc. ~/.vimrc) with space-s.
map <leader>s :source %<CR>

" Remap Ctrl-w window commands to Leader-w for quicker access
nnoremap <Leader>w <C-w>

" Search sticking around can be annoying, so mapping :noh to a key is useful.
" However, on the next reload of the file the highlights will return.
nnoremap <C-n> :noh<CR>

" Map leader-n to focus NERDTree/open it if it is not, and leader-N to do the
" same while also bringing you to the current file
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <leader>N :NERDTreeFind<CR>

" Close the current buffer without closing the window/split
map <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" Revert with ":iunmap <C-U>".
inoremap <C-U> <C-G>u<C-U>
" Do the same with CTRL-W.
inoremap <C-W> <C-G>u<C-W>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Windows terminal takes away <C-v> for visual block, so swap it to use the
" leader key
nnoremap <Leader>v <C-v>

" au FileType go nmap <Leader>a <Plug>(go-imports)
" au FileType go nmap <Leader>r <Plug>(go-run)
" au FileType go nmap <Leader>b <Plug>(go-build)
" au FileType go nmap <Leader>t <Plug>(go-test)
" au FileType go nmap <Leader>tt <Plug>(go-test-func)
" au FileType go nmap <Leader>i <Plug>(go-info)
" au FileType go nmap <Leader>gd <Plug>(go-doc)
" au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
" au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
" au FileType go nmap gd <Plug>(go-def)

" Change cursor shape depending on mode
" Sorta hacky and probably needs tuning to work right outside of my work rig
if &term =~ '^xterm'
  let &t_EI = "\<Esc>[1 q"
  let &t_SI = "\<Esc>[5 q"
  let &t_SR = "\<Esc>[3 q"
  " &t_EI -> normal mode
  " &t_SI -> insert mode
  " &t_SR -> replace mode
  " 1 or 0 -> blinking block
  " 2 -> solid block
  " 3 -> blinking underscore
  " 4 -> solid underscore
  " Recent versions of xterm (282 or above) also support
  " 5 -> blinking vertical bar
  " 6 -> solid vertical bar
  " Reset the cursor to a vertical line on exit:
  autocmd VimLeave * :!echo -ne "\e[5 q"
endif

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
