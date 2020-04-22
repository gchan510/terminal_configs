" Vim-plug install command
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Update plugins by typing :PlugInstall in vim command line

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
set nowrapscan

" set conceallevel=2
set concealcursor=vin

" disable latex conceal
let g:tex_conceal = ""

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
" nnoremap <C-j> <C-w><C-j>
" nnoremap <C-k> <C-w><C-k>
" nnoremap <C-h> <C-w><C-h>
" nnoremap <C-l> <C-w><C-l>
" nnoremap <C-.> 5<C-w><S-.>

" Jump to tag fix
nmap <C-]> g<C-]>

" Find tags file
set tags=./tags;/

" Splitting windows
set splitbelow
set splitright
nnoremap <leader>w <C-w>v<C-w>l

filetype plugin indent on

set backspace=indent,eol,start

set scrolloff=5
set tabstop=2
set shiftwidth=2
set expandtab
set encoding=utf-8
autocmd FileType c,cpp,java,tex,txt,sml,rb,html,xml,dot,py autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
" Don't expand tab in Makefiles
autocmd FileType make set noexpandtab

" Set text wrap with to 70 for compatibility with David's editor.
" This affects BOTH autowrap and the gq command
autocmd FileType tex set textwidth=75
autocmd FileType plaintex set textwidth=75
autocmd FileType latex set textwidth=75

" llvm IR syntax highlighting
augroup filetype
  au! BufRead,BufNewFile *.ll     set filetype=llvm
augroup END

" autocmd BufNewFile,BufRead *.v set syntax=verilog
autocmd FileType verilog  setlocal shiftwidth=2 tabstop=2

" Enable 256 color in terminal
set term=screen-256color

" Reopen files where I left off
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" Change temp files to store in ~/.vim
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

" Clang formatting
map <C-Y> :py3f /u/gc14/llvm-workspace/llvm/tools/clang/tools/clang-format/clang-format.py<cr>

" gqip format LaTeX!!!

" Liberty source path
set path+=/u/gc14/cpf/liberty/lib
set path+=/u/gc14/cpf/liberty/include

set undofile

" json formatter
:command Json %!python -m json.tool

" TODO Reading from specific lines of file
" :r! sed -n 147,227p /path/to/foo/foo.c

" Clipboard for tmux
" set clipboard^=unnamed

call plug#begin('~/.vim/plugged')

" **** Stuff that I'm too lazy to sort ****
Plug 'vim-scripts/ShowTrailingWhitespace'
Plug 'lrvick/conque-shell'
" Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-commentary'
Plug 'vim-scripts/tetris.vim'
Plug 'raimondi/delimitmate'
" Plug 'davidhalter/jedi-vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'jez/vim-better-sml'
Plug 'lervag/vimtex'
Plug 'petrushka/vim-opencl'
Plug 'rsmenon/vim-mathematica'
Plug 'craigemery/vim-autotag'
" Plug 'vim-syntastic/syntastic'
Plug 'severin-lemaignan/vim-minimap'
Plug 'tpope/vim-obsession'
Plug 'christoomey/vim-tmux-navigator'
Plug 'roxma/vim-tmux-clipboard'
" Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'salsifis/vim-transpose'
Plug 'mbbill/undotree'

" **** YouCompleteMe family plugins ****
Plug 'Valloric/YouCompleteMe'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}

" **** Window/buffer/file search plugins ****
Plug 'vim-scripts/a.vim'
Plug 'qpkorr/vim-bufkill'
Plug 'airblade/vim-gitgutter'
" Plug 'mtth/scratch.vim'
Plug 'derekwyatt/vim-fswitch'
Plug 'vim-airline/vim-airline'
Plug 'bling/vim-bufferline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'tpope/vim-vinegar'

" **** Colorschemes ****
Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'
Plug 'junegunn/seoul256.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'AlessandroYorba/Alduin'
Plug 'pgdouyon/vim-yin-yang'
Plug 'vim-airline/vim-airline-themes'
Plug 'tomasiser/vim-code-dark'

" **** Syntax/semantics-aware highlighting ****
" Plug 'jeaye/color_coded'

" **** Previewing ****
Plug 'JamshedVesuna/vim-markdown-preview'

" My plugin!
Plug '~/vim-persist'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

call plug#end()

" set background=dark
" let g:gruvbox_contrast_dark = 'medium'
" let g:seoul256_background = 235
" colorscheme gruvbox
colorscheme codedark

" Macros
let @z='i/******************************************************************************/'
let @x=':DelimitMateSwitchi\{\textbf{XXX} \}h:DelimitMateSwitch'

" vim-airline stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show filename
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" ctrlp stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_working_path_mode = 'c'
let g:ctrlp_by_filename = 1
set wildignore+=*/tmp/*,*.so,*.swp,*.gz,*.zip,*.o

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = $HOME.'/.vim/ctrlp_cache'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Preview markdown shortcut
let vim_markdown_preview_hotkey='<C-m>'

" ctags function names
" let g:ctags_statusline=1
" let g:ctags_title=1

" Fswitch stuff
nmap <silent> <Leader>of :FSHere<cr>

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

" ---- Syntastic stuff ----
let g:syntastic_c_checkers = ['gcc']
let g:syntastic_c_include_dirs = ['include', '../include', '../../include/']

" Create this file in root directory of project
let g:syntastic_cpp_config_file = '.syntastic_cpp_config'

" vim-cpp-enhanced-highlight options
" let g:cpp_class_scope_highlight = 0
" let g:cpp_member_variable_highlight = 0
" let g:cpp_class_decl_highlight = 0
" let g:cpp_experimental_simple_template_highlight = 0
" let g:cpp_experimental_template_highlight = 0
" let g:cpp_concepts_highlight = 0
" let g:cpp_no_function_highlight = 1

" YouCompleteMe settings
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_insertion = 1

" set statusline+=%{gutentags#statusline('[Generating...]')}
