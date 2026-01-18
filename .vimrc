" --------------------------------------------------------------------------------
" Plugins Configuration
" --------------------------------------------------------------------------------
call plug#begin()
Plug 'sheerun/vim-polyglot'
Plug 'Yggdroot/indentLine'
Plug 'scrooloose/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'leafgarland/typescript-vim'
Plug 'fatih/vim-go'
Plug 'tpope/vim-commentary'
Plug 'christoomey/vim-tmux-navigator'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/goyo.vim'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'
Plug 'bkad/CamelCaseMotion'
Plug 'nvie/vim-flake8'
Plug 'tell-k/vim-autopep8'
Plug 'ntpeters/vim-better-whitespace'
Plug 'joshdick/onedark.vim'
Plug 'tpope/vim-surround'
Plug 'APZelos/blamer.nvim'
Plug 'tpope/vim-repeat'
Plug 'justinmk/vim-sneak'
Plug 'ruanyl/vim-gh-line'
Plug 'thosakwe/vim-flutter'
Plug 'hankchiutw/flutter-reload.vim'
Plug 'tomlion/vim-solidity'
Plug 'github/copilot.vim'
call plug#end()

" Vim-plug auto install
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let g:polyglot_disabled = ['markdown']

" NERDTree settings
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" --------------------------------------------------------------------------------
" General settings
" --------------------------------------------------------------------------------
set termguicolors
set number
set relativenumber
set wildmenu
set lazyredraw
set showmatch
set incsearch
set hlsearch
set ignorecase
set smartcase
set showcmd
set cursorline
set mouse=a
set colorcolumn=80
set backspace=indent,eol,start
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes
set clipboard=unnamedplus
set hidden
set nobackup
set nowritebackup
syntax enable

" --------------------------------------------------------------------------------
" Custom Variables
" --------------------------------------------------------------------------------
let g:indentLine_color_term = 239
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" --------------------------------------------------------------------------------
" Custom Mappings
" --------------------------------------------------------------------------------
map H g0
map L g$
map <Esc><Esc> :w<CR>
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
nnoremap <leader>] :s#_\(\l\)#\u\1#g<CR>
nnoremap <silent> <leader>v :NERDTreeFind<CR>
nnoremap <C-b> :call NERDTreeToggleAndRefresh()<CR>
nnoremap <silent> <leader>o :Files<CR>
nnoremap <silent> <leader>O :Files!<CR>

" --------------------------------------------------------------------------------
" Autocommands
" --------------------------------------------------------------------------------
augroup ReactFiletypes
  autocmd!
  autocmd BufRead,BufNewFile *.jsx set filetype=javascriptreact
  autocmd BufRead,BufNewFile *.tsx set filetype=typescriptreact
augroup END

" --------------------------------------------------------------------------------
" Language-specific settings
" --------------------------------------------------------------------------------
autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType jsx setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType css setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType scss setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType typescript setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType typescriptreact setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType proto setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType json setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType xml setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType solidity setlocal shiftwidth=4 softtabstop=4 expandtab
autocmd FileType go setlocal tabstop=8 shiftwidth=8 expandtab

" --------------------------------------------------------------------------------
" custom functions
" --------------------------------------------------------------------------------
function NERDTreeToggleAndRefresh()
  :NERDTreeToggle
  if g:NERDTree.IsOpen()
    :NERDTreeRefreshRoot
  endif
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! HasEslintConfig() abort
  return findfile('.eslintrc', '.;') != '' ||
        \ findfile('.eslintrc.js', '.;') != '' ||
        \ findfile('.eslintrc.json', '.;') != '' ||
        \ findfile('package.json', '.;') != ''
endfunction

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" --------------------------------------------------------------------------------
" Coc related
" --------------------------------------------------------------------------------
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
inoremap <silent><expr> <c-space> coc#refresh()
" inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-y>"

nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
nmap <leader>rn <Plug>(coc-rename)


" --------------------------------------------------------------------------------
" Misc
" --------------------------------------------------------------------------------
filetype indent plugin on
au BufRead,BufNewFile *.md setlocal textwidth=80
autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx if HasEslintConfig() | silent! CocCommand eslint.executeAutofix | endif

augroup mygroup
  autocmd!
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
