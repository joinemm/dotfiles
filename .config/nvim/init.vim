"    _  __       _   ___
"   / |/ /__ ___| | / (_)_ _
"  /    / -_) _ \ |/ / /  ' \
" /_/|_/\__/\___/___/_/_/_/_/
" Author: Joinemm

"\\\ Plugins
  """""""""""
call plug#begin('~/.vim/bundle')

"\General plugins
    Plug 'itchyny/lightline.vim'                                " status bar
    Plug 'suan/vim-instant-markdown', {'for': 'markdown'}       " markdown preview
    Plug 'scrooloose/nerdtree'                                  " file tree
    Plug 'vifm/vifm.vim'                                        " vifm file manager
    Plug 'mhinz/vim-startify'                                   " fancy start screen
    Plug 'aurieh/discord.nvim', {'do': ':UpdateRemotePlugins'}  " discord rich presence
    Plug 'zefei/vim-wintabs'                                    " show buffers in tabline
    Plug 'junegunn/fzf'                                         " fuzzy finder
"\Aesthetics
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'              " highlighting for nerdtree
    Plug 'ryanoasis/vim-devicons'                               " icons for nerdtree
    Plug 'chrisbra/Colorizer'                                   " hex color previews
    Plug 'iCyMind/NeoSolarized'                                 " solarized color scheme that supports 24-bit color
"\Python and IDE plugins
    Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}      " Python syntax highlighting
    Plug 'tpope/vim-commentary'                                 " easy comment out
    Plug 'airblade/vim-gitgutter'                               " shows git changes in gutter
    Plug 'axelf4/vim-strip-trailing-whitespace'                 " strip trailing whitespace on save
    Plug 'cespare/vim-toml'                                     " .toml syntax highlighting
    Plug 'neoclide/coc.nvim', {'branch': 'release'}             " autocompletion framework
    Plug 'Omnisharp/omnisharp-vim'                              " completion engine for c#
    Plug 'turbio/bracey.vim'                                    " live preview html files
    Plug 'honza/vim-snippets'                                   " code snippets
    Plug 'tpope/vim-dadbod'
call plug#end()

"\\\ Settings
  """"""""""""
syntax enable               " use syntax highlighting
set background=dark         " let vim know we use dark background
set termguicolors           " True 24-bit color
"set title                   " use dynamic window title
set fileformat=unix         " always save in unix format to avoid problems with github etc
set encoding=utf-8          " use utf-8
set laststatus=2            " always show statusline
set number                  " real line numbers
set tabstop=4               " tab length
set shiftwidth=4            " tab length
set softtabstop=4           " backspace properly removes one tab length
set smarttab                " smart tabs
set expandtab               " tab inserts spaces
set autoindent              " new line keeps indent of previous
set smartindent             " smarter indent (?)
set undofile                " keep undos if file is closed
set undodir=~/.vim/undodir  " where to save undo history
set undolevels=10000        " how many undos
set undoreload=100000       " number of lines to save for undo
set splitright              " split right when splitting vertically
set splitbelow              " split below when splitting horizontally
set scrolloff=5             " how many lines from bottom before starting to scroll
set nowrap                  " turn off word wrap
set wrapscan                " wrap searching back to top of file when nothing is found
set mouse=nicr              " enable mouse scrolling
set clipboard=unnamedplus   " use system clipboard
set noshowmode              " dont show current mode (shown by lightline instead)
set updatetime=500          " wait time after typing to trigger plugin events
set hidden                  " required to keep multiple buffers
set signcolumn=yes          " always show signal column

" disable automatic comment continuation on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" use filetype detection
filetype plugin indent on

" lightline config
let g:lightline = {
    \ 'colorscheme': 'solarized'
    \ }

" nerdtree config
let g:NERDTreeDirArrowExpandable = '►'
let g:NERDTreeDirArrowCollapsible = '▼'
let NERDTreeShowLineNumbers=0
let NERDTreeShowHidden=1
let NERDTreeMinimalUI = 0
let g:NERDTreeWinSize=38

" CoC
" tab completetion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


command! -nargs=0 Format :call CocAction('format')

" snippets tab thing
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<A-l>'

" other plugin config
let g:python3_host_prog = expand("/usr/bin/python")
let g:semshi#simplify_markup = v:false
let g:gitgutter_max_signs = 999
let g:Omnisharp_server_stdio = 1
let g:Omnisharp_hightlight_types = 3

let g:loaded_sql_completion = 0
let g:omni_sql_no_default_maps = 1


"\\ Keybinds
  """""""""""
" nerdtree toggle
map <C-n> :NERDTreeToggle<CR>

" vifm
map <space> :EditVifm .<CR>

" easy split movement
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" move selected lines up and down
xnoremap K :move '<-2<CR>gv-gv
xnoremap J :move '>+1<CR>gv-gv

" tab in normal mode will change buffers
"nnoremap <TAB> :bnext<CR>

" wintabs config
map <S-TAB> <Plug>(wintabs_previous)
map <TAB> <Plug>(wintabs_next)
map <A-t>c <Plug>(wintabs_close)
map <A-t>u <Plug>(wintabs_undo)
map <A-t>o <Plug>(wintabs_only)
map <A-w>c <Plug>(wintabs_close_window)
map <A-w>o <Plug>(wintabs_only_window)
command! Tabc WintabsCloseVimtab
command! Tabo WintabsOnlyVimtab


" ctrl s to save
nnoremap <C-s> :w<CR>

" U to redo
nnoremap <S-u> :redo<CR>

" rename current node
nnoremap <C-r> :Semshi rename<CR>

" comment out blocks of text
xnoremap <C-c> :Commentary<CR>

"\\\ Colors
  """"""""""
colorscheme NeoSolarized

function SolarizedSemshi()
    hi semshiLocal           ctermfg=209 guifg=#ff875f
    hi semshiGlobal          ctermfg=214 guifg=#ffaf00
    hi semshiImported        ctermfg=214 guifg=#ffaf00 cterm=bold gui=bold
    hi semshiParameter       ctermfg=75  guifg=#5fafff
    hi semshiParameterUnused ctermfg=117 guifg=#87d7ff cterm=underline gui=underline
    hi semshiFree            ctermfg=218 guifg=#ffafd7
    hi semshiBuiltin         ctermfg=207 guifg=#ff5fff
    hi semshiAttribute       ctermfg=43  guifg=#00ffaf
    hi semshiSelf            ctermfg=249 guifg=#b2b2b2
    hi semshiUnresolved      ctermfg=226 guifg=#ffff00 cterm=underline gui=underline
    hi semshiSelected        ctermfg=231 guifg=#ffffff ctermbg=161 guibg=#d7005f

    hi semshiErrorSign       ctermfg=231 guifg=#ffffff ctermbg=160 guibg=#d70000
    hi semshiErrorChar       ctermfg=231 guifg=#ffffff ctermbg=160 guibg=#d70000
endfunction

autocmd FileType python call SolarizedSemshi()
