" python3 from powerline.vim import setup as powerline_setup
" python3 powerline_setup()
" python3 del powerline_setup

set number relativenumber
set laststatus=2
set tabstop=4
set softtabstop=0 noexpandtab
set shiftwidth=4
syntax on	

" Recompile suckless programs automatically:
autocmd BufWritePost config.h !sudo make clean install
autocmd BufWritePost config.def.h !cp config.def.h config.h && sudo make clean install
" Source zsh
"autocmd BufWritePost .zshrc !source ~/.zshrc
"autocmd BufWritePost .zprofile !source ~/.zprofile
" Xresources
"autocmd BufWritePost .Xresources !xrdb ~/.Xresources

let g:airline_powerline_fonts=1
let g:airline_theme='simple'
let g:airline_extensions=[]
"let g:airline_section_error=''
"let g:airline_section_warning=''
