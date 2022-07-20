set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set relativenumber
set nu
set nohlsearch
set hidden
set nowrap
set ignorecase
set smartcase
set noswapfile
set nobackup
set incsearch
set scrolloff=8
set completeopt=menuone,noinsert,noselect
set signcolumn=number
set clipboard=unnamedplus
set termguicolors
set cursorline
set mouse=a

let mapleader = " "

" create undodir if it doesnt exist
silent !mkdir -p "~/.vim/undo" > /dev/null 2>&1
set undodir=~/.vim/undo
set undofile
set shadafile=~/.vim/viminfo

" Install vim-plug if not found
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'shaunsingh/nord.nvim' " better nord color scheme
    Plug 'nvim-lua/plenary.nvim' " a Lua module for asynchronous programming using coroutines
    Plug 'nvim-telescope/telescope.nvim' " highly extendable fuzzy finder over lists
    Plug 'norcalli/nvim-colorizer.lua' " color highlighter
    Plug 'winston0410/range-highlight.nvim' " highlights ranges you have entered in commandline
    Plug 'sunjon/shade.nvim' " dims your inactive windows
    Plug 'lukas-reineke/indent-blankline.nvim' " adds indentation guides to all lines
    Plug 'NMAC427/guess-indent.nvim' " Guess proper indentation
    Plug 'lewis6991/gitsigns.nvim' " Super fast git decorations
    Plug 'numToStr/Comment.nvim' " Smart and Powerful commenting plugin
    Plug 'nvim-lualine/lualine.nvim' " Statusline
    Plug 'kyazdani42/nvim-web-devicons' " Icons for statusline
    Plug 'ggandor/lightspeed.nvim' " Move around blazingly fast
    Plug 'folke/which-key.nvim' " Keybind hint menu
call plug#end()

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" nord options
let g:nord_contrast = v:true " Make sidebars and popup menus like nvim-tree and telescope have a different background
let g:nord_borders = v:true " Enable the border between verticaly split windows visible
let g:nord_italic = v:false " enables/disables italics
let g:nord_uniform_diff_background = v:true " enables/disables colorful backgrounds when used in diff mode
colorscheme nord

" autocmd to trim trailing whitespace on save
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup CUSTOM
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END

" move lines around in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Telescope Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leadef>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

" load lua config from nvim/lua/config.lua
lua require('config')
