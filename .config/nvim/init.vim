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

" More advanced settings
set foldlevel=99
set signcolumn=no
set nobackup nowritebackup
set undodir=$HOME/.local/share/nvim/undo undofile 
set directory=$HOME/.local/share/nvim/swap// swapfile
set wildmode=longest,list,full

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
" Autocommands
autocmd BufRead,BufNewFile profile,aliases setfiletype sh
autocmd BufWritePost *.sh :silent exec '![ $(stat -c "%a" %) = 755 ] || chmod 755 %'
autocmd Filetype xdefaults setlocal commentstring=!\ %s

augroup xml
    autocmd!
    autocmd Filetype xml set tabstop=2 shiftwidth=2 expandtab
augroup end

function! PlainText()
	if(&filetype == '')
		set comments= commentstring=#\ %s
	endif
endfunction
autocmd BufEnter * call PlainText()


" #################################################################
" Key mappings
let mapleader = "\<Space>"
inoremap <C-j> <Down>
inoremap <C-k> <Up>
nnoremap <silent> <Leader>/ :noh<CR>
inoremap <silent> <C-v> <ESC>"+pa
vnoremap <silent> <C-c> "+y
nnoremap <silent> <Leader>wh :wincmd h<CR>
nnoremap <silent> <Leader>wj :wincmd j<CR>
nnoremap <silent> <Leader>wk :wincmd k<CR>
nnoremap <silent> <Leader>wl :wincmd l<CR>
nnoremap <silent> <Leader>w<Left> :wincmd h<CR>
nnoremap <silent> <Leader>w<Down> :wincmd j<CR>
nnoremap <silent> <Leader>w<Up> :wincmd k<CR>
nnoremap <silent> <Leader>w<Right> :wincmd l<CR>
nnoremap <silent> <Leader>we :wincmd =<CR>
nnoremap <silent> <Leader>ws :wincmd s<CR>
nnoremap <silent> <Leader>wv :wincmd v<CR>
nnoremap <silent> <Leader>wo :wincmd o<CR>
nnoremap <silent> <Leader>N :vnew<CR>
nnoremap <silent> <Leader>n :Lex<CR>
nnoremap <silent> <Leader>dd :Ex<CR>
nnoremap <silent> <Leader>td :Tex<CR>
nnoremap <silent> <Leader>wq :wincmd q<CR>
nnoremap <silent> <Leader>c :wincmd c<CR>
nnoremap <silent> <Leader>s :w<CR>
nnoremap <silent> <Leader>qq :q<CR>
nnoremap <silent> <Leader>qt :tabclose<CR>
nnoremap <silent> <Leader>qf :qa<CR>
nnoremap <silent> <Leader>qb :bd<CR>
nnoremap <silent> <Leader>Q :q!<CR>
nnoremap <silent> <Leader>A :qa!<CR>
function! SignToggle()
	if(&signcolumn == 'no') 
		set signcolumn=auto
	else
		set signcolumn=no
	endif
endfunction
nnoremap <silent> <Leader>c :call SignToggle()<CR>

" #################################################################
" Statusline
set laststatus=2

function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi statusline ctermfg=green
  elseif a:mode == 'r'
    hi statusline ctermfg=red
  else
    hi statusline ctermfg=magenta
  endif
endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertChange * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi statusline ctermbg=black ctermfg=white

highlight clear StatusLine
highlight clear StatusLineNC
hi statusline ctermbg=black ctermfg=white
hi StatusLineNC ctermbg=black ctermfg=darkgrey

set statusline=   " clear the statusline for when vimrc is reloaded
set statusline+=\ 
" set statusline+=%n\                      " buffer number
set statusline+=%h%m%r%w                    " flags
set statusline+=%t\                          " file name tail
set statusline+=[%{strlen(&ft)?&ft:'none'},  " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc}, " encoding
set statusline+=%{&fileformat}]              " file format
set statusline+=\ 
set statusline+=%=                           " center align
set statusline+=%F                           " file name
set statusline+=%=                           " right align
set statusline+=(%l/%L\ %c)\ %p%%
set statusline+=\ 

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
Plug 'jasonccox/vim-wayland-clipboard'
Plug 'chaoren/vim-wordmotion'
" Plug 'projekt0n/github-nvim-theme'
" Plug 'sainnhe/edge'
" Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'miikanissi/modus-themes.nvim'
Plug 'neovim/nvim-lspconfig'  " Bloated /s
Plug 'windwp/nvim-autopairs'  " Why isn't this in vanilla Vim
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
" Plug 'NOSDuco/remote-sshfs.nvim'
Plug 'mbbill/undotree'

call plug#end()

" #################################################################
" Plugin specific

" More keybinds
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <silent> <Leader>u :UndotreeToggle<CR>

set notermguicolors
" colorscheme modus_operandi
colorscheme vim

" neovide
if exists("g:neovide")
    " Put anything you want to happen only in Neovide here
    let g:neovide_position_animation_length = 0
    colorscheme modus_operandi
    let g:neovide_theme = 'auto'
    let g:neovide_cursor_animation_length = 0.02
    set guifont=DejaVu\ Sans\ Mono:h14
endif

set cursorline cursorcolumn
highlight clear CursorLine
highlight clear CursorColumn
highlight clear MatchParen
highlight clear SignColumn
highlight clear ModeMsg
" highlight CursorLine cterm=bold gui=bold
highlight CursorLineNR ctermbg=black cterm=bold gui=bold
" highlight CursorColumn cterm=bold gui=bold
highlight MatchParen ctermfg=red cterm=bold gui=bold
highlight SignColumn ctermfg=yellow ctermbg=black
highlight ModeMsg ctermfg=yellow cterm=bold gui=bold

" Quick scope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Autopairs
:lua require('mypairs')

" LSP
:lua require('mylsp')
