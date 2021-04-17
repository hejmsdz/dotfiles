" syntax highlighting
filetype on
syntax on

" display
set number
set relativenumber
set ruler
set cursorline " highlight current line
highlight CursorLineNR ctermfg=white
highlight CursorLine cterm=none

" colors
if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
else
  set term=xterm-256color
endif
if (has("termguicolors"))
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" indentation & wrapping
filetype indent on
set nowrap
set linebreak
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
set autoindent

" behavior
set hidden
set splitbelow
set updatetime=300
set showcmd

" search
set incsearch
set hlsearch
set ignorecase
set smartcase

" key bindings
set backspace=indent,eol,start
nnoremap <leader>[ :bprevious<CR>
nnoremap <leader>] :bnext<CR>
nnoremap <leader>x :bd<CR>
nnoremap <leader>X :bd!<CR>
nnoremap <leader><esc> :nohlsearch<CR>
nnoremap <leader>p :Files<CR>
nnoremap <leader>g :Rg
nnoremap <leader>\ :NERDTreeFind<CR>
nnoremap <leader>w :set wrap!<CR>
" Switch between different windows by their direction
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

" natural editing
noremap <C-a> <Home>
noremap <C-e> <End>
noremap <M-b> <S-Left>
noremap <M-f> <S-Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


noremap <F3> :Autoformat<CR>

" edit and apply settings with chezmoi integration
nnoremap <silent> <leader>, :execute "e " . system('chezmoi source-path $MYVIMRC')<CR>
command! Src :execute ':silent !chezmoi apply $MYVIMRC' | source $MYVIMRC
command! SudoW :execute ':silent w !sudo tee % > /dev/null' | :edit!

" python
let g:python3_host_prog='~/.vim/.venv/bin/python3'

" plugins
let g:ale_disable_lsp = 1

call plug#begin('~/.vim/plugged')
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'AndrewRadev/tagalong.vim'
Plug 'Chiel92/vim-autoformat'
Plug 'SirVer/ultisnips'
Plug 'airblade/vim-gitgutter'
Plug 'Luxed/ayu-vim'
Plug 'dense-analysis/ale'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'tpope/vim-surround'
Plug 'yarisgutierrez/ayu-lightline'
Plug 'yuezk/vim-js'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'leafOfTree/vim-svelte-plugin'
call plug#end()

" plugin configuration

function! GitBranch() abort"{{{
  if gitbranch#name() !=# ''
    return "\ue725 ".gitbranch#name()
  else
    return ""
  endif
endfunction"}}}

set showtabline=2
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'ayu',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'tabline': {
      \   'left': [ ['buffers'] ],
      \   'right': [ ],
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel'
      \ },
      \ 'component_function': {
      \   'gitbranch': 'GitBranch'
      \ },
      \ }
let g:lightline#bufferline#show_number = 2
let g:lightline#bufferline#enable_devicons = 1

nmap <Leader>1 <Plug>lightline#bufferline#go(1)
nmap <Leader>2 <Plug>lightline#bufferline#go(2)
nmap <Leader>3 <Plug>lightline#bufferline#go(3)
nmap <Leader>4 <Plug>lightline#bufferline#go(4)
nmap <Leader>5 <Plug>lightline#bufferline#go(5)
nmap <Leader>6 <Plug>lightline#bufferline#go(6)
nmap <Leader>7 <Plug>lightline#bufferline#go(7)
nmap <Leader>8 <Plug>lightline#bufferline#go(8)
nmap <Leader>9 <Plug>lightline#bufferline#go(9)
nmap <Leader>0 <Plug>lightline#bufferline#go(10)

autocmd StdinReadPre * let s:std_in=1

set background=dark
let ayucolor="mirage"
colorscheme ayu

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif
let NERDTreeMapActivateNode='l'
let NERDTreeMapJumpParent='h'
autocmd FileType nerdtree nmap <left> h
autocmd FileType nerdtree nmap <right> l
autocmd FileType nerdtree nmap <space> l
let NERDTreeAutoDeleteBuffer = 1
" let NERDTreeMinimalUI = 1
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact

" clipboard integration
set clipboard=unnamedplus
