set nocompatible
syntax on
set autoindent
set bg=dark
set display=lastline
set expandtab
set hlsearch
set ignorecase
set incsearch
set list
set listchars=tab:__,trail:~
set mouse=a
set ruler
set shiftround
set shiftwidth=2
set showmatch
set ts=2
set wildmode=longest,list:longest,list:full

" jump to last position when reopening
if v:progname !~ "vimdiff"
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"z." | endif
endif

" make X clipboard the default; needs vim-gtk, not basic
set clipboard=unnamed,unnamedplus
set clipboard+=autoselectplus

" plugins
execute pathogen#infect()

let g:NERDTreeQuitOnOpen = 1
map <F2> :NERDTreeFind<CR>
map <F3> :NERDTreeClose<CR>

map <C-T> :Files<CR>
map <C-C> :Commits<CR>
map <C-G> :Tags<CR>
nnoremap <F7> :Rg 

nnoremap <F8> :UndotreeToggle<CR>

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

set suffixesadd+=.js,.jsx,.ts,.tsx,.mjs,.cjs
set path+=$PWD/node_modules
