" Plugins using vim-plug
call plug#begin('~/.config/nvim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'lervag/vimtex'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'kovetskiy/sxhkd-vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/matchit.zip'
Plug 'tpope/vim-ragtag'
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
Plug 'glts/vim-radical'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-eunuch'
Plug 'plasticboy/vim-markdown'

"Plug 'rrethy/vim-hexokinase'
"Plug 'valloric/youcompleteme' "ycm slows startup
"Plug 'shougo/deoplete.nvim'
"
"Plug 'godlygeek/tabular'
"Plug 'easymotion/vim-easymotion'
call plug#end()


" Vanilla
set number relativenumber
set mouse=a
set laststatus=2
" set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set tabstop=2 softtabstop=0 shiftwidth=2 noexpandtab
set foldlevel=99
set noshowmode
" set clipboard=unnamed
set clipboard=unnamedplus
set ignorecase smartcase
set autoindent smartindent cindent
set cursorline cursorcolumn
highlight clear CursorLine
highlight clear CursorColumn
highlight clear MatchParen
highlight CursorLine cterm=bold
highlight CursorLineNR ctermbg=8 cterm=bold
highlight CursorColumn cterm=bold
highlight MatchParen ctermfg=red cterm=bold
"set termguicolors
syntax on	

let mapleader = "\<Space>"
" let maplocalleader = "\<Space>"
nnoremap Y y$
inoremap <C-j> <Down>
inoremap <C-k> <Up>
nnoremap <Leader>/ :noh<CR>
inoremap <C-v> <ESC>"+pa
vnoremap <C-c> "+y
nnoremap <Leader>h <C-w><C-h>
nnoremap <Leader>j <C-w><C-j>
nnoremap <Leader>k <C-w><C-k>
nnoremap <Leader>l <C-w><C-l>
nnoremap <Leader>s <C-w><C-s>
nnoremap <Leader>v <C-w><C-v>
nnoremap <Leader>n <C-w><C-n>
nnoremap <Leader>q <C-w><C-q>
nnoremap <Leader>c <C-w><C-c>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>a :qa<CR>

" set undodir=$XDG_DATA_HOME/vim/undo
" set directory=$XDG_DATA_HOME/vim/swap
" set backupdir=$XDG_DATA_HOME/vim/backup
" set viewdir=$XDG_DATA_HOME/vim/view
" set viminfo+='1000,n$XDG_DATA_HOME/vim/viminfo
" set runtimepath=$XDG_CONFIG_HOME/vim,$VIMRUNTIME,$XDG_CONFIG_HOME/vim/after

autocmd BufRead,BufNewFile profile,aliases setfiletype sh
autocmd BufRead,BufNewFile README setfiletype markdown

autocmd BufWritePost *.sh :silent exec '![ $(stat -c "%a" %) = 755 ] || chmod 755 %'
" autocmd BufNewFile *.sh 0r ~/.config/nvim/skeleton/skeleton.sh

augroup suckless
  autocmd!
  autocmd BufWritePost config.def.h !cp config.def.h config.h && sudo make install clean 
augroup end

augroup markdownmap
  autocmd!
  autocmd Filetype markdown nnoremap <LocalLeader>mm :InstantMarkdownPreview <CR>
  autocmd Filetype markdown nnoremap <LocalLeader>ms :InstantMarkdownStop <CR>
augroup end

function! PlainText()
	if(&filetype == '')
		set comments= commentstring=#\ %s
	endif
endfunction
autocmd BufEnter * call PlainText()

autocmd BufWritePost *Xresources !xrdb %

" Plugin specific
" CoC
let g:coc_global_extensions = [
  \ 'coc-actions',
	\ 'coc-json',
	\ 'coc-pairs',
	\ 'coc-python',
	\ 'coc-tabnine',
	\ 'coc-lists'
	\ ]
	" \ 'coc-texlab',
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

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
" inoremap <silent><expr> <Tab>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<Tab>" :
"       \ coc#refresh()
inoremap <expr> <c-space> pumvisible() ? "\<C-y>" : coc#refresh()
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
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
filetype plugin on
"Uncomment to override defaults:
"need to npm -g install instant-markdown-d
let g:instant_markdown_slow = 1
let g:instant_markdown_autostart = 0
"let g:instant_markdown_mathjax = 1
"let g:instant_markdown_logfile = '/tmp/instant_markdown.log'
"let g:instant_markdown_autoscroll = 0
"let g:instant_markdown_browser = "qutebrowser"

" Ragtag
let g:ragtag_global_maps = 1

" Nerdtree
nnoremap <C-n> :NERDTreeToggle<CR>

" Gitgutter
let g:gitgutter_enabled = 1
let g:gitgutter_map_keys = 0

" Commentary 
" autocmd FileType apache setlocal commentstring=#\ %s
" autocmd FileType c setlocal commentstring=\/\/\ %s
autocmd Filetype xdefaults setlocal commentstring=!\ %s

" Repeat
"silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

" Markdown
" let g:vim_markdown_folding_level = 5
