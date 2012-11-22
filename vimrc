" Needs to be First"
set nocompatible  "" choose no compatibility with legacy vi
" End first "

set t_Co=256

if &t_Co > 1
   syntax enable "" Adds vim color based on file
endif

" Commands at Start "
  "" stop auto comment on new line
    autocmd FileType * setlocal formatoptions-=cro
  set shortmess+=T
" End Commands at Start "

set number        "" adds line numbers
set showcmd
set ruler
set autoread
set encoding=utf8
set list
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set virtualedit=onemore
set spell
hi SpellBad cterm=underline ctermfg=red
set showmatch                   "" show matching brackets/parenthesis
set wildmenu                    "" show list instead of just completing
set wildmode=list:longest,full  "" command <Tab> completion, list matches, then longest common part, then all.

set mouse=a

" Tab Windows "
  set hidden       "" Hides buffers, instead of closing, or forcing save
" End Tab Windows"

" Tab Key Settings "
  set tabstop=2   "" a tab is two spaces
  set shiftwidth=2
  set expandtab   "" use spaces, not tabs
  set smarttab    "" insert tabs on the start of a line according to shiftwidth, not tabstop
  set autoindent  "" always set autoindenting on
  set copyindent  "" copy the previous indentation on autoindenting
" End Tab Key "

" Searching "
  set hlsearch    "" highlight matches
  set incsearch   "" incremental searching
  set ignorecase  "" searches are case insensitive...
  set smartcase   "" ... unless they contain at least one capital letter
" End Searching "

" backup Settings "
  set backup      "" backup on
  set backupdir=~/.backup/back
  set directory=~/.backup/swap "" swap files
" End backup Settings "

"" Key Bindings ""
  "" change the mapleader from '\\' to ','
  "" This allows custom keybindings
  let mapleader=","

  " Quickly edit/reload the vimrc file "
  ""  maps the ,ev and ,sv keys to edit/reload .vimrc.
    nmap <silent> <leader>ev :e $MYVIMRC<CR>
    nmap <silent> <leader>sv :so $MYVIMRC<CR>
  " End reload "

" Paste Toggle, for stopping formating of pastes
  nnoremap <F2> :set invpaste paste?<CR>
  set pastetoggle=<F2>
" End Paste Toggle

  " Vim Tab Window Keysbindings "
    "" nnoremap <C-Left> :tabprevious<CR>
    "" nnoremap <C-Right> :tabnext<CR>
    "" nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
    "" nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>
  " End Tab Window Keys "

  " Navigate Splits "
    "" uses ',' key first
    map <leader>h :wincmd h<CR>
    map <leader>j :wincmd j<CR>
    map <leader>k :wincmd k<CR>
    map <leader>l :wincmd l<CR>

    map <leader> <Left> :wincmd h<CR>
    map <leader> <Down> :wincmd j<CR>
    map <leader> <Up> :wincmd k<CR>
    map <leader> <Right> :wincmd l<CR>
  " End Navigate Splits "

" Adds Vundle "
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" End Vundle "

" Bundles Load "
  Bundle 'scrooloose/nerdtree'
  Bundle 'tpope/vim-repeat'
" End Bundles "


" NERDtree config "
  "" Starts NERDtree if no file is give to vim at start 
   autocmd vimenter * if !argc() | NERDTree | endif
" End NERDtree "

" Vim Repeat Conf "
  "" This is to make repeat work for plugins too
  silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)
" End Vim Repeat "

