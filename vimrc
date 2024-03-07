set encoding=UTF-8
set background=light
set number relativenumber
set cursorline
" set cursorcolumn
set spell
syntax on

set laststatus=2
hi User0 ctermfg=white ctermbg=black
hi User1 ctermfg=None ctermbg=green

set statusline+=%0*
set statusline+=\ %f
set statusline+=\   
set statusline+=%1*
set statusline+=%=
set statusline+=%0*
set statusline+=\ %l
set statusline+=\ 行
set statusline+=\ %c
set statusline+=\ 列
set statusline+=\   

set nowrap
set virtualedit=onemore
set smarttab
set smartindent
set expandtab
set tabstop=4
set shiftwidth=4

set wrapscan
set incsearch
set hlsearch
set ignorecase

inoremap [ []<left>
inoremap ( ()<left>
inoremap { {}<left>
inoremap " ""<left>
inoremap ' ''<left>
