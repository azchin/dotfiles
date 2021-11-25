" #################################################################
" Vanilla
set number relativenumber
set lazyredraw
set mouse=a
set laststatus=2
set tabstop=4 shiftwidth=4 expandtab
" set tabstop=8 softtabstop=0 shiftwidth=8 noexpandtab
" set tabstop=2 softtabstop=0 shiftwidth=2 noexpandtab
set foldlevel=99
set signcolumn=no
set showmode
" set clipboard=unnamed
set clipboard=unnamedplus
" set splitright
set ignorecase smartcase
set autoindent smartindent cindent
set nobackup nowritebackup
set undodir=$XDG_DATA_HOME/nvim/undo undofile 
set directory=$XDG_DATA_HOME/nvim/swap// swapfile
set wildmode=longest,list,full
set cursorline cursorcolumn
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
" highlight Search ctermbg=green
" set termguicolors
syntax on	
" set backupdir=$XDG_DATA_HOME/nvim/backup//
" set viewdir=$XDG_DATA_HOME/vim/view
" set viminfo+='1000,n$XDG_DATA_HOME/vim/viminfo
" set runtimepath=$XDG_CONFIG_HOME/vim,$VIMRUNTIME,$XDG_CONFIG_HOME/vim/after

" Key mappings
let mapleader = "\<Space>"
" let maplocalleader = "\<Space>"
nnoremap Y y$
" nnoremap n nzz
" nnoremap N Nzz
inoremap <C-j> <Down>
inoremap <C-k> <Up>
nnoremap <silent> <Leader>/ :noh<CR>
inoremap <silent> <C-v> <ESC>"+pa
vnoremap <silent> <C-c> "+y
nnoremap <silent> <Leader>wh :wincmd h<CR>
nnoremap <silent> <Leader>wj :wincmd j<CR>
nnoremap <silent> <Leader>wk :wincmd k<CR>
nnoremap <silent> <Leader>wl :wincmd l<CR>
" nnoremap <silent> <Leader>H :vertical resize +2<CR>
" nnoremap <silent> <Leader>J :resize -2<CR>
" nnoremap <silent> <Leader>K :resize +2<CR>
" nnoremap <silent> <Leader>L :vertical resize -2<CR>
nnoremap <silent> <Leader>we :wincmd =<CR>
nnoremap <silent> <Leader>ws :wincmd s<CR>
nnoremap <silent> <Leader>wv :wincmd v<CR>
nnoremap <silent> <Leader>wo :wincmd o<CR>
" nnoremap <silent> <Leader>n :wincmd n<CR>
nnoremap <silent> <Leader>N :vnew<CR>
nnoremap <silent> <Leader>n :Lex<CR>
nnoremap <silent> <Leader>u :UndotreeToggle<CR>
nnoremap <silent> <Leader>wq :wincmd q<CR>
nnoremap <silent> <Leader>c :wincmd c<CR>
nnoremap <silent> <Leader>s :w<CR>
nnoremap <silent> <Leader>qq :qa<CR>
nnoremap <silent> <Leader>Q :q!<CR>
" nnoremap <silent> <Leader>W :wq<CR>
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

" Netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 1
let g:netrw_list_hide = ".*\.swp,.*\.git"
let g:netrw_browse_split = 0
let g:netrw_winsize = 25
let g:netrw_bufsettings = "noma nomod nu rnu nowrap ro nobl"
" let g:netrw_altv = 1
set fillchars=vert:\ 
highlight clear VertSplit
highlight VertSplit ctermfg=black ctermbg=black

" Autocommands
autocmd BufRead,BufNewFile profile,aliases setfiletype sh
autocmd BufRead,BufNewFile README setfiletype markdown
autocmd BufRead,BufNewFile xmobar* setfiletype haskell

augroup haskell
	autocmd!
	autocmd Filetype haskell set tabstop=4 shiftwidth=4 expandtab
augroup end

augroup xml
    autocmd!
    autocmd Filetype xml set tabstop=2 shiftwidth=2 expandtab
augroup end

autocmd BufWritePost *.sh :silent exec '![ $(stat -c "%a" %) = 755 ] || chmod 755 %'
" autocmd BufNewFile *.sh 0r ~/.config/nvim/skeleton/skeleton.sh

augroup suckless
  autocmd!
  " autocmd BufWritePost config.def.h !cp config.def.h config.h && sudo make install clean 
  autocmd BufWritePost config.h !sudo make install clean 
augroup end

function! PlainText()
	if(&filetype == '')
		set comments= commentstring=#\ %s
	endif
endfunction
autocmd BufEnter * call PlainText()

autocmd BufWritePost *Xresources !xrdb %


" cnoreabbrev <expr> help ((getcmdtype() is# ':'    && getcmdline() is# 'help')?('vert help'):('help'))
cnoreabbrev <expr> h ((getcmdtype() is# ':'    && getcmdline() is# 'h')?('vert h'):('h'))

" #################################################################
" Plugins using vim-plug
" sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
call plug#begin('$XDG_DATA_HOME/nvim/plugged')

Plug 'tpope/vim-repeat'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
"Plug 'lervag/vimtex'
" Plug 'scrooloose/nerdtree'
" Plug 'kovetskiy/sxhkd-vim'
"Plug 'airblade/vim-gitgutter'
Plug 'vim-scripts/matchit.zip'
Plug 'tpope/vim-ragtag'
Plug 'glts/vim-radical'
" Plug 'plasticboy/vim-markdown'
Plug 'mbbill/undotree'
Plug 'unblevable/quick-scope' 
Plug 'tommcdo/vim-exchange'

"Plug 'rrethy/vim-hexokinase'
"Plug 'valloric/youcompleteme' "ycm slows startup
"Plug 'shougo/deoplete.nvim'
"Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
"
"Plug 'godlygeek/tabular'
"Plug 'easymotion/vim-easymotion'
"Plug 'tpope/vim-vinegar'
" Plug 'spolu/dwm.vim'
call plug#end()

" #################################################################
" Plugin specific
" CoC
let g:coc_global_extensions = [
  \ 'coc-actions',
	\ 'coc-pairs',
	\ 'coc-lists'
	\ ]
	" " TODO remove/modify signs
	" \ 'coc-texlab',
	" \ 'coc-tabnine',
	"	\ 'coc-snippets',
	"	\ 'coc-prettier',
	"	\ 'coc-tsserver',
	" \ 'coc-eslint',
	"	\ 'coc-flow',
	"	\ 'coc-html',
	"	\ 'coc-java',
	"	\ 'coc-jedi',
	"	\ 'coc-yaml',
	"	\ 'coc-template',
	" \ 'coc-python',
	" \ 'coc-json',

" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~ '\s'
" endfunction
" inoremap <silent><expr> <Tab>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<Tab>" :
"       \ coc#refresh()
" inoremap <expr> <c-space> pumvisible() ? "\<C-y>" : coc#refresh()
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" inoremap <expr> <BS> pumvisible() ? "\<Esc>i"

" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'simple' "dark_minimal
let g:airline_extensions = [
	\ 'branch', 
  \ 'hunks',
	\ 'keymap', 
	\ 'wordcount', 
	\ 'vimtex', 
	\ 'fugitiveline'
	\ ]
" other extensions: 
" tabline, po, hunks, tmuxline, coc
"let g:airline_section_error = ''
"let g:airline_section_warning = ''

" Vimtex
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_method = 'zathura'
let g:tex_flavor = 'latex'
" let g:vimtex_quickfix_enabled = 0
" let g:vimtex_quickfix_mode = 0

" Instant Markdown
"filetype plugin on
""Uncomment to override defaults:
""need to npm -g install instant-markdown-d
"let g:instant_markdown_slow = 1
"let g:instant_markdown_autostart = 0
""let g:instant_markdown_mathjax = 1
""let g:instant_markdown_logfile = '/tmp/instant_markdown.log'
""let g:instant_markdown_autoscroll = 0
""let g:instant_markdown_browser = "qutebrowser"
"augroup markdownmap
"  autocmd!
"  autocmd Filetype markdown nnoremap <LocalLeader>mm :InstantMarkdownPreview <CR>
"  autocmd Filetype markdown nnoremap <LocalLeader>ms :InstantMarkdownStop <CR>
"augroup end


" Ragtag
let g:ragtag_global_maps = 1

" Nerdtree
" nnoremap <C-n> :NERDTreeToggle<CR>

" Gitgutter
let g:gitgutter_enabled = 1
let g:gitgutter_map_keys = 0
function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction

" Commentary 
" autocmd FileType apache setlocal commentstring=#\ %s
" autocmd FileType c setlocal commentstring=\/\/\ %s
autocmd Filetype xdefaults setlocal commentstring=!\ %s

" Repeat
"silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

" Markdown
" let g:vim_markdown_folding_level = 5

" Undotree
let g:undotree_SplitWidth = 25
let g:undotree_ShortIndicators = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_WindowLayout = 2
let g:undotree_DiffpanelHeight = 8

" Quick scope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
let g:qs_max_chars=128
" let g:qs_lazy_highlight = 1
" highlight QuickScopePrimary ctermfg=155 cterm=underline
" highlight QuickScopeSecondary ctermfg=81 cterm=underline
highlight QuickScopePrimary ctermfg=226 cterm=underline
highlight QuickScopeSecondary ctermfg=99 cterm=underline

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

" default the statusline to green when entering Vim
highlight clear StatusLine
highlight clear StatusLineNC
hi statusline ctermbg=black ctermfg=white
hi StatusLineNC ctermbg=black ctermfg=darkgrey

set statusline=   " clear the statusline for when vimrc is reloaded
" set statusline+=%#ModeMsg#
set statusline+=\ 
" set statusline+=%-3.3n\                      " buffer number
set statusline+=%n\                      " buffer number
set statusline+=%h%m%r%w                    " flags
" set statusline+=%f\                          " file name
set statusline+=%t\                          " file name tail
set statusline+=[%{strlen(&ft)?&ft:'none'},  " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc}, " encoding
set statusline+=%{&fileformat}]              " file format
set statusline+=%=                           " right align
" set statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}\  " highlight
" set statusline+=%b,0x%-8B\                   " current char
" set statusline+=%<(%{GitStatus()})\ 
" set statusline+=(%l/%L\ %c%V)\ %p%%
set statusline+=(%l/%L\ %c)\ %p%%
set statusline+=\ 
" set statusline+=%-8.(%l,%c%V%)\ %<%p%%        " offset
