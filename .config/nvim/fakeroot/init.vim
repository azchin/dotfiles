" #################################################################
" Vanilla
set number relativenumber              " Line numbers
set tabstop=4 shiftwidth=4 expandtab   " Tab and spaces
set autoindent cindent                 " Indent on newline
set ignorecase smartcase               " Case-sensitivity for search
set mouse=a                            " Crutch
set clipboard=unnamedplus              " Use clipboard over primary (X thing)
set autochdir                          " Current dir is the file

" Change normal mode 'Y' from 'yy' to 'y$'
nnoremap Y y$

" #################################################################
" Netrw (built-in file explorer)
let g:netrw_bufsettings = "noma nomod nu rnu nowrap ro nobl"
let g:netrw_liststyle = 3
let g:netrw_winsize = 25
let g:netrw_banner = 0
let g:netrw_list_hide = ".*\.swp,.*\.git"
set fillchars=vert:\ 
highlight clear VertSplit
highlight VertSplit ctermfg=black ctermbg=black

" #################################################################
" Plugins using vim-plug
" Use below command to install vim-plug
" sh -c 'curl -fLo "$HOME/.local/share/nvim/site/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
" In neovim call ':PlugInstall'
call plug#begin('$HOME/.local/share/nvim/plugged')

Plug 'tpope/vim-unimpaired'   " Goated
Plug 'tpope/vim-commentary'   " Goated
Plug 'tpope/vim-surround'     " Goated
Plug 'unblevable/quick-scope' " Goated
Plug 'neovim/nvim-lspconfig'  " Bloated /s
Plug 'windwp/nvim-autopairs'  " Why isn't this in vanilla Vim
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'

call plug#end()

" #################################################################
" Plugin specific
" Quick scope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Autopairs
:lua require('mypairs')

" LSP
:lua require('mylsp')
