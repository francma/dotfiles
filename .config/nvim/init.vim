call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'morhetz/gruvbox'
Plug 'machakann/vim-highlightedyank'
Plug 'tpope/vim-commentary'
Plug 'terminalnode/sway-vim-syntax'

call plug#end()

autocmd vimenter * colorscheme gruvbox

set listchars=tab:→\ ,space:∙
set list

set termguicolors
set number relativenumber
set tabstop=4
set shiftwidth=4
set nohlsearch

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
