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
set shiftwidth=4
set ts=4

" :X encrypts current file
set cm=blowfish

" automaticky skoci na posledni pozici pred uzavrenim souboru
if v:progname !~ "vimdiff"
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"z." | endif
endif

function Head_js2css ()
	" outer tag name script -> link
	:s/<script /<link /i
	:s/<\/script>/<\/link>/i

	" drop type; add rel, type
	:s/type="text\/javascript"//i
	:s/<link /<link rel="stylesheet" /
	:s/<link /<link type="text\/css" /

	" src -> href
	:s/ src="/ href="/i

	" .js -> .css
	:s/\.js"/.css"/i

	" sanitize
	:s/ \+/ /g
endfunction
function Head_css2js ()
	" outer tag name link -> script
	:s/<link /<script /i
	:s/<\/link>/<\/script>/i

	" add type; drop rel, type
	:s/<script /<script type="text\/javascript" /
	:s/rel="stylesheet"//i
	:s/type="text\/css"//i

	" href -> src
	:s/ href="/ src="/i

	" .css -> .js
	:s/\.css"/.js"/i

	" sanitize
	:s/ \+/ /g
endfunction
command Js2css :call Head_js2css ()
command Css2js :call Head_css2js ()

" Dancer::Template ; Mustache
au BufNewFile,BufReadPost *.tt set ft=html
au BufNewFile,BufReadPost *.mustache set ft=html
au BufNewFile,BufReadPost *.handlebars set ft=html

" sablona pro C
au BufNewFile *.c call append (0, "#include <stdio.h>")
au BufNewFile *.c call append (1, "#include <stdlib.h>")
au BufNewFile *.c call append (2, "")
au BufNewFile *.c call append (3, "int")
au BufNewFile *.c call append (4, "main(int argc, char **argv)")
au BufNewFile *.c call append (5, "{")
au BufNewFile *.c call append (6, "	return 0;")
au BufNewFile *.c call append (7, "}")
au BufNewFile *.c :$d

" sablona pro C .h soubory
au BufNewFile *.h call append (0, "#ifndef __".toupper(expand("%:t:r")."_".expand("%:e"))."__")
au BufNewFile *.h call append (1, "#define __".toupper(expand("%:t:r")."_".expand("%:e"))."__")
au BufNewFile *.h call append (2, "")
au BufNewFile *.h call append (3, "extern int ".expand("%:t:r")."_foo(int bar);")
au BufNewFile *.h call append (4, "")
au BufNewFile *.h call append (5, "#endif	// __".toupper(expand("%:t:r")."_".expand("%:e"))."__")
au BufNewFile *.h :$d

" sablona pro perl
au BufNewFile *.pl call append (0, "#!/usr/bin/env perl")
au BufNewFile *.pl call append (1, "use v5.14;")
au BufNewFile *.pl call append (2, "")
au BufNewFile *.pl :$d

" sablona pro C++
au BufNewFile *.c{c,pp} call append (0, "#include <iostream>")
au BufNewFile *.c{c,pp} call append (1, "")
au BufNewFile *.c{c,pp} call append (2, "using namespace std;")
au BufNewFile *.c{c,pp} call append (3, "")
au BufNewFile *.c{c,pp} call append (4, "int main(int argc, char **argv) {")
au BufNewFile *.c{c,pp} call append (5, "	")
au BufNewFile *.c{c,pp} call append (6, "	return 0;")
au BufNewFile *.c{c,pp} call append (7, "}")
au BufNewFile *.c{c,pp} :$d

" sablona pro C++ header soubory
au BufNewFile *.h{h,pp} call append (0, "#ifndef __".toupper(expand("%:t:r")."_".expand("%:e"))."__")
au BufNewFile *.h{h,pp} call append (1, "#define __".toupper(expand("%:t:r")."_".expand("%:e"))."__")
au BufNewFile *.h{h,pp} call append (2, "")
au BufNewFile *.h{h,pp} call append (3, "class ".expand("%:t:r")." {")
au BufNewFile *.h{h,pp} call append (4, "};")
au BufNewFile *.h{h,pp} call append (5, "")
au BufNewFile *.h{h,pp} call append (6, "#endif	// __".toupper(expand("%:t:r")."_".expand("%:e"))."__")
au BufNewFile *.h{h,pp} :$d
au BufNewFile *.h{h,pp} :4

" sablona pro python
au BufNewFile *.py call append (0, "#!/usr/bin/env python")
au BufNewFile *.py call append (1, "# coding=utf-8")
au BufNewFile *.py call append (2, "")
au BufNewFile *.py call append (3, "import os")
au BufNewFile *.py :$d

" sablona pro ruby
au BufNewFile *.rb call append (0, "#!/usr/bin/env ruby")
au BufNewFile *.rb call append (1, "# -*- encoding: utf-8 -*-")
au BufNewFile *.rb call append (2, "")
au BufNewFile *.rb :$d

" sane filename completion
set wildmode=longest,list:longest,list:full

" x clipboard is the default; needs vim-gtk, not basic
set clipboard=unnamed,unnamedplus
set clipboard+=autoselectplus

" TODO
:command Sanitize %s/\([^ \t]\){[ \t]*\([ \t]?#.*|\/\/.*\)$/\1 {\2/

" latte syntax
" autocmd BufNewFile,BufRead *.latte set filetype=latte.php.html

" set fileencodings=utf-8
" au BufReadPost * cd %:p:h

" makes :Ack (ack.vim) use ag instead of ack
let g:ackprg = 'ag --nogroup --nocolor --column'

execute pathogen#infect()
"map <C-T> :CommandT<CR>
map <C-T> :Files<CR>
map <C-C> :Commits<CR>
map <C-G> :Tags<CR>
"map <C-A> :Ag 
"nnoremap <F8> :GundoToggle<CR>
map <C-A> :Ack 
nnoremap <F8> :UndotreeToggle<CR>

map <F2> :NERDTreeToggle<CR>

" testing { from..
" http://www.reddit.com/r/vim/comments/19u4u0/what_normal_mode_mappings_do_you_have_in_your/

let mapleader=','

" delete into the black hole register
nnoremap <leader>d "_d

" quick buffer navigation
nnoremap gb :buffers<CR>:sb<Space>

" append a semicolon
nnoremap <leader>; A;<Esc>

" write a file that I didn't open with the right privileges
nnoremap <leader>ss :w !sudo tee %<CR>

" for css - "foo {" => "foo,\nfoo {"
nnoremap <leader>dup Ypk$dhr,j^

" for angular - [C]trl, [S]ervice, [D]irective
nnoremap <leader>C oapp.controller('FooCtrl', function($scope) {<CR><Tab>$scope.foo = null;<CR><BS>});<CR><Esc>
nnoremap <leader>S oapp.service('Foo', function($http) {<CR><Tab>var Foo = this;<CR>var base_url = '/rest/foo';<CR><BS><CR><Tab>Foo.get = function(id, opt) {<CR><Tab>return $http.get(base_url + '/' + id + (opt ? serialize_get(opt) : ''))<CR>.then( _response_data('foo', {}) );<CR><BS>};<CR><CR>Foo.list = function(opt) {<CR><Tab>return $http.get(base_url + '/' + (opt ? serialize_get(opt) : ''))<CR>.then( _response_data('foo', []) );<CR><BS>};<CR><BS>});<CR><Esc>
nnoremap <leader>D oapp.directive('foo', function() {<CR><Tab>return {<CR><Tab>scope: true,<CR>controller: 'FooCtrl',<CR>templateUrl: '/view/foo.html',<CR><BS>};<CR><BS>});<CR><Esc>

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

au BufNewFile,BufReadPost *.cs set expandtab
au BufNewFile,BufReadPost *.rb,*.erb,*.haml,*.js,*.ts,*.html set expandtab tabstop=2 shiftwidth=2 softtabstop=2

" set digraph

" {{{ syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_always_populate_loc_list = 1
""let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
" }}}

" :PlugInstall to install plugins
"call plug#begin('~/.vim/plugged')
"	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"	Plug 'junegunn/fzf.vim'
"	Plug 'Xuyuanp/nerdtree-git-plugin'
"call plug#end()

nnoremap Q <nop>
let g:typescript_indent_disable = 1
set rtp+=~/.fzf

" TODO Xuyuanp/nerdtree-git-plugin'
