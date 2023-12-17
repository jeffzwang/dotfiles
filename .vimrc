" vim-plug auto install
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let g:polyglot_disabled = ['markdown']

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

" nuke whitespace
Plug 'ntpeters/vim-better-whitespace'
Plug 'joshdick/onedark.vim'
" Plug 'morhetz/gruvbox'
Plug 'tpope/vim-surround'
Plug 'APZelos/blamer.nvim'
Plug 'tpope/vim-repeat'
Plug 'justinmk/vim-sneak'
Plug 'ruanyl/vim-gh-line'
" Plug 'dart-lang/dart-vim-plugin'
Plug 'thosakwe/vim-flutter'
Plug 'hankchiutw/flutter-reload.vim'
Plug 'tomlion/vim-solidity'
Plug 'github/copilot.vim'
call plug#end()

set termguicolors

let g:indentLine_color_term = 239
syntax enable
set number
set relativenumber
" set expandtab
set wildmenu
set lazyredraw
set showmatch
set incsearch
set hlsearch
" set noswapfile
set smarttab
" beginning / end of line
map H g0
map L g$
set ignorecase
set smartcase
set showcmd
set cursorline

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>
" enable scroll
set mouse=a
set colorcolumn=80
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" Mappings
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
nnoremap <silent> <leader>v :NERDTreeFind<CR>
nnoremap <C-b> :call NERDTreeToggleAndRefresh()<CR>
function NERDTreeToggleAndRefresh()
  :NERDTreeToggle
  if g:NERDTree.IsOpen()
    :NERDTreeRefreshRoot
  endif
endfunction
map <Esc><Esc> :w<CR>
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
nnoremap <leader>] :s#_\(\l\)#\u\1#g<CR>
" Language-specific settings
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

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
nnoremap <c-p> :Files<CR>

filetype indent plugin on


" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  " autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
" Coc-related
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes
set clipboard=unnamedplus

" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

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
set backspace=indent,eol,start
highlight ColorColumn ctermbg=8

let g:onedark_termcolors=256
set t_Co=256
set background=dark
colorscheme onedark
" g:gruvbox_contrast_light
" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
" Remap for format selected region
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  " autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

nnoremap <silent> <leader>o :Files<CR>
nnoremap <silent> <leader>O :Files!<CR>


" Prettier settings
" " single quotes over double quotes
" Prettier default: false
" let g:prettier#config#single_quote = 'true'
" print spaces between brackets
" Prettier default: true
" let g:prettier#config#bracket_spacing = 'true'
" let g:prettier#config#trailing_comma = 'all'
" max line length that prettier will wrap on
" Prettier default: 80
" let g:prettier#config#print_width = 100
" let g:prettier#config#max_line_length = 100
" let g:prettier#autoformat = 1
" let g:prettier#autoformat_require_pragma = 0
" let g:prettier#autoformat_config_present = 1
" let g:prettier#quickfix_auto_focus = 0
" autocmd InsertLeave,BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.mdx,*.vue,*.yaml,*.html PrettierAsync
" let g:prettier#config#arrow_parens = 'avoid'
let g:camelcasemotion_key = ','
function! HasEslintConfig() abort
    return findfile('.eslintrc', '.;') != '' ||
          \ findfile('.eslintrc.js', '.;') != '' ||
          \ findfile('.eslintrc.json', '.;') != '' ||
          \ findfile('package.json', '.;') != ''
endfunction

autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx if HasEslintConfig() | silent! CocCommand eslint.executeAutofix | endif


" NERDTree settings
" let NERDTreeQuitOnOpen = 1
let g:highlightedyank_highlight_duration = 250
let g:blamer_enabled = 1
let g:blamer_template = '<author> <committer-time> <summary>'
let g:blamer_delay = 600
let g:blamer_show_in_visual_modes = 0

set undodir=~/.vim/tmp/backup/ " or maybe ~/.config/nvim/backups if you use ~/.config
set undofile
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>
au BufRead,BufNewFile *.md setlocal textwidth=80
"
" Disable GOPLS for golang
let g:go_def_mapping_enabled = 0
let g:go_code_completion_enabled = 0
let g:go_doc_keywordprg_enabled = 0
let g:go_info_mode = 'gopls'

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T
let g:sneak#s_next = 1
let g:dart_format_on_save = 0
let g:current_line_whitespace_disabled_soft=1
let g:hot_reload_on_save=1
let g:ag_working_path_mode="r"
augroup ReactFiletypes
  autocmd!
  autocmd BufRead,BufNewFile *.jsx set filetype=javascriptreact
  autocmd BufRead,BufNewFile *.tsx set filetype=typescriptreact
augroup END
nnoremap <Esc>s :w<CR>
let g:vim_ai_chat = {
\  "options": {
\    "model": "gpt-4-0314",
\    "temperature": 0.8,
\    "max_tokens": 2048,
\  },
\}
