" settings
set encoding=UTF-8
set number
set norelativenumber
set cursorline
set nocursorcolumn

set nowrap
set virtualedit=onemore
set smartindent
set smarttab
set expandtab
set tabstop=4
set shiftwidth=4

set wrapscan
set incsearch
set hlsearch
set ignorecase
set smartcase

set background=light
set spell
syntax on

" statusbar
set laststatus=2 " show always
hi User0 ctermfg=white ctermbg=black
hi User1 ctermfg=None ctermbg=green
set statusline=%0*\ %f\ %1*%=%0*\ %l\ 行\ %c\ 列\ 

" tabline
set showtabline=1
hi TablineFill ctermfg=white ctermbg=None
hi Tabline ctermfg=green ctermbg=white
hi TablineSel ctermfg=cyan ctermbg=white

" remap
nnoremap <C-t> :tabnew<cr>
nnoremap <C-w> :tabclose<cr>
nnoremap <C-l> :tabnext<cr>
nnoremap <C-h> :tabprev<cr>

nnoremap s ^
nnoremap e $

inoremap ( ()<left>
inoremap { {}<left>
inoremap [ []<left>
inoremap < <><left>
inoremap ' ''<left>
inoremap " ""<left>

" highlighting
hi LineNr ctermfg=green
hi CursorLineNr ctermfg=black
