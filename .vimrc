""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
set nocompatible
filetype off
set runtimepath+=~/.vim/bundle/vundle/
call vundle#rc()
"github
Bundle 'c9s/colorselector.vim'
Bundle 'gmarik/vundle'
Bundle 'godlygeek/tabular'
Bundle 'kien/ctrlp.vim'
Bundle 'Lokaltog/vim-powerline'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'scrooloose/syntastic'
Bundle 'Valloric/YouCompleteMe'
Bundle 'tpope/vim-fugitive'
Bundle 'SirVer/ultisnips'

Bundle 'AutoClose--Alves'
Bundle 'a.vim'
Bundle 'bufexplorer.zip'
Bundle 'cecutil'
Bundle 'closetag.vim'
Bundle 'Colour-Sampler-Pack'
Bundle 'Conque-Shell'
Bundle 'c.vim'
Bundle 'DrawIt'
Bundle 'fcitx.vim'
Bundle 'gtk-vim-syntax'
Bundle 'grep.vim'
Bundle 'matchit.zip'
Bundle 'OmniCppComplete'
Bundle 'Pydiction'
Bundle 'python.vim--Vasiliev'
Bundle 'ragtag.vim'
Bundle 'repeat.vim'
Bundle 'ShowMarks'
Bundle 'surround.vim'
Bundle 'Tagbar'
Bundle 'taglist.vim'
Bundle 'The-NERD-Commenter'
Bundle 'The-NERD-tree'
Bundle 'winmanager'
filetype plugin on
""""""""""""""""""""""""""""""""
"General
""""""""""""""""""""""""""""""""
filetype plugin indent on
set clipboard=unnamed
set backspace=indent,eol,start
set foldenable
set foldlevel=0
set foldmethod=syntax
set foldnestmax=1
set nobackup
set completeopt=longest,menu,preview
set display=lastline
set nocompatible
set autochdir
set sessionoptions-=curdir
set autoread
set history=1000
set confirm
set iskeyword+=_,$,@,%,#,-
set viminfo='10,\"100,:20,%,n~/.viminfo
set laststatus=2
set sps=best,10
set backspace=2
set whichwrap+=<,>,h,l
set mouse=a
set selection=exclusive
set selectmode=mouse,key
set report=0
set encoding=utf-8
set fileencoding=utf-8
set shortmess=atI
"""""""""""""""""""""""""""""""""""
" Interface and themes
"""""""""""""""""""""""""""""""""""
set t_Co=256
set cursorline
colorscheme molokai
syntax enable
"set statusline=%<%h%m%r\ %F%=[%{&filetype},%{&fileencoding},%{&fileformat}]%k\ %-14.(%l/%L,%c%V%)\ %P\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
set guifont="DejaVu Sans Mono"\ \ 10
set scrolloff=3
set guioptions-=m
set guioptions-=T
set ruler
set title
set wildmenu
set number
set linebreak
set cc=81
hi ColorColumn ctermbg=235 guibg=#2c2d27
"""""""""""""""""""""""""""""""""""""""
" Search
""""""""""""""""""""""""""""""""""""""
set magic
set showmatch
set hlsearch
set smartcase
set ignorecase
set incsearch
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,eol:$
set matchtime=5
""""""""""""""""""""""""""""""""""""""""
" Indent
""""""""""""""""""""""""""""""""""""""""
set autoindent
set smartindent
set cindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
set formatoptions+=mM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocommands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au Filetype html,xml,xsl source /home/ggarlic/.vim/bundle/closetag.vim/plugin/closetag.vim
au FileType c setlocal omnifunc=ccomplete#Complete tags+=/home/ggarlic/.vim/systags;
au FileType python setlocal omnifunc=pythoncomplete#Complete foldmethod=indent
au FileType css setlocal omnifunc=csscomplete#CompleteCSS
au FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
au FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

""""""""""""""""""""""""""""""""""""""""""""""""
"key bindings
""""""""""""""""""""""""""""""""""""""""""""""""
:inoremap ,, <ESC>o
"tab navigation
nnoremap tp :tabprevious<CR>
nnoremap tn :tabnext<CR>
nnoremap to :tabnew<CR>
nnoremap tc :tabclose<CR>
nnoremap gf <C-W>gf
"navigate in insert mode
inoremap <c-l> <right>
inoremap <c-h> <left>
"quickfix window
nnoremap <silent> <C-F6> :botright copen<CR>
nnoremap <silent> <C-F7> :cclose<CR>
nmap <F6> :cn<cr>
nmap <F7> :cp<cr>
"toggle menu and toolbar of gvim
map <silent> <C-F3> :if &guioptions =~# 'T' <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=m <bar>
    \else <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=m <Bar>
    \endif<CR>
"use spacebar to fold/unfold
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""
" CTags的设定
let Tlist_Sort_Type = "name"
let Tlist_Use_Right_Window = 1
let Tlist_Compart_Format = 1
let Tlist_Exist_OnlyWindow = 1
let Tlist_File_Fold_Auto_Close = 0
let Tlist_Enable_Fold_Column = 1
let Tlist_Show_One_File=1
let Tlist_Ctags_Cmd='/usr/bin/ctags'
map <C-F12> :!ctags -R --extra=+f --languages=c --langmap=c:+.h --c-kinds=+px --fields=+aiKSz
"winmanager
let g:winManagerWindowLayout='FileExplorer|TagList'
nmap wm :WMToggle<cr>
"minibufexpl 
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplModSelTarget = 1
"nerdtree
map <F4> :NERDTreeToggle<CR>
let NERDTreeChDirMode=2
" autoclose and so
let g:AutoCloseProtectedRegions = ["Comment", "String", "Character"] 
"pydiction
let g:pydiction_location = '~/.vim/bundle/Pydiction/complete-dict'
"toggle tlist
nnoremap <silent> <F3> :TlistToggle<CR>:TlistUpdate<CR>
"nerd commenter
let NERDShutUp=1
"vim indent guides
"let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
"powerline
let g:Powerline_symbols = 'fancy'
"tagbar
nmap <F8> :TagbarToggle<CR>
"showmarks
let g:showmarks_enable = 0
"syntastic
let g:syntastic_python_checker = 'pyflakes'
"fcitx.vim
set timeout timeoutlen=1000 ttimeoutlen=100
"ycm
let g:ycm_add_preview_to_compleopt = 1
let g:ycm_key_invoke_completion = '<C-/>'
"ultisnips
" we can't use <tab> as our snippet key since we use that with neocomplcache
"let g:UltiSnipsSnippetsDir = $HOME . '/dotfiles/vim/UltiSnips'
set <m-/>=/
set <m-j>=j
set <m-k>=k
set <m-.>=.
let g:UltiSnipsExpandTrigger = "<m-/>"
let g:UltiSnipsListSnippets = "<m-.>"
let g:UltiSnipsJumpForwardTrigger = "<m-k>"
let g:UltiSnipsJumpBackwardTrigger = "<m-j>"
"let g:snips_author = 'Strahinja Val Markovic'"
