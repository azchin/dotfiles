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
set cursorline cursorcolumn
set notermguicolors
colorscheme vim
highlight clear CursorLine
highlight clear CursorColumn
highlight clear MatchParen
highlight clear SignColumn
highlight clear ModeMsg
highlight CursorLine cterm=bold
highlight CursorLineNR ctermbg=black cterm=bold
highlight CursorColumn cterm=bold
highlight MatchParen ctermfg=red cterm=bold
highlight SignColumn ctermfg=yellow ctermbg=black
highlight ModeMsg ctermfg=yellow cterm=bold

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
autocmd BufWritePost *Xresources !xrdb %
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
nnoremap <silent> <Leader>we :wincmd =<CR>
nnoremap <silent> <Leader>ws :wincmd s<CR>
nnoremap <silent> <Leader>wv :wincmd v<CR>
nnoremap <silent> <Leader>wo :wincmd o<CR>
nnoremap <silent> <Leader>N :vnew<CR>
nnoremap <silent> <Leader>n :Lex<CR>
nnoremap <silent> <Leader>u :UndotreeToggle<CR>
nnoremap <silent> <Leader>wq :wincmd q<CR>
nnoremap <silent> <Leader>c :wincmd c<CR>
nnoremap <silent> <Leader>s :w<CR>
nnoremap <silent> <Leader>qq :qa<CR>
nnoremap <silent> <Leader>Q :q!<CR>
nnoremap <silent> <Leader>A :qa!<CR>
nnoremap <silent> <Leader>bd :bd<CR>
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
set statusline+=%n\                      " buffer number
set statusline+=%h%m%r%w                    " flags
" set statusline+=%f\                          " file name
set statusline+=%t\                          " file name tail
set statusline+=[%{strlen(&ft)?&ft:'none'},  " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc}, " encoding
set statusline+=%{&fileformat}]              " file format
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
" Plug 'neovim/nvim-lspconfig'  " Bloated /s
Plug 'windwp/nvim-autopairs'  " Why isn't this in vanilla Vim
Plug 'hrsh7th/nvim-cmp'
" Plug 'hrsh7th/cmp-nvim-lsp'
" Plug 'saadparwaiz1/cmp_luasnip'
" Plug 'L3MON4D3/LuaSnip'

call plug#end()

" #################################################################
" Plugin specific
" Quick scope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Autopairs
:lua require('mypairs')

" LSP
" :lua require('mylsp')
