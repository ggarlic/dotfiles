""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
set nocompatible
filetype off
set runtimepath+=~/.vim/bundle/vundle/
call vundle#rc()
"github
Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim'
"Bundle 'Lokaltog/vim-powerline'
Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Bundle 'Lokaltog/vim-easymotion'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'Valloric/YouCompleteMe'
Bundle 'tpope/vim-fugitive'
Bundle 'SirVer/ultisnips'
Bundle 'honza/vim-snippets'
Bundle 'fholgado/minibufexpl.vim'
Bundle 'hdima/python-syntax'
Bundle 'majutsushi/tagbar'
"Bundle 'mhinz/vim-signify'
Bundle 'airblade/vim-gitgutter'
Bundle 'junegunn/vim-emoji'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'Blackrush/vim-gocode'
Bundle 'dgryski/vim-godef'
Bundle 'nsf/gocode', {'rtp': 'vim/'}
Bundle 'rking/ag.vim'
Bundle 'sjl/gundo.vim'
"Bundle 'jimenezrick/vimerl'
Bundle 'ivanov/vim-ipython'
Bundle 'Xuyuanp/nerdtree-git-plugin'

Bundle 'AutoClose--Alves'
Bundle 'a.vim'
Bundle 'closetag.vim'
Bundle 'Colour-Sampler-Pack'
Bundle 'c.vim'
Bundle 'DrawIt'
Bundle 'fcitx.vim'
Bundle 'grep.vim'
Bundle 'matchit.zip'
Bundle 'ragtag.vim'
Bundle 'repeat.vim'
Bundle 'ShowMarks'
Bundle 'surround.vim'
Bundle 'winmanager'
filetype plugin on
""""""""""""""""""""""""""""""""
"General
""""""""""""""""""""""""""""""""
set clipboard=unnamed
set backspace=indent,eol,start
set foldenable
set foldlevel=99
set foldmethod=syntax
set foldnestmax=2
set nobackup
set completeopt=longest,menu,preview
set display=lastline
set nocompatible
set autochdir
set tags=tags;
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
set dictionary+=/usr/share/dict/web2
"""""""""""""""""""""""""""""""""""
" Interface and themes
"""""""""""""""""""""""""""""""""""
set t_Co=256
set cursorline
"colorscheme molokai-transparent
colorscheme ir_black
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
set cc=80
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
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
set formatoptions+=mM
filetype indent on
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocommands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au Filetype html,xml,xsl source /home/ggarlic/.vim/bundle/closetag.vim/plugin/closetag.vim
"au FileType c setlocal omnifunc=ccomplete#Complete cindent tags+=/home/ggarlic/.vim/systags; | let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra_conf_c.py'
au FileType c setlocal omnifunc=ccomplete#Complete cindent | let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra_conf_c.py'
au FileType c,cpp inoremap ,, <ESC>A;<CR>
au FileType cpp setlocal omnifunc=ccomplete#Complete cindent tags+=/home/ggarlic/.vim/systags; | let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra_conf_cpp.py'
au FileType python setlocal omnifunc=pythoncomplete#Complete | setlocal foldmethod=indent
au FileType python inoremap ,, <ESC>A:<CR>
au FileType css setlocal omnifunc=csscomplete#CompleteCSS
au FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
au FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

"goimport
let g:gofmt_command = 'goimports'
au BufWritePre *.go :Fmt
""""""""""""""""""""""""""""""""""""""""""""""""
"key bindings
""""""""""""""""""""""""""""""""""""""""""""""""
:inoremap ,. <ESC>o
"tab navigation
nnoremap tp :tabprevious<CR>
nnoremap tn :tabnext<CR>
nnoremap to :tabnew<CR>
nnoremap tc :tabclose<CR>
nnoremap gf <C-W>gf
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
" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>
"write read-only files
cnoremap sudow w !sudo tee % >/dev/null
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
noremap <C-Down>  <C-W>j
noremap <C-Up>    <C-W>k
noremap <C-Left>  <C-W>h
noremap <C-Right> <C-W>l
noremap <C-TAB>   <C-W>w
noremap <C-S-TAB> <C-W>W

"nerdtree
map <F4> :NERDTreeToggle<CR>
let NERDTreeChDirMode=2
"https://github.com/scrooloose/nerdtree/issues/21
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" autoclose and so
let g:AutoCloseProtectedRegions = ["Comment", "String", "Character"] 

"nerd commenter
let NERDShutUp=1

"vim indent guides
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']


let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=darkgrey
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=lightgrey

"powerline
let g:Powerline_symbols = 'fancy'

"tagbar
nmap <F8> :TagbarToggle<CR>

let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
    \ }
"showmarks
let g:showmarks_enable = 0

"syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_style_error_symbol = '✠'
let g:syntastic_style_warning_symbol = '≈'

"fcitx.vim
set timeout timeoutlen=1000 ttimeoutlen=100

"ycm
let g:ycm_add_preview_to_compleopt = 1
let g:ycm_key_invoke_completion = '<C-.>'
let g:ycm_autoclose_preview_window_after_completion=1
nnoremap <leader>jd :YcmCompleter GoTo<CR>
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_register_as_syntastic_checker = 1
let g:ycm_goto_buffer_command='vertical-split'
"ultisnips
" we can't use <tab> as our snippet key since we use that with neocomplcache
"let g:UltiSnipsSnippetsDir = $HOME . '/dotfiles/vim/UltiSnips'
set <m-/>=/
set <m-j>=j
set <m-k>=k
set <m-.>=.
let g:UltiSnipsExpandTrigger = "<C-j>"
let g:UltiSnipsListSnippets = "<m-.>"
let g:UltiSnipsJumpForwardTrigger = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"
let g:UltiSnipsEditSplit="vertical"
"let g:snips_author = 'Strahinja Val Markovic'"

"python.vim
let python_highlight_all = 1
let python_version_2 = 1

"ctrlp
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc     " MacOSX/Linux
" The Silver Searcher
if executable('ag')
    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command =
                \ 'ag %s --files-with-matches -g "" --ignore "\.git$\|\.hg$\|\.svn$"'
    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
else
    " Fall back to using git ls-files if Ag is not available
    let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
    let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
endif

" vim-emoji
silent! if emoji#available()
  let g:gitgutter_sign_added = emoji#for('small_blue_diamond')
  let g:gitgutter_sign_modified = emoji#for('small_orange_diamond')
  let g:gitgutter_sign_removed = emoji#for('small_red_triangle')
  let g:gitgutter_sign_modified_removed = emoji#for('collision')
endif

"gitgutter
let g:gitgutter_escape_grep = 1

"gundo
nnoremap <F5> :GundoToggle<CR>

" Run current file
func! RunSrc()
    exec "w"
    if &filetype == 'c'
        exec "!astyle --style=ansi --one-line=keep-statements -a --suffix=none %"
    elseif &filetype == 'cpp' || &filetype == 'hpp'
        exec "r !astyle --style=ansi --one-line=keep-statements -a --suffix=none %> /dev/null 2>&1"
    elseif &filetype == 'perl'
        exec "!astyle --style=gnu --suffix=none %"
    elseif &filetype == 'py'||&filetype == 'python'
        exec "!python %"
    elseif &filetype == 'java'
        exec "!astyle --style=java --suffix=none %"
    endif
    exec "e! %"
endfunc
noremap <silent><Leader>r :call RunSrc()<CR>

" Toggle paste mode before pasting
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
