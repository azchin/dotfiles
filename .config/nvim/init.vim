set number relativenumber
set mouse=a
set laststatus=2
" set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set tabstop=2 softtabstop=0 shiftwidth=2 noexpandtab
set noshowmode
set clipboard=unnamed
set ignorecase smartcase
set autoindent smartindent cindent
set cursorline cursorcolumn
highlight clear CursorLine
highlight clear CursorColumn
highlight CursorLineNR ctermbg=8 cterm=bold
highlight CursorLine cterm=bold
"highlight CursorColumn cterm=bold,italic
highlight CursorColumn cterm=bold
"set termguicolors
syntax on	

" Recompile suckless programs automatically:
augroup suckless
  autocmd!
  autocmd BufWritePost config.h !sudo make clean install
  autocmd BufWritePost config.def.h !cp config.def.h config.h && sudo make clean install
augroup end

augroup markdownmap
  autocmd!
  autocmd Filetype markdown nnoremap <LocalLeader>mm :InstantMarkdownPreview <CR>
  autocmd Filetype markdown nnoremap <LocalLeader>ms :InstantMarkdownStop <CR>
augroup end

inoremap <C-j> <Down>
inoremap <C-k> <Up>
nnoremap <Leader>/ :noh<CR>
inoremap <C-v> <ESC>"+pa
vnoremap <C-c> "+y

" Plugins using vim-plug
call plug#begin('~/.vim/plugged')

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
"Plug 'rrethy/vim-hexokinase'
"Plug 'valloric/youcompleteme' "ycm slows startup
"Plug 'shougo/deoplete.nvim'
"
"Plug 'godlygeek/tabular'
"Plug 'easymotion/vim-easymotion'

call plug#end()


" CoC
let g:coc_global_extensions = [
  \ 'coc-actions',
	\ 'coc-json',
	\ 'coc-pairs',
	\ 'coc-python',
	\ 'coc-tabnine',
	\ 'coc-texlab',
	\ 'coc-lists'
	\ ]
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
"autocmd FileType apache setlocal commentstring=#\ %s

" Repeat
"silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)
