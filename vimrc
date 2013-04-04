"### Commands at Start ###
	"### Needs to be First ###
	set nocompatible				"## Choose no compatibility with legacy vi
	"### End first ###

	set t_Co=256					"## Enable 256 colors in vim

	if has("syntax")
		syntax on					"## Adds vim color based on file
	endif

	"## Enable filetype settings
	if has("eval")
		filetype on
		filetype plugin on
"#		filetype indent on
	endif

	"## Enable folds
"#	if has("folding")
"#		set foldenable
"#		set foldmethod=indent
"#	endif

	"## Stop auto comment on new line
	autocmd FileType * setlocal formatoptions-=cro
	set shortmess+=T
"### End Commands at Start ###

"### Options ###
	set number						"## Adds line numbers
	set showcmd						"## Show incomplete cmds down the bottom
	set ruler						"## show possition in bottom right
	set autoread					"## Reload files changed outside vim
	set encoding=utf8				"## Sets encoding View
"#	set virtualedit=block,onemore	"## Cursor can move one past EOL, and free in Visual mode
	set virtualedit=all				"## Allow virtual editing, all modes.
	set showmatch					"## Show matching brackets/parenthesis
	set wildmenu					"## Show list instead of just completing
	set wildmode=list:longest,full	"## Command <Tab> completion, list matches, then longest common part, then all.
	set mouse=a						"## Enable mouse, all modes
	set backspace=indent,eol,start	"## Allow backspace in insert mode
	set scrolloff=3					"## Show next three lines scrolling
	set sidescrolloff=2				"## Show next two columns scrolling

	"### Show Hidden Chars ###
	set list						"## Shows certain hidden chars
	set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
	hi NonText ctermfg=darkgray		"## Makes trailing darkgray
	hi SpecialKey ctermfg=darkgray	"## Makes Leading darkgray
	"### End Hidden Chars ###

	"### Spelling ###
	set spell						"## spelling hilight on
"#	highlight SpellBad cterm=underline ctermfg=red
	hi SpellBad cterm=underline ctermbg=NONE
	"### End Spelling ###

	"### Tab Windows ###
	set hidden						"## Hides buffers, instead of closing, or forcing save
	"### End Tab Windows ###

	"### Tab Key Settings ###
	"## prefer tabs now...
	"#  set expandtab   "## use spaces, not tabs
	set tabstop=4					"## Set Tab length
	set shiftwidth=4				"## Affects when you press >>, << or ==. And auto indent.
	set smarttab					"## Insert Tabs start of line per to shiftwidth, not tabstop
	set autoindent					"## Always set autoindenting on
	set copyindent					"## Copy the previous indentation on autoindenting
	"### End Tab Key ###

	"### Searching ###
	set hlsearch					"## Highlight matches
	set incsearch					"## Incremental searching
	set ignorecase					"## Searches are case insensitive...
	set smartcase					"## ... unless they contain at least one capital letter
	"### End Searching ###

	"### Backup Settings ###
	set backup						"## backup on
	set backupdir=~/.backup/back
	set directory=~/.backup/swap	"## swap files
	"### End Backup Settings ###
"### End Options ###

"### Key Bindings ###
	let mapleader=","				"## Change the mapleader from '\\' to ','
	map ,h :noh<return>				"## ',h' will clear search hilights!

	"### Quickly edit/reload the vimrc file ###
	"##  maps the ,ev and ,sv keys to edit/reload .vimrc.
	nmap <silent> <leader>ev :e $MYVIMRC<CR>
	nmap <silent> <leader>sv :so $MYVIMRC<CR>
	"### End reload ###

	"### Paste Toggle, for stopping formating of pastes ###
	nnoremap <F2> :set invpaste paste?<CR>
	set pastetoggle=<F2>
	"### End Paste Toggle ###

	"### Vim Tab Window Keysbindings ###
"#	nnoremap <C-Left> :tabprevious<CR>
"#	nnoremap <C-Right> :tabnext<CR>
"#	nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
"#	nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>
	"### End Tab Window Keys ###

	"### Navigate Splits ###
	"## uses ',' key first
	map <leader>h :wincmd h<CR>
	map <leader>j :wincmd j<CR>
	map <leader>k :wincmd k<CR>
	map <leader>l :wincmd l<CR>

	map <leader> <Left> :wincmd h<CR>
	map <leader> <Down> :wincmd j<CR>
	map <leader> <Up> :wincmd k<CR>
	map <leader> <Right> :wincmd l<CR>
	"### End Navigate Splits ###
"### End Key Bindings ###

"### Plugins ###
	"### Adds Vundle ###
	set rtp+=~/.vim/bundle/vundle/
	call vundle#rc()
	"### End Vundle ###

	"### Bundles Load ###
	Bundle 'scrooloose/nerdtree'
	Bundle 'tpope/vim-repeat'
	"### End Bundles ###

	"### NERDtree config ###
	"## Starts NERDtree if no file is give to vim at start 
	autocmd vimenter * if !argc() | NERDTree | endif
	"### End NERDtree ###

	"### Vim Repeat Conf ###
	"## This is to make repeat work for plugins too
	silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)
	"### End Vim Repeat ###
"### End Plugins ###
