"Setup
syntax on
set ts=2 sts=2 sw=2 expandtab autoindent
set hlsearch
set nowrap
set visualbell t_vb=
set scrolloff=3
set nofoldenable
set wildmode=list:longest
set wildignore=*.o,*.obj,*.swp,*~,#*#,tmp/,node_modules/
set list
set listchars=tab:\ ¬,trail:.
set mouse=a
set hidden
set switchbuf=useopen
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set undodir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set lazyredraw
set undofile
set number
set numberwidth=1
set clipboard=unnamed
set laststatus=2
set termguicolors
set noswapfile
set autoread
set cursorline

let mapleader=","

" Copy/Paste from clipboard
map <leader>y "+y
map <leader>p "+p

" Close current buffer
map <leader>q :bd<cr>
"
" Close all buffers but the current one
map <leader>cb :%bd\|e#<CR>

" Switch to alternate file
map <Tab> :bnext<cr>
map <S-Tab> :bprevious<cr>

"C list navigation
map ]q :cnext<cr>
map [q :cprevious<cr>

" format json
map <leader>fj :%!python -m json.tool<CR>

" jk as escape
:imap jk <Esc>

" Show trailing whitespace:
highlight ExtraWhitespace ctermbg=red guibg=red 
match ExtraWhitespace /\s\+$/

" Clear the search buffer when hitting return
:nnoremap <CR> :nohlsearch<cr>
nnoremap <leader><leader> <c-^>

" No need for ex mode
nnoremap Q <nop>
vnoremap // y/<C-R>"<CR>

" Plugins start here
call plug#begin('~/.local/share/nvim/plugged')

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" For git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'

" The good stuff
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'w0rp/ale'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Copy as RTF
Plug 'dharanasoft/rtf-highlight'

" The colorscheme
Plug 'rakr/vim-one'

" JavaScript
Plug 'pangloss/vim-javascript'
Plug 'chemzqm/vim-jsx-improve'

" Elixir
Plug 'elixir-editors/vim-elixir' 
Plug 'mhinz/vim-mix-format'
Plug 'slashmili/alchemist.vim'

call plug#end()
filetype plugin indent on

" vim-one
let g:one_allow_italics = 1
colorscheme one
set background=dark

" Ale for JavaScript with standard
let g:ale_linters = { 'javascript': ['standard'] }

" NERDTree
map <leader>n :NERDTreeToggle<CR>
let g:NERDTreeShowHidden=1
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" Finding files and in project
map <leader>f :Files<CR>
map <leader>fp :Ag<CR>

" Airline
let g:airline#extensions#tabline#enabled = 1
