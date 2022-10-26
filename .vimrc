" Don't try to be vi compatible
set nocompatible
" Helps force plugins to load correctly when it is turned back on below
filetype off
" TODO: Load plugins here (pathogen or vundle)


" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
Plugin 'VundleVim/Vundle.vim'
Plugin 'jacoborus/tender.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'andymass/vim-matchup'
" Plugin 'agentlewis/vim-dvorak'

" All of your Plugins must be added before the following line
call vundle#end()            " required

" Turn on syntax highlighting
syntax on
" For plugins to load correctly
filetype plugin indent on
" TODO: Pick a leader key
" let mapleader = ","
" Security
set modelines=0
" Show line relativenumbers
set relativenumber
" Show file stats
set ruler
" Blink cursor on error instead of beeping (grr)
set visualbell
" Encoding
set encoding=utf-8
" Whitespace
set wrap
set textwidth=79
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround
" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim
" Move up/down editor lines
nnoremap j gj
nnoremap k gk
" Allow hidden buffers
set hidden
" Rendering
set ttyfast
" Status bar
set laststatus=2
" Last line
set showmode
set showcmd
" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
" set ignorecase
" set smartcase
set showmatch
map <leader><space> :let @/=''<cr> " clear search
" Remap help key.
inoremap <F1> <ESC>:set invfullscreen<CR>a
nnoremap <F1> :set invfullscreen<CR>
vnoremap <F1> :set invfullscreen<CR>
nnoremap <F2> :set relativenumber! \| :set paste!<CR>

" Textmate holdouts
" Formatting
map <leader>q gqip
" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL

" Theme
if (has("termguicolors"))
 set termguicolors
endif

syntax enable
colorscheme tender
" Add lightline ColorScheme
let g:lightline = { 'colorscheme': 'tender' }

" silent! source "$HOME/.vim/bundle/vim-dvorak/plugin/dvorak.vim"
