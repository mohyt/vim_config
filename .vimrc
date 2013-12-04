
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

" TagList settings {{{
nnoremap <leader>l :TlistClose<CR>:TlistToggle<CR>
nnoremap <leader>L :TlistClose<CR>

" quit Vim when the TagList window is the last open window
let Tlist_Exit_OnlyWindow=1         " quit when TagList is the last open window
let Tlist_GainFocus_On_ToggleOpen=1 " put focus on the TagList window when it opens
"let Tlist_Process_File_Always=1     " process files in the background, even when the TagList window isn't open
"let Tlist_Show_One_File=1           " only show tags from the current buffer, not all open buffers
let Tlist_WinWidth=40               " set the width
let Tlist_Inc_Winwidth=1            " increase window by 1 when growing

" shorten the time it takes to highlight the current tag (default is 4 secs)
" note that this setting influences Vim's behaviour when saving swap files,
" but we have already turned off swap files (earlier)
"set updatetime=1000

" the default ctags in /usr/bin on the Mac is GNU ctags, so change it to the
" exuberant ctags version in /usr/local/bin
let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'

" show function/method prototypes in the list
let Tlist_Display_Prototype=1

" don't show scope info
let Tlist_Display_Tag_Scope=0

" show TagList window on the right
let Tlist_Use_Right_Window=1

" }}}

" vim-flake8 default configuration
let g:flake8_max_line_length=120

" Conflict markers {{{
" highlight conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" shortcut to jump to next conflict marker
nnoremap <silent> <leader>c /^\(<\\|=\\|>\)\{7\}\([^=].\+\)\?$<CR>
" }}}

" Filetype specific handling {{{
" only do this part when compiled with support for autocommands
if has("autocmd")
    augroup invisible_chars "{{{
        au!

        " Show invisible characters in all of these files
        autocmd filetype vim setlocal list
        autocmd filetype python,rst setlocal list
        autocmd filetype ruby setlocal list
        autocmd filetype javascript,css setlocal list
    augroup end "}}}
	
	augroup vim_files "{{{
        au!

        " Bind <F1> to show the keyword under cursor
        " general help can still be entered manually, with :h
        autocmd filetype vim noremap <buffer> <F1> <Esc>:help <C-r><C-w><CR>
        autocmd filetype vim noremap! <buffer> <F1> <Esc>:help <C-r><C-w><CR>
    augroup end "}}}
	
	augroup python_files "{{{
        au!

        " This function detects, based on Python content, whether this is a
        " Django file, which may enabling snippet completion for it
        fun! s:DetectPythonVariant()
            let n = 1
            while n < 50 && n < line("$")
                " check for django
                if getline(n) =~ 'import\s\+\<django\>' || getline(n) =~ 'from\s\+\<django\>\s\+import'
                    set ft=python.django
                    "set syntax=python
                    return
                endif
                let n = n + 1
            endwhile
            " go with html
            set ft=python
        endfun
        autocmd BufNewFile,BufRead *.py call s:DetectPythonVariant()

        " PEP8 compliance (set 1 tab = 4 chars explicitly, even if set
        " earlier, as it is important)
        autocmd filetype python setlocal textwidth=78
        autocmd filetype python match ErrorMsg '\%>120v.\+'

        " But disable autowrapping as it is super annoying
        autocmd filetype python setlocal formatoptions-=t

        " Folding for Python (uses syntax/python.vim for fold definitions)
        "autocmd filetype python,rst setlocal nofoldenable
        "autocmd filetype python setlocal foldmethod=expr

        " Python runners
        autocmd filetype python noremap <buffer> <F5> :w<CR>:!python %<CR>
        autocmd filetype python inoremap <buffer> <F5> <Esc>:w<CR>:!python %<CR>
        autocmd filetype python noremap <buffer> <S-F5> :w<CR>:!ipython %<CR>
        autocmd filetype python inoremap <buffer> <S-F5> <Esc>:w<CR>:!ipython %<CR>

        " Toggling True/False
        autocmd filetype python nnoremap <silent> <C-t> mmviw:s/True\\|False/\={'True':'False','False':'True'}[submatch(0)]/<CR>`m:nohlsearch<CR>

        " Run a quick static syntax check every time we save a Python file
        autocmd BufWritePost *.py call Flake8()
    augroup end " }}}
endif
"}}}
	
" Python mode configuration ----------------------------------------------- {{{
" Don't run pylint on every save
let g:pymode_lint = 0
let g:pymode_lint_write = 0
let g:pymode_breakpoint_key = '<leader>B'
" }}}




