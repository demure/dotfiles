""""" My (demuredemeanor) .vimrc
"" Uses tabstop=4; shiftwidth=4; foldmarker={{{,}}};
""""""""vim: set tabstop=4 shiftwidth=4:
"" Above is an attempt at a modeline, which seems to have a issue
"" where long pastes get a new line...
"" https://notabug.org/demure/dotfiles/
"" legacy repo http://github.com/demure/dotfiles

""" Commands at Start """ {{{
    "" This one needs to be first
    set nocompatible                " Choose no comp with legacy vi

    if has("syntax")
        syntax on                   " Adds vim color based on file
    endif

    "" Enable filetype settings
    if has("eval")
        filetype on
        filetype plugin on
        filetype indent on
    endif

    """ Folds Settings """ {{{
    if has("folding")
        set foldenable              " Enable folds
        "" These next two would save which folds are open/close, as well
        "" as view location, but seems to force set foldmethod=indent...
        "au BufWinLeave ?* mkview
        "au BufWinEnter ?* silent loadview
        set foldmethod=marker
        set fillchars=fold:.
        highlight Folded ctermfg=Grey ctermbg=Black
        "set foldlevelstart=99      " Effectively disable auto folding

            """ Foldtext """ {{{
            "" Inspired by http://www.gregsexton.org/2011/03/improving-the-text-displayed-in-a-fold/
            set foldtext=CustomFoldText()
            function! CustomFoldText()
                "" Process line
                let fs = v:foldstart
                let fLinePrep = substitute(getline(fs), '\t', '+---', 'g')
                let fLine = substitute(fLinePrep, ' {\{3}', '', 'g')

                "" Process line count and fold precentage
                let fSize = 1 + v:foldend - v:foldstart
                let fSizeStr = " " . fSize . " lines "
                let fLineCount = line("$")
                let fPercent = printf("[%.1f", (fSize*1.0)/fLineCount*100) . "%] "

                "" Process fold level
                let fLevel = "{".v:foldlevel."} "

                "" Process filler string
                let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
                let expansionString = repeat(".", w - strwidth(fSizeStr.fLine.fPercent.fLevel))

                "return fLine . expansionString . fSizeStr . foldPercent . foldLevel
                return fLine . fSizeStr . fPercent . fLevel
            endfunction
            """ End Foldtext """ }}}
    endif
    """ End Folds Settings """ }}}

    "" Stop auto comment on new line
    autocmd FileType * setlocal formatoptions-=cro
    set shortmess+=atIT             " Stop messages at vim launch
    runtime macros/matchit.vim      " Add '%' matching to if/elsif/else/end

    "" Mutt settings
    " Support Format-Flowed in email (mutt).
    " Because it is a good-ness? http://joeclark.org/ffaq.html
    autocmd FileType mail setlocal fo+=aw tw=72

    "" vimdiff settings
    if &diff
        colorscheme slate
    endif
""" End Commands at Start """ }}}

""" Plugins """ {{{
if $USER != 'mobile'
    """ Setting up Vundle """ {{{
    "" From http://www.erikzaadi.com/2012/03/19/auto-installing-vundle-from-your-vimrc/
    let iCanHazVundle=1
    let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
    if !filereadable(vundle_readme)
        echo "Installing Vundle.."
        echo ""
        silent !mkdir -p ~/.vim/bundle
        "" Disabled for git url
        "silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
        silent !git clone git://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
        let iCanHazVundle=0
    endif
    set rtp+=~/.vim/bundle/vundle/
    """""""call vundle#rc()     ""commented out for vundle version bump change??
    call vundle#begin()
    "" Use git instead of http
    let g:vundle_default_git_proto = 'git'
    "" Have vundle first...
    Plugin 'gmarik/vundle'

        """ Bundles """ {{{
        ""Add your bundles here
            """ Style """ {{{
            Plugin 'altercation/vim-colors-solarized'   " Solarized theme
            Plugin 'syntax-highlighting-for-tintinttpp' " Tintin++ syntax
            Plugin 'bling/vim-airline'                  " Even better than powerline/neatstatus
            Plugin 'nathanaelkane/vim-indent-guides'    " vim-indent-guides default binding: <Leader>ig
            Plugin 'kien/rainbow_parentheses.vim'       " Colorize parentheses and similar chars
            Plugin 'myusuf3/numbers.vim'                " Make num ruler auto switch absolute/rel for insert/norm
            Plugin 'mhinz/vim-signify'                  " Add git diff
            """ End Style """ }}}

            """ Added Interface """ {{{
            Plugin 'scrooloose/nerdtree'        " File browser
            Plugin 'bufexplorer.zip'            " buffer browser
            Plugin 'sjl/gundo.vim'              " Undo history tree
            "Plugin 'szw/vim-ctrlspace'         " Super buffer controlness, disabled due to never using
            Plugin 'haya14busa/incsearch.vim'   " Improved incremental searching
            Plugin 'spolu/dwm.vim'              " dwm like split control
            """ End Interface """ }}}

            """ Added Functionality """ {{{
            Plugin 'tpope/vim-repeat'           " Makes '.' repeat work with plugins
            Plugin 'scrooloose/nerdcommenter'   " Make commenting easy
            Plugin 'YankRing.vim'               " Improves copy/paste
            Plugin 'tpope/vim-fugitive'         " git from vim
            Plugin 'scrooloose/syntastic'       " Code syntax checker
            "Plugin 'SearchComplete'            " Disabled due to killing UP arrow in search
            Plugin 'Lokaltog/vim-easymotion'    " <prefix><prefix>motion
            Plugin 'chrisbra/csv.vim'           " Good CVS file handling
            Plugin 'dhruvasagar/vim-table-mode' " Make easy tables
            "Plugin 'vim-scripts/Smart-Tabs'        " Use \t for indents, and spaces elsewhere
            Plugin 'jamessan/vim-gnupg'         " Transparent editing of gpg encrypted files
            """ End Functionality """ }}}

            """ Misc """ {{{
            Plugin 'uguu-org/vim-matrix-screensaver'    " Add unnecessary matrix screen saver
            Plugin 'takac/vim-hardtime'                 " Plugin to break bad movement habits
            """ End Misc """ }}}
        ""...All your other bundles...
        """ End Bundles """ }}}
    call vundle#end()       " required

    if iCanHazVundle == 0
        echo "Installing Bundles, please ignore key map error messages"
        echo ""
        :PluginInstall
    endif
""" End Setting Up Vundle """ }}}

    """ Plugin Confs """ {{{
        """ NERDtree config """ {{{
        "" Starts NERDtree if no file is give to vim at start
        "autocmd vimenter * if !argc() | NERDTree | endif
        """ End NERDtree """ }}}

        """ Vim Repeat Conf """ {{{
        "" This is to make repeat work for plugins too
        silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)
        """ End Vim Repeat """ }}}

        """ Better Rainbow Parentheses """ {{{
        "" https://github.com/kien/rainbow_parentheses.vim
            """ Auto Rainbow """ {{{
            au VimEnter * RainbowParenthesesToggle
            au Syntax * RainbowParenthesesLoadRound
            au Syntax * RainbowParenthesesLoadSquare
            au Syntax * RainbowParenthesesLoadBraces
            """ End Auto """ }}}
        nmap <leader>[ :RainbowParenthesesToggle <CR>
        """ End Rainbow Parenthesis """ }}}

        """ YankRing Conf """ {{{
        "" :h yankring-tutorial
        nnoremap <silent> <F3> :YRShow<CR>
        inoremap <silent> <F3> <ESC>:YRShow<CR>
        map <silent> <prefix>y :YRShow<CR>
        let g:yankring_history_dir = '~/.vim'
        """ End YankRing """ }}}

        """ Solarized Theme """ {{{
        "call togglebg#map("<F6>")
        if has('gui_running')
            set background=light
        colorscheme solarized
        endif
        """ End Solarized """ }}}

        """ Gundo Conf """ {{{
        "" http://sjl.bitbucket.org/gundo.vim/
        nnoremap <F4> :GundoToggle<CR>
        """ End Gundo """ }}}

        """ Numbers.vim Conf""" {{{
        "" https://github.com/myusuf3/numbers.vim
        nnoremap <leader>n :NumbersToggle<CR>
        """ End Nunmbers.vim """ }}}

        """ Vim Indent Guides """ {{{
        "" https://github.com/nathanaelkane/vim-indent-guides
        "" <Leader>ig
        let g:indent_guides_auto_colors = 0
        "autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=236
        autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=240
        autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=244
        let g:indent_guides_enable_on_vim_startup = 1
        "let g:indent_guides_guide_size = 2
        let g:indent_guides_start_level = 2
        """ End Indent Guides """ }}}

        """ Airline Conf """ {{{
        "" Added to fix airline (forces status visibility)
        set laststatus=2
        "" Disable auto echo?
        let g:bufferline_echo = 0
        "" Remove default mode indicator
        set noshowmode
        """ End Airline Conf """ }}}

        """ Hardtime Conf """ {{{
        let g:hardtime_default_on = 1
        let g:hardtime_ignore_buffer_patterns = [ "CustomPatt[ae]rn", "NERD.*", "Task.*" ]
        """ End Hardtime """ }}}

        """ Syntastic Conf """ {{{
        let g:syntastic_auto_loc_list=1
        """ End Syntastic """ }}}

        """ Vim-CtrlSpace Conf """ {{{
        "" https://github.com/szw/vim-ctrlspace
        "" Make work with airline
        let g:airline_exclude_preview = 1
        """ End Vim-CtrlSpace """ }}}

        """ Incsearch.vim Conf """ {{{
        "" https://github.com/haya14busa/incsearch.vim
        let g:incsearch#magic = '\v'
        map /  <Plug>(incsearch-forward)
        map ?  <Plug>(incsearch-backward)
        map g/ <Plug>(incsearch-stay)
        """ End Incsearch.vim """ }}}

        """ DWM.vim Conf """ {{{
        nnoremap <silent> <C-b> :call DWM_New()<CR>
        """ End DWM.vim Conf """ }}}
    """ End Plugin Confs """ }}}
endif
""" End Plugins """ }}}

""" Theming """ {{{
if has('gui_running')
    set background=light
    colorscheme solarized
  else
    colorscheme torte
endif
""" End Theming """ }}}

""" Options """ {{{
    """ Assorted """ {{{
    set autoread                    " Reload files changed outside vim
    set encoding=utf8               " Sets encoding View
    set scrolloff=3                 " Show next three lines scrolling
    set sidescrolloff=2             " Show next two columns scrolling
    set ttyfast                     " Indicates a fast terminal connection
    set splitbelow                  " New horizontal splits are below
    set splitright                  " New vertical splits are to the right
    set history=1000                " Increase command/search history
    set confirm                     " Vim prompts for :q/:qa/:w issues
    """ End Assorted """ }}}

    """ HUD """ {{{
    set number                      " Adds line numbers
    set showcmd                     " Show incomplete cmds down the bottom
    "" Disabled for air-line
    "set showmode                   " Shows input or replace mode at bottom
    set ruler                       " Show position in bottom right
    """ End HUD """ }}}

    """ Input """ {{{
    set virtualedit=block,onemore   " Cursor can move one past EOL, and free in Visual mode
"   set virtualedit=all             " Allow virtual editing, all modes.
    set mouse=a                     " Enable mouse, all modes
    set backspace=indent,eol,start  " Allow backspace in insert mode
    """ End Input """ }}}

    """ Mac kill damn bold """ {{{
    if has('mac')
        set t_Co=256                " FORCE 256 colors in vim
    endif
    """ End Mac """ }}}

    """ Wild Stuffs... """ {{{
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    "" From http://blog.sanctum.geek.nz/lazier-tab-completion/
    if exists("&wildignorecase")
        set wildignorecase          " Ignore case in file name completion
    endif
    "" From http://bitbucket.org/sjl/dotfiles/overview
    set wildignore+=.hg,.git,.svn                       " Version control
    set wildignore+=*.aux,*.out,*.toc                   " LaTeX intermediate files
    set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg      " binary images
    set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest    " compiled object files
    set wildignore+=*.spl                               " compiled spelling word lists
    set wildignore+=*.sw?                               " Vim swap files
    set wildignore+=*.DS_Store                          " OSX bullshit
    set wildignore+=*.luac                              " Lua byte code
    set wildignore+=migrations                          " Django migrations
    set wildignore+=*.pyc                               " Python byte code
    set wildignore+=*.orig                              " Merge resolution files

    "" Clojure/Leiningen
    set wildignore+=classes
    set wildignore+=lib
    """ End Wild """ }}}

    """ Show Hidden Chars """ {{{
    set list                        " Shows certain hidden chars
    set listchars=eol:¬,tab:▶-,trail:~,extends:>,precedes:<,nbsp:·
    hi NonText ctermfg=darkgray     " Makes trailing darkgray
    hi SpecialKey ctermfg=darkgray  " Makes Leading darkgray
    """ End Hidden Chars """ }}}

    """ Spelling """ {{{
    set spell                       " Spelling hilight on
"   highlight SpellBad cterm=underline ctermfg=red
    hi SpellBad cterm=underline ctermbg=NONE
    hi SpellCap cterm=underline ctermbg=NONE
    """ End Spelling """ }}}

    """ Tab Windows """ {{{
    set hidden                      " Hides buffers, instead of closing, or forcing save
    set showtabline=2               " shows the tab bar at all times
    set tabpagemax=100              " max num of tabs to open on startup
    hi TabLineSel ctermbg=Yellow    " Current Tab
    hi TabLine ctermfg=Grey ctermbg=DarkGrey    " Other Tabs
    hi TabLineFill ctermfg=Black    " Rest of line
    hi Title ctermfg=DarkBlue ctermbg=None  " Windows in Tab
    """ End Tab Windows """ }}}

    """ Tab Key Settings """ {{{
    "" prefer tabs now...
    set expandtab   "" use spaces, not tabs
    set tabstop=4                   " Set Tab length
    set shiftwidth=4                " Affects when you press >>, << or ==. And auto indent.
    set shiftround                  " Uses multiple of shiftwidth when indenting with '<' and '>'
    set softtabstop=4               " With space indenting, lets vim delete multiple spaces at once
    "" disabled per https://stackoverflow.com/questions/234564/tab-key-4-spaces-and-auto-indent-after-curly-braces-in-vim
"   set smarttab                    " Insert Tabs at ^ per shiftwidth, not tabstop
    set autoindent                  " Always set auto indenting on
    set copyindent                  " Copy prior indentation on autoindent
    """ End Tab Key """ }}}

    """ Searching """ {{{
    " Use real regex search
    nnoremap / /\v
    vnoremap / /\vi
    set hlsearch                    " Highlight matches
    set incsearch                   " Incremental searching
    set ignorecase                  " Searches are case insensitive...
    "" Disabled as was annoying with command completion
    "set smartcase                  " ...unless contains oneplus Cap letter
    set showmatch                   " Show matching brackets/parenthesis
    set gdefault                    " Applies substitutions globally on lines. Append 'g' to invert back.
    set synmaxcol=800               " Don't highlight lines longer than 800 chars
    set wrapscan                    " Scan wraps around the file
    """ End Searching """ }}}

    """ Backup Settings """ {{{
        """ Dir Validation """ {{{
        if !isdirectory(expand("~/.vim/back/"))
            call mkdir(expand("~/.vim/back/"), "p")
        endif
        if !isdirectory(expand("~/.vim/swap/"))
            call mkdir(expand("~/.vim/swap/"), "p")
        endif
        if !isdirectory(expand("~/.vim/undo/"))
            call mkdir(expand("~/.vim/undo/"), "p")
        endif
        """ End Dir """ }}}
    set backup                      " Enable backups
    set undofile                    " Enable undo file
    set undoreload=10000
    set backupdir=~/.vim/back/
    set directory=~/.vim/swap/      " swap files
    set undodir=~/.vim/undo/        " undo files
    """ End Backup Settings """ }}}

    """ Timeout Settings """ {{{
    set timeout                     " :mapping time out
    set timeoutlen=1000             " :mapping time out length
    set ttimeout                    " Key code time out
    set ttimeoutlen=50              " key code time out length
    """ End Timeout """ }}}
""" End Options """ }}}

""" Aliases """ {{{
    command! BI BundleInstall
""" End Aliases """ }}}

""" Functions """ {{{
    """ DiffSaved """ {{{
    "" To compare current vs saved version
    "" http://vim.wikia.com/wiki/Diff_current_buffer_and_the_original_file
    "" To get out of diff view you can use the :diffoff command.
    function! s:DiffWithSaved()
        let filetype=&ft
        diffthis
        vnew | r # | normal! 1Gdd
        diffthis
        exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
    endfunction
    com! DiffSaved call s:DiffWithSaved()
    """End DiffSaved """ }}}
""" End Functions """ }}}

""" Key Bindings """ {{{
    let mapleader=","               " Change the mapleader from '\' to ','
    map <leader>/ :noh<return>      " <leader>/ will clear search hilights!

    """ Quickly edit/reload the vimrc file """ {{{
    ""  maps the ,ev and ,sv keys to edit/reload .vimrc.
    nmap <silent> <leader>ev :tabedit $MYVIMRC<CR>
    nmap <silent> <leader>sv :so $MYVIMRC<CR>
    """ End reload """ }}}

    """ Paste Toggle, for stopping formating of pastes """ {{{
    nnoremap <F2> :set invpaste paste?<CR>
    set pastetoggle=<F2>
    nmap <leader>p :set invpaste paste?<CR>
    """ End Paste Toggle """ }}}

    """ Vim Tab Window Keysbindings """ {{{
"   nnoremap <C-Left> :tabprevious<CR>
"   nnoremap <C-Right> :tabnext<CR>
"   nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
"   nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>
    """ End Tab Window Keys """ }}}

    """ Navigate Splits """ {{{
    "" uses ',' key first
    map <leader>h :wincmd h<CR>
    map <leader>j :wincmd j<CR>
    map <leader>k :wincmd k<CR>
    map <leader>l :wincmd l<CR>

    map <leader> <Left> :wincmd h<CR>
    map <leader> <Down> :wincmd j<CR>
    map <leader> <Up> :wincmd k<CR>
    map <leader> <Right> :wincmd l<CR>
    """ End Navigate Splits """ }}}

    """ Toggle colorcolumn """ {{{
    highlight ColorColumn ctermbg=Brown
    function! g:ToggleColorColumn()
        if &colorcolumn != ''
            setlocal colorcolumn&
          else
            setlocal colorcolumn=77
        endif
    endfunction

    nnoremap <silent> <leader>L :call g:ToggleColorColumn()<CR>
    """ End Toggle colorcolumn """ }}}

    """ Cross Hairs """ {{{
    hi CursorLine   cterm=NONE ctermbg=darkgrey ctermfg=white guibg=darkred guifg=white
    hi CursorColumn cterm=NONE ctermbg=darkgrey ctermfg=white guibg=darkred guifg=white
    nnoremap <Leader>+ :set cursorline! cursorcolumn!<CR>
    """ End Cross Hair """ }}}

    """ DiffOrig """ {{{
    "command DiffOrig let g:diffline = line('.') | vert new | set bt=nofile | r # | 0d_ | diffthis | :exe "norm! ".g:diffline."G" | wincmd p | diffthis | wincmd p
    command! DiffOrig let g:diffline = line('.') | vert new | set bt=nofile | r # | 0d_ | diffthis | :exe 'norm! '.g:diffline.'G' | wincmd p | diffthis | wincmd p
    nnoremap <Leader>do :DiffOrig<cr>
    nnoremap <leader>dc :q<cr>:diffoff<cr>:exe "norm! ".g:diffline."G"<cr>
    """ End DiffOrig """ }}}

    """ Sudo Save Edit """ {{{
    "" Use :W to sudo save, may mess with permissions
    command! WW w !sudo tee % > /dev/null
    """ End Sudo Save """ }}}

    """ Typo Commands """ {{{
    "" http://blog.sanctum.geek.nz/vim-command-typos/
    if has("user_commands")
        command! -bang -nargs=? -complete=file E e<bang> <args>
        command! -bang -nargs=? -complete=file W w<bang> <args>
        command! -bang -nargs=? -complete=file Wq wq<bang> <args>
        command! -bang -nargs=? -complete=file WQ wq<bang> <args>
        command! -bang Wa wa<bang>
        command! -bang WA wa<bang>
        command! -bang Q q<bang>
        command! -bang QA qa<bang>
        command! -bang Qa qa<bang>
    endif
    """ End Typo """ }}}
""" End Key Bindings """ }}}

""" Notes To Self """ {{{
"" Consider:
    " set foldopen=
""" End Notes """ }}}
