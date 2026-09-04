set nocompatible
syntax on
" needed for omnifunc (c-x c-o), commentstring, matchit % jumps, per-ft gf
" must come before the FileType autocmds below, so ours run after the ftplugins
filetype plugin on
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
noremap <F2> :NERDTreeFind<CR>
noremap <F3> :NERDTreeClose<CR>

noremap <C-T> :Files<CR>
noremap <C-C> :Commits<CR>
noremap <C-G> :Tags<CR>
nnoremap <F9> :Rg 

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

" setlocal, not set - a global set here leaked tabstops into every later buffer
" (open a Makefile, then a .js, and the .js got noexpandtab ts=4)
au FileType make setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
au FileType python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4

" set digraph

nnoremap Q <nop>

" the old '\|' put a literal | in the rhs, so these were bouncing the cursor to
" column 1 between each step. harmless, but it was never doing anything
noremap <F5> :w<CR>:!npx prettier --write %<CR>:e<CR>
noremap <F6> :w<CR>:!uvx ruff format %<CR>:e<CR>
noremap <F7> :w<CR>:!uvx ruff check --fix %<CR>:e<CR>

"set suffixesadd+=.js,.jsx,.ts,.tsx,.mjs,.cjs
"set path+=$PWD/node_modules

" never let a filetype plugin auto-wrap.
" 'set tw=0' alone does not do it: ftplugins set textwidth *buffer-locally* and later,
" so they win - gitcommit.vim does 'setlocal formatoptions+=tl textwidth=72', which is
" what was forcing newlines into git commit messages.
" this runs after the ftplugin, so it wins. narrow the * to gitcommit if you ever want
" the 72-column wrap back for mail and friends.
set tw=0
au FileType * setlocal textwidth=0

" C-x C-f autocomplete relative paths without js suffix
inoremap <expr> <c-x><c-f> fzf#vim#complete("fdfind --print0 <Bar> xargs --null realpath --relative-to " . expand("%:h") . " <Bar> sed -e 's/\\.[jt]sx\\?$//' -e 's/^[^.]/.\\/&/'")

" make C-w C-w work
set backspace=indent,eol,start
