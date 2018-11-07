" Vim-plug install command
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" Set leader key to spacebar
map <SPACE> <leader>

set number
set relativenumber

set hidden
set showcmd

" let g:netrw_banner=0
" let g:netrw_liststyle=3
" let g:netrw_browse_split=4
" let g:netrw_altv=1
" let g:netrw_winsize=25
" augroup OpenExplorer
"     autocmd!
"     autocmd VimEnter * :Vexplore
" augroup END

set ignorecase
set smartcase
set incsearch
set nohlsearch
set autochdir
set cursorline
set showmode
set showmatch

set conceallevel=2
set concealcursor=vin

set wildmenu
set wildmode=list:longest

" Edit .vimrc
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

" Wrapped line movement
nnoremap j gj
nnoremap k gk

" Autocomplete line
inoremap <C-l> <C-x><C-l>

" To open a new empty buffer
nmap <leader>t :enew<CR>

" Move to next buffer
nmap <leader>l :bnext<CR>

" Move to previous buffer
nmap <leader>h :bprevious<CR>

"Close current buffer and move to previous one
nmap <leader>bq :bp <BAR> bd #<CR>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>

" Window navigation
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-h> <C-w><C-h>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-.> 5<C-w><S-.>

" Jump to tag fix
nmap <C-]> g<C-]>

" Find tags file
set tags=./tags;/

" Splitting windows
set splitbelow
set splitright
nnoremap <leader>w <C-w>v<C-w>l

filetype plugin indent on

set ts=4
set tabstop=4
set shiftwidth=4
set expandtab
set encoding=utf-8
autocmd FileType c,cpp,java,tex,txt,sml,rb,html,xml,dot,py autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
" Don't expand tab in Makefiles
autocmd FileType make set noexpandtab
"
" " Set text wrap with to 70 for compatibility with David's editor.
" " This affects BOTH autowrap and the gq command
autocmd FileType tex set textwidth=70
autocmd FileType plaintex set textwidth=70
autocmd FileType latex set textwidth=70

" autocmd BufNewFile,BufRead *.v set syntax=verilog
" autocmd FileType verilog  setlocal shiftwidth=2 tabstop=2

set term=screen-256color

" Change temp files to store in ~/.vim
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

" Clipboard for tmux
set clipboard^=unnamed

call plug#begin('~/.vim/plugged')

Plug 'vim-scripts/a.vim'
Plug 'vim-scripts/ShowTrailingWhitespace'
Plug 'derekwyatt/vim-fswitch'
Plug 'qpkorr/vim-bufkill'
Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'
Plug 'AlessandroYorba/Alduin'
Plug 'vim-airline/vim-airline'
Plug 'bling/vim-bufferline'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'lrvick/conque-shell'
" Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-commentary'
Plug 'pgdouyon/vim-yin-yang'
Plug 'vim-scripts/tetris.vim'
Plug 'raimondi/delimitmate'
" Plug 'Rip-Rip/clang_complete'
Plug 'davidhalter/jedi'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'jez/vim-better-sml'
Plug 'lervag/vimtex'
Plug 'petrushka/vim-opencl'
Plug 'rsmenon/vim-mathematica'
Plug 'tpope/vim-vinegar'
Plug 'craigemery/vim-autotag'
Plug 'vim-syntastic/syntastic'
Plug 'severin-lemaignan/vim-minimap'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

call plug#end()

set background=dark
let g:gruvbox_contrast_dark = 'medium'
colorscheme gruvbox

" colorscheme molokai
" let g:molokai_original = 1
" let g:rehash256 = 1

" colorscheme alduin
" let g:alduin_Shout_Dragon_Aspect = 1

" Macros
let @z='i/******************************************************************************/'

" Enable list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show filename
let g:airline#extensions#tabline#fnamemod = ':t'

" Use version control directory as cwd
" let g:ctrlp_working_path_mode = 'r'

" Fswitch stuff
nmap <silent> <Leader>of :FSHere<cr>
" Clang completion
" let g:clang_library_path='/usr/lib/llvm-3.8/lib/libclang-3.8.so.1'
" let g:clang_snippets=1
" let g:clang_conceal_snippets=1
" let g:clang_snippets_engine='clang_complete'
" set completeopt=menu,menuone
" set pumheight=20

" Bufferline stuff
" let g:bufferline_active_buffer_left = '['
" let g:bufferline_active_buffer_right = ']'
" let g:bufferline_show_bufnr = 1
" let g:bufferline_rotate = 0
" let g:bufferline_inactive_highlight = 'StatusLineNC'
" let g:bufferline_active_highlight = 'StatusLine'
" let g:bufferline_pathshorten = 1

" LaTeX stuff
let g:tex_flavor='latex'
let g:vimtex_compiler_latexmk = {'callback' : 0}

"Syntastic stuff
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_loc_list_height = 2
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" let g:syntastic_quiet_messages = { "type": "style" }
" let g:syntastic_enable_balloons = 1

" let g:syntastic_c_checkers = ['gcc']

" set statusline+=%{gutentags#statusline('[Generating...]')}
