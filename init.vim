autocmd!
set nocompatible
filetype off

set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin('~/.config/nvim/bundle')

Plugin 'VundleVim/Vundle.vim'  " required

" ===================
" my plugins here
" ===================

 Plugin 'morhetz/gruvbox'
 Plugin 'posva/vim-vue'
 Plugin 'kien/ctrlp.vim'
 Plugin 'airblade/vim-gitgutter'
 Plugin 'scrooloose/nerdtree'
 Plugin 'mhinz/vim-grepper'
 Plugin 'w0rp/ale'
 Plugin 'stephpy/vim-php-cs-fixer'
 Plugin 'shawncplus/phpcomplete.vim'
 Plugin 'itchyny/lightline.vim'
 Plugin 'majutsushi/tagbar'
 Plugin 'vim-php/tagbar-phpctags.vim'
 Plugin 'tpope/vim-commentary'
 Plugin 'tpope/vim-fugitive'
 Plugin 'ludovicchabant/vim-gutentags'
 Plugin 'janko-m/vim-test'
 Plugin 'tpope/vim-dispatch'
 Plugin 'tpope/vim-surround'
 Plugin 'SirVer/ultisnips'
" ===================
" end of plugins
" ===================

" Change leader to comma
let g:mapleader = ","

" After all plugins...
call vundle#end()
filetype plugin indent on

"colorscheme
syntax on

colorscheme gruvbox
:set bg=dark

" On pressing tab, insert 4 spaces
set expandtab
set number
:set shell=zsh\ -i
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Quicker window movement
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

"Remap save
nnoremap s :w<CR>
"TAB
:set tabstop=4
:set shiftwidth=4
:set expandtab

augroup vimrc
    autocmd!
augroup END
" map the escape from terminal mode
tnoremap <esc> <c-\><c-n>
" Remove cursorline highlight
autocmd vimrc InsertEnter,BufLeave * :set nocul
" Add cursorline highlight
autocmd vimrc InsertLeave,BufEnter * :set cul
" Visual mode highlighting
" Set new vertical splits to the right
set splitright
" Set new horizontal splits to the below
set splitbelow
" re map nerd tree
map <C-o> :NERDTreeToggle<CR>
" show hidden files
let NERDTreeShowHidden=1
" Relative line number
set number                     " Show current line number
set relativenumber             " Show relative line numbers
" ctrl P buffer 
:nnoremap <c-b> :CtrlPBuffer<cr>
" Quick resizing
nnoremap <silent> + :exe "resize " . (winheight(0) * 3/2)<cr>
nnoremap <silent> - :exe "resize " . (winheight(0) * 2/3)<cr>
nnoremap <right> :vertical resize +5<cr>
nnoremap <left> :vertical resize -5<cr>

" Perform a global seach in the entire project
nnoremap <leader>fp :Grepper<space>-query<space>
" Search for the word under the cursor
nnoremap <leader>f* :Grepper<space>-cword<space>-noprompt<cr>
" Ctrl P settings
set wildmode=list:full
set wildignore=*.git*
set wildignore+=*/vendor/**
set wildignore+=*/node_modules/**
set wildignore+=*/public/**

" LINTER

let g:ale_php_phpcs_standard = 'PSR2'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ALE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Only lint when saving or entering a file
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 1
" Lint error sign
let g:ale_sign_error = '⨉'
" Lint warning sign
let g:ale_sign_warning = '⚠'
" Status line texts
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '']
" Function to counht the errors and non errors to be displayed in status line
let g:ale_fixers = {
\   'php': ['php_cs_fixer'],
\}
let g:ale_fix_on_save = 1

" Vue
let g:ale_linter_aliases = {'vue': ['vue', 'javascript']}
" Copy to system clipboard
vnoremap <c-c> "+y
" Paste from system clipboard
inoremap <c-v> <Esc>"+
"""""""""""""""""""""""""""""""""""""""""""""""""""""

" ==== gutentags settings ====
" Exclude css, html, js files from generating tag files
let g:gutentags_ctags_exclude = ['*.css', '*.html', '*.js', '*.json', '*.xml',
                            \ '*.phar', '*.ini', '*.rst', '*.md',
                            \ '*vendor/*/test*',
                            \ '*vendor/*/fixture*', '*vendor/*/Fixture*',
                            \ '*var/cache*', '*var/log*']
" Where to store tag files
let g:gutentags_cache_dir = '~/.config/nvim/gutentags'
nnoremap <c-]> :vsp <cr>:exec("tag ".expand("<cword>"))<cr>
" ==== End gutentags settings ====

" ==== lightline settings ====
let g:lightline = {
    \ 'active': {
    \   'left': [['mode'], ['readonly', 'filename', 'modified'], ['tagbar', 'ale', 'gutentags']],
    \   'right': [['lineinfo'], ['filetype']]
    \ },
    \ 'inactive': {
    \   'left': [['absolutepath']],
    \   'right': [['lineinfo'], ['filetype']]
    \ },
    \ 'component': {
    \   'lineinfo': '%l\%L [%p%%], %c, %n',
    \  	'tagbar': '%{tagbar#currenttag("[%s]", "", "f")}',
    \   'gutentags': '%{gutentags#statusline("[Generating...]")}'
    \ },
    \ }
" ==== End lightline settings ====


" ==== Comments =====
nmap <leader>c gcc
xmap <leader>c gc
" Change for // for comments in php
autocmd FileType php setlocal commentstring=//\ %s
" ===================

" ====== HARD MODE ========
 inoremap <Up> <Esc>
 inoremap <Down> <Esc>
 inoremap <Left> <Esc>
 inoremap <Right> <Esc>

" =========TESTING==========
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

let test#strategy = {
  \ 'nearest': 'neovim',
  \ 'file':    'dispatch',
  \ 'suite':   'dispatch',
  \}
" =============Git=============================
nmap <c-s> :Gstatus<CR>
nmap <c-c> :Gcommit<CR>


" =============SNIPPITREALGOOD=============================
set runtimepath+=~/.config/nvim/my-snippets/
let g:UltiSnipsSnippetsDir = "~/.config/nvim/my-snippets/"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" inoremap <tab> <c-r>=UltiSnips#ExpandSnippet()<cr>

