call plug#begin()

Plug 'editorconfig/editorconfig-vim'
Plug 'machakann/vim-highlightedyank'
Plug 'terminalnode/sway-vim-syntax'
Plug 'b3nj5m1n/kommentary'
Plug 'vimwiki/vimwiki'
Plug 'joshdick/onedark.vim'

call plug#end()

set termguicolors

colorscheme onedark

set number relativenumber
set tabstop=4
set shiftwidth=4
set nohlsearch
set noshowmode

let mapleader=","

let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
