set number relativenumber
set laststatus=2
set tabstop=4
set softtabstop=0 noexpandtab
set shiftwidth=4
syntax on	

" Recompile suckless programs automatically:
autocmd BufWritePost config.h !sudo make clean install
autocmd BufWritePost config.def.h !cp config.def.h config.h && sudo make clean install

" Plugins using vim-plug
call plug#begin('~/.vim/plugged')

"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'lervag/vimtex'
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}

call plug#end()


" coc config
"let g:coc_global_extensions = [
"	\ 'coc-snippets',
"	\ 'coc-pairs',
"	\ 'coc-tsserver',
"	\ 'coc-eslint',
"	\ 'coc-prettier',
"	\ 'coc-json',
"	\ 'coc-html',
"	\ 'coc-java',
"	\ 'coc-yaml',
"	\ 'coc-python',
"	\ 'coc-lists',
"	\ 'coc-tabnine',
"	\ ]

let g:airline_powerline_fonts = 1
let g:airline_theme = 'simple'
let g:airline_extensions = []
"let g:airline_section_error = ''
"let g:airline_section_warning = ''

let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_method = 'zathura'
let g:tex_flavor = 'latex'

filetype plugin on
"Uncomment to override defaults:
"let g:instant_markdown_slow = 1
"let g:instant_markdown_autostart = 0
"let g:instant_markdown_open_to_the_world = 1
"let g:instant_markdown_allow_unsafe_content = 1
"let g:instant_markdown_allow_external_content = 0
"let g:instant_markdown_mathjax = 1
"let g:instant_markdown_logfile = '/tmp/instant_markdown.log'
"let g:instant_markdown_autoscroll = 0
"let g:instant_markdown_port = 8888
"let g:instant_markdown_python = 1
let g:instant_markdown_browser = "qutebrowser"

