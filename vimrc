set nocompatible

"OCaml tools
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"
set rtp^="/home/dylan/.opam/system/share/ocp-indent/vim"

"Vundle stuff
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-sensible'
Plugin 'scrooloose/syntastic'

call vundle#end()

"Basic configs
filetype plugin indent on
syntax enable
set colorcolumn=90
set number
let mapleader=" "
"Reload vimrc with space-s
map <leader>s :source ~/.vimrc<CR>
set hidden
set history=100
autocmd BufWritePre * :%s/\s\+$//e
nnoremap <silent> <Esc> :nohlsearch<Bar>:echo<CR>
set showmatch
set laststatus=2
map <C-n> :NERDTreeToggle<CR>

"Stuff for configuring Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_ocaml_checkers = ['merlin']
let g:syntastic_html_checkers = ['w3']
