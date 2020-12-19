let g:gruvbox_contrast_dark = 'hard'
let g:lightline = { 'colorscheme': 'gruvbox' }

call plug#begin()

Plug 'editorconfig/editorconfig-vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'mg979/vim-visual-multi'
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'terminalnode/sway-vim-syntax'
Plug 'tpope/vim-commentary'

call plug#end()

colorscheme gruvbox

set listchars=tab:→\ ,space:∙
set list

set termguicolors
set number relativenumber
set tabstop=4
set shiftwidth=4
set nohlsearch
set noshowmode

nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gr <Plug>(coc-references)
nnoremap <C-p> :GFiles<CR>

map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

map <Del> <nop>

imap <Del> <nop>
