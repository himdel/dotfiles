set nocompatible
syntax on
set mouse=a
set list
set listchars=tab:__,trail:'
set hlsearch
set incsearch
set ruler
set ignorecase
set autoindent
set bg=dark
set display=lastline
set showmatch
set shiftround
set shiftwidth=2
set ts=2
set expandtab

" :X encrypts current file
set cm=blowfish

" jump to last position when reopening
if v:progname !~ "vimdiff"
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"z." | endif
endif

" sane filename completion
set wildmode=longest,list:longest,list:full

" make X clipboard the default; needs vim-gtk, not basic
set clipboard=unnamed,unnamedplus
set clipboard+=autoselectplus

" plugins
execute pathogen#infect()

map <C-T> :Files<CR>
map <C-C> :Commits<CR>
map <C-G> :Tags<CR>
"let g:ackprg = 'ag --nogroup --nocolor --column'
"map <C-A> :Ack
"nnoremap <F8> :UndotreeToggle<CR>
"map <F2> :NERDTreeToggle<CR>

" testing { from..
" http://www.reddit.com/r/vim/comments/19u4u0/what_normal_mode_mappings_do_you_have_in_your/

let mapleader=','

" quick buffer navigation
nnoremap gb :buffers<CR>:sb<Space>

" append a semicolon
nnoremap <leader>; A;<Esc>

" write a file that I didn't open with the right privileges
nnoremap <leader>ss :w !sudo tee %<CR>

" execute line under cursor
nnoremap <C-x> yyp!!sh<CR><Esc>

let g:netrw_liststyle=3

nmap \l :setlocal number!<CR>
nmap \p :set paste!<CR>
nmap \q :nohlsearch<CR>

nmap \2 :set expandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>
nmap \4 :set expandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>
nmap \8 :set expandtab tabstop=8 shiftwidth=8 softtabstop=8<CR>
nmap \t :set noexpandtab tabstop=4 softtabstop=4 shiftwidth=4<CR>

nmap \w :setlocal wrap!<CR>:setlocal wrap?<CR>

au BufNewFile,BufReadPost Makefile set noexpandtab tabstop=4 shiftwidth=4 softtabstop=4

" set digraph

nnoremap Q <nop>

map <F5> :w<CR> \| :!npx prettier --write %<CR> \| :e<CR>
