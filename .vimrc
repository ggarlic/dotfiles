call plug#begin('~/.vim/plugged')
"github
Plug 'bling/vim-airline'
Plug 'easymotion/vim-easymotion'
Plug 'w0rp/ale'
Plug 'scrooloose/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'scrooloose/nerdcommenter'
Plug 'Valloric/YouCompleteMe', {'do': 'CXX=clang++ CC=clang python3 install.py --clang-completer', 'for': ['c', 'cpp', 'python', 'go']}
"Plug 'Valloric/MatchTagAlways'
Plug 'tpope/vim-fugitive'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'airblade/vim-gitgutter'
Plug 'terryma/vim-multiple-cursors'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': 'go' }
Plug 'mbbill/undotree'
Plug 'morhetz/gruvbox'
Plug 'luochen1990/rainbow'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/a.vim'
Plug 'kshenoy/vim-signature'
"Plug 'justinmk/vim-gtfo'
Plug 'lepture/vim-jinja'
Plug 'cespare/vim-toml'
Plug 'Vimjas/vim-python-pep8-indent', {'for': 'python'}
Plug 'zaiste/tmux.vim'
Plug 'jrosiek/vim-mark'
Plug 'cohama/lexima.vim'
Plug 'Yggdroot/indentLine'
Plug 'mhinz/vim-startify'
"Plug 'tweekmonster/startuptime.vim'
"Plug 'ludovicchabant/vim-gutentags'
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderInstallCExtension' }
Plug 'Shougo/echodoc.vim'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'solarnz/thrift.vim'
Plug 'majutsushi/tagbar'

" python
Plug 'vim-python/python-syntax', {'for': 'python'}
Plug 'google/yapf', { 'rtp': 'plugins/vim', 'for': 'python' }
Plug 'fisadev/vim-isort', {'for': 'python'}

" always the last one
Plug 'ryanoasis/vim-devicons'
call plug#end()
""""""""""""""""""""""""""""""""
"General
""""""""""""""""""""""""""""""""
set clipboard^=unnamed,unnamedplus
set backspace=indent,eol,start
set foldenable
set fdm=indent
set foldlevel=99
"set foldnestmax=10
set nobackup
set nowritebackup
set updatetime=300
set completeopt=longest,menu
set display=lastline
set lazyredraw
set nocompatible
set autochdir
set tags=./.tags;,.tags
set sessionoptions-=curdir
set autoread
set history=1000
set confirm
set iskeyword+=_,$,@,%,#,-
set viminfo='10,\"100,:20,%,n~/.viminfo
set laststatus=2
set showtabline=2
set noshowmode
set sps=best,10
set backspace=2
set nowrap
set whichwrap+=<,>,h,l
set report=0
set encoding=utf-8
set fileencoding=utf-8
set shortmess=atI
set shortmess+=c
set dictionary+=/usr/share/dict/web2
set ttimeoutlen=10
set diffopt+=internal,algorithm:patience
set autowrite  "auto save when :make

if has('mouse')
    set mouse=a
    set selectmode=mouse,key
    set nomousehide
endif
"set splitbelow
"""""""""""""""""""""""""""""""""""
" Interface and themes
"""""""""""""""""""""""""""""""""""
set t_Co=256
set cursorline
syntax enable 
syntax on 
set scrolloff=3
set go-=m
set go-=T
set go-=r
set go-=L
set ruler
set title
set wildmenu
set number
set linebreak
set cc=80
set termguicolors
set ballooneval
set balloonevalterm
"hi ColorColumn ctermbg=235 guibg=#2c2d27
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
set formatoptions+=mB
set ffs=unix,dos,mac
filetype plugin indent on
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocommands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au FileType c,cpp setlocal omnifunc=ccomplete#Complete cindent foldmethod=syntax tags+=/home/ggarlic/.vim/systags;
au FileType c,cpp setlocal commentstring=//\ %s
au FileType markdown setlocal wrap
au BufWritePre *.py :%s/\s\+$//e
au FileType go setlocal foldmethod=indent
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

"now i use lexima to do this
"au FileType c,cpp,h,java,css,js,nginx,scala,go inoremap  <buffer>  {<CR> {<CR>}<Esc>O
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
vnoremap <space> zf
" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>
"write read-only files
cnoremap sudow w !sudo tee % >/dev/null

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

""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""
"nerdtree
map <F4> :NERDTreeToggle<CR>
"let NERDTreeChDirMode=2
let g:NERDTreeShowlineNumber=1
let NERDTreeMinimalUI=1
let g:NERDTreeDirArrows = 1
let g:NERDTreeHijackNetrw = 0
"https://github.com/scrooloose/nerdtree/issues/21
let NERDTreeIgnore = ['\.pyc$']
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"nerd commenter
let NERDShutUp=1

"ycm
"let g:ycm_add_preview_to_compleopt = 1
"let g:ycm_python_binary_path = '/usr/local/bin/python3'
let g:ycm_key_invoke_completion = '<C-.>'
"let g:ycm_autoclose_preview_window_after_completion=1
nnoremap <leader>jd :YcmCompleter GoTo<CR>
nnoremap <leader>ji :YcmCompleter GoToImplementation<CR>
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1
"let g:ycm_register_as_syntastic_checker = 1
let g:ycm_goto_buffer_command='vertical-split'
let g:ycm_confirm_extra_conf = 0
let g:ycm_show_diagnostics_ui = 1
let g:ycm_filetype_whitelist = { 
    \ 'c': 1 ,
    \ 'cpp': 1,
    \ 'python': 1,
    \ 'go': 1
    \}
let g:ycm_disable_signature_help = 1
let g:ycm_gopls_binary_path = 'gopls'

"ultisnips
" we can't use <tab> as our snippet key since we use that with neocomplcache
"let g:UltiSnipsSnippetsDir = $HOME . '/dotfiles/vim/UltiSnips'
set <m-/>=/
set <m-j>=j
set <m-k>=k
set <m-.>=.
let g:UltiSnipsExpandTrigger = "<c-b>"
let g:UltiSnipsListSnippets = "<m-.>"
let g:UltiSnipsJumpForwardTrigger = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"
let g:UltiSnipsEditSplit="vertical"

"python.vim
let g:python_highlight_all = 1

"indentLine
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

"rainbow
let g:rainbow_active = 1
let g:rainbow_conf = {
\	'separately': {
\		'nerdtree': 0,
\	}
\}

"vim-go
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1
let g:go_info_mode = 'gopls'
let g:go_addtags_transform = "camelcase"
let g:go_def_mode='gopls'
let g:go_fill_struct_mode='gopls'
let g:go_metalinter_command='golangci-lint'
let g:go_referrers_mode = 'gopls'
if has('balloon_eval_term')
  set balloonevalterm
  set balloonexpr=go#tool#DescribeBalloon()
endif
let g:go_doc_popup_window = 1
let g:go_echo_progress = 1

"let g:go_auto_sameids = 1
"let g:go_fmt_autosave = 0

au FileType go nmap <leader>r <Plug>(go-run)
"au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage-toggle)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>K <Plug>(go-doc-vertical)
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>e <Plug>(go-rename)
au FileType go nmap <Leader>cr <Plug>(go-callers)
au FileType go nmap <Leader>ce <Plug>(go-callees)
au Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
au Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
au Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
au Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
au Filetype go nmap <silent> <leader>gd :GoDecls<CR>
au Filetype go nmap <silent> <leader>gD :GoDeclsDir<CR>
au BufRead,BufNewFile *.gohtml set filetype=gohtmltmpl
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
au FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

"vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
" enable this to display which function i'm in now
let g:airline#extensions#tagbar#enabled = 1

"gruvbox
set background=dark
let g:gruvbox_italic=1
colorscheme gruvbox

"vim-gtfo
let g:gtfo#terminals = {'unix': 'termite -d', 'mac': 'iterm'}

"undotree
if has("persistent_undo")
    set undodir=~/.undodir/
    set undofile
endif

"easymotion
map <Leader> <Plug>(easymotion-prefix)
let g:EasyMotion_smartcase = 1

"lua
let g:lua_complete_omni = 1


"startify
let g:startify_bookmarks=[
    \ '/path/to/my/projects',
    \ ]

" vim-gutentags
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
let g:gutentags_ctags_tagfile = '.tags'
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

if !isdirectory(s:vim_tags)
    silent! call mkdir(s:vim_tags, 'p')
endif

"leaderf function
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
noremap <F2> :LeaderfFunction!<cr>
let g:Lf_Ctags = "/usr/local/bin/ctags"
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_ShowRelativePath = 0
let g:Lf_ShortcutF = '<c-p>'
let g:Lf_ShortcutB = '<m-n>'
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 1
let g:Lf_CacheDirectory = expand('~/.vim/cache')
let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
    let g:Lf_MruFileExclude = ['*.so', '*.exe', '*.py[co]', '*.sw?', '~$*', '*.bak', '*.tmp', '*.dll']
let g:Lf_PreviewResult = {'Function':0, 'Colorscheme':1, 'BufTag': 0}
let g:Lf_WildIgnore = {
					\ 'dir': ['.svn','.git','.hg'],
					\ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
					\ }
let g:Lf_NormalMap = {
    \ "File":   [["<ESC>", ':exec g:Lf_py "fileExplManager.quit()"<CR>']],
    \ "Buffer": [["<ESC>", ':exec g:Lf_py "bufExplManager.quit()"<CR>']],
    \ "Mru":    [["<ESC>", ':exec g:Lf_py "mruExplManager.quit()"<CR>']],
    \ "Tag":    [["<ESC>", ':exec g:Lf_py "tagExplManager.quit()"<CR>']],
    \ "Function":    [["<ESC>", ':exec g:Lf_py "functionExplManager.quit()"<CR>']],
    \ "Colorscheme":    [["<ESC>", ':exec g:Lf_py "colorschemeExplManager.quit()"<CR>']],
    \ }
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>
noremap <leader>fr :<C-U><C-R>=printf("Leaderf rg %s", "")<CR><CR>
" search visually selected text literally
xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
noremap go :<C-U>Leaderf! rg --recall<CR>

" echodoc
let g:echodoc_enable_at_startup = 1

" ale
" let g:ale_virtualenv_dir_names = ['.env', '.venv', 'env', 've-py3', 've', 'virtualenv', 'venv', 'bin']
"https://github.com/w0rp/ale/issues/2339
let g:ale_linters = { 'go': ['golangci-lint'] }
let g:ale_go_golangci_lint_options = '--fast'
let g:ale_go_golangci_lint_package=1

" vim-nerdtree-syntax-highlight
"let g:NERDTreeLimitedSyntax = 1
"let g:NERDTreeFileExtensionHighlightFullName = 1
"let g:NERDTreeExactMatchHighlightFullName = 1
"let g:NERDTreePatternMatchHighlightFullName = 1
"let g:NERDTreeHighlightFolders = 1
"let g:NERDTreeHighlightFoldersFullName = 1

"vim-devicons
let g:webdevicons_conceal_nerdtree_brackets=1
