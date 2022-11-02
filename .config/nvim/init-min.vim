" #################################################################
" Vanilla
set number relativenumber
set tabstop=4 shiftwidth=4 expandtab
set autoindent cindent
set ignorecase smartcase
set mouse=a
set clipboard=unnamedplus
set autochdir
nnoremap Y y$

" #################################################################
" Netrw
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
" sh -c 'curl -fLo "$HOME/.local/share/nvim/site/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
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
