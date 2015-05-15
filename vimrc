"
" Daniel's .vimrc
"

set nocompatible    " Make Vim behave in a more useful way
" Add NeoBundle's runtime files to the runtime path
set runtimepath+=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))   " Initialise NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'   " Let NeoBundle manage NeoBundle

" Bundles {{{

" Colour Schemes {{{
NeoBundle 'jpo/vim-railscasts-theme'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'sjl/badwolf'
NeoBundle 'tomasr/molokai'
" }}}

NeoBundle 'bling/vim-airline'
NeoBundle 'bling/vim-bufferline'
NeoBundle 'ludovicchabant/vim-lawrencium'
NeoBundle 'mhinz/vim-signify'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'spf13/vim-autoclose'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
NeoBundle 'vim-scripts/SearchComplete'
" }}}

call neobundle#end()    " Finalise NeoBundle
filetype plugin indent on   " Enable file type detection

NeoBundleCheck  " Check for bundles that haven't been installed

" Key Bindings {{{
" Lazily enter command mode with ;
noremap ; :
let mapleader="," " Bind leader to ,
" Don't skip wraped lines while moving
nnoremap j gj
nnoremap k gk
" Indents lines that are selected in visual mode
vnoremap <Tab> >gv
" The opposite
vnoremap <S-Tab> <gv
" Toggle nohlsearch with leader + space
nnoremap <leader><space> :nohlsearch<CR>
" Open and close folds with Space
nnoremap <space> za
" Change buffer with Alt + left/right
nnoremap <A-left> :bp!<cr>
nnoremap <A-right> :bn!<cr>
" }}}

" General Settings {{{
set autoindent  " Copy indent from the previous line
set backspace=indent,eol,start  " Allow backspace over autoindent, end
" of line and start of insert
set clipboard=unnamedplus   " Use the OS's clipboard
set colorcolumn=72  " Highlight specified column(s)
set copyindent  " Copy structure of existing lines when pasting
set encoding=utf-8  " Set the character encoding to UTF-8
set formatoptions+=t    " Set how Vim formats text. For more info
" execute ':h fo-table'
set gdefault    " Always use the global flag when using substitute
set history=1000    " Number of commands to remember
set hlsearch    " Highlight all matches of a search
set ignorecase  " Ignore case in search patterns
set incsearch   " Search as we type
set laststatus=2  " Always show status line. Required for vim-airline
set list    " Useful for distinguishing spaces and tabs and for trailing
" white space
set listchars=tab:>.,trail:.,extends:#,nbsp:.   " Set what list shows.
" See "':h 'lcs'"
set mouse=a " Enable the use of the mouse
set nobackup
set noswapfile
set shiftround
set smartcase
set smarttab
set textwidth=79
set title
set undolevels=1000
set wildignore=*/tmp/*,*/bin/*,*.swp,*.bak,&.pyc,*.class
set wrap
" }}}

" UI Settings {{{
set cursorcolumn    " Highlight the column that the cursor is in
set cursorline  " Highlight the line that the cursor is on
set number  " Show line numbers
set showcmd " Show command on last line of the screen
set showmatch   " Show matching bracket while in insert mode
set wildmenu    " Enable enhanced completion and show possible matches

if has('gui_running')
    if has('win32')
        set guifont=Sauce_Code_Powerline:h10
    else
        set guifont=Source\ Code\ Pro\ for\ Powerline\ 10
    endif

    set guioptions-=L   " Remove left scrollbar
    set guioptions-=T   " Remove toolbar
    set guioptions-=m   " Remove menubar
    set guioptions-=r   " Remove right scrollbar
endif

if &t_Co>=256 || has("gui_running")
    colorscheme jellybeans
    syntax on   " Enable syntax highlighting
endif
" }}}

" Bundles Configuration {{{
let g:bufferline_echo=0   " Let vim-airline show our buffers
let g:airline_powerline_fonts=1   " Use fancy fonts. For more info see:
" https://github.com/bling/vim-airline#integrating-with-powerline-fonts
let g:airline#extensions#tabline#enabled=1
" }}}

" vim:foldmethod=marker:foldlevel=0
