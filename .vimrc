
set nocompatible

filetype off

call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on
syntax on

let mapleader=","
let maplocalleader="\\"

"{{{ Auto Commands
" Automatically cd into the directory that the file is in
autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')
"Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif
"}}}

"Editing behaviour {{{

set showmode
set nowrap
set autoindent
"set undofile "Can enable it with vim 7.3
set ttyfast
set ruler
set backspace=indent,eol,start

set directory=~/.vim/.tmp,~/tmp,/tmp
set wildmenu
set wildmode=list:longest
set wildignore=*.swp,*.bak,*.pyc,*.class

set visualbell
set noerrorbells

set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Stuff related to search
set ignorecase
set smartcase
set hlsearch
set incsearch
set gdefault
set showmatch

set number
nnoremap <leader>N :setlocal number!<cr>

set cursorline

set mouse=a

set shortmess+=I
set clipboard=unnamed

nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>
" }}}

set foldmethod=marker

set nobackup
set noswapfile

set termencoding=utf-8
set encoding=utf-8
set lazyredraw
set laststatus=2
set cmdheight=2

nnoremap ; :

inoremap <silent> <Up> <Esc>gka
inoremap <silent> <Down> <Esc>gja

nnoremap <space> za
vnoremap <space> za

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap / /\v
vnoremap / /\v
nnoremap <leader><space> :noh<cr>

if &term =~ 'xterm' || &term =~ 'rxvt' || &term =~ 'screen' || &term =~ 'linux' || &term =~ 'gnome'
	imap <silent> <Esc>OA <Up>
	imap <silent> <Esc>OB <Down>
	imap <silent> <Esc>OC <Right>
	imap <silent> <Esc>OD <Left>
	imap <silent> <Esc>OH <Home>
	imap <silent> <Esc>OF <End>
	imap <silent> <Esc>[5~ <PageUp>
	imap <silent> <Esc>[6~ <PageDown>
endif

" Edit the vimrc file
nnoremap <silent> <leader>ev :e $MYVIMRC<CR>
nnoremap <silent> <leader>sv :so $MYVIMRC<CR>


" Clears the search register
nnoremap <silent> <leader>/ :nohlsearch<CR>

" Sudo to write
cnoremap w!! w !sudo tee % >/dev/null

" Jump to matching pairs easily, with Tab
nnoremap <Tab> %
vnoremap <Tab> %
"Pull word under cursor into LHS of a substitute (for quick search and replace)
nnoremap <leader>z :%s#\<<C-r>=expand("<cword>")<CR>\>#
"Keep search matches in the middle of the window and pulse the line when moving to them.
nnoremap n n:call PulseCursorLine()<cr>
nnoremap N N:call PulseCursorLine()<cr>

" NERDTree settings {{{
"Put focus to the NERD Tree with F3 (tricked by quickly closing it and
"immediately showing it again, since there is no :NERDTreeFocus command)
nnoremap <leader>n :NERDTreeClose<CR>:NERDTreeToggle<CR>
nnoremap <leader>m :NERDTreeClose<CR>:NERDTreeFind<CR>
nnoremap <leader>N :NERDTreeClose<CR>
"
" Store the bookmarks file
let NERDTreeBookmarksFile=expand("$HOME/.vim/NERDTreeBookmarks")
"
" Show the bookmarks table on startup
let NERDTreeShowBookmarks=1
"
" Show hidden files, too
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1
"
"Quit on opening files from the tree
let NERDTreeQuitOnOpen=1
"
" Highlight the selected entry in the tree
let NERDTreeHighlightCursorline=1
"
"Use a single click to fold/unfold directories and a double click to open files
let NERDTreeMouseMode=2
"Don't display these kinds of files
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$','\.o$', '\.so$', '\.egg$', '^\.git$' ]
"}}}

nnoremap <F2> :TagbarToggle<CR>


