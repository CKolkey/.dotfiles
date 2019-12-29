" Install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync
endif

call plug#begin()
Plug 'w0rp/ale'
Plug 'sheerun/vim-polyglot'
Plug 'andymass/vim-matchup'
Plug 'raimondi/delimitmate'
Plug 'junegunn/vim-easy-align'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'terryma/vim-multiple-cursors'
Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}

Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'flw-cn/vim-nerdtree-l-open-h-close'
Plug 'vwxyutarooo/nerdtree-devicons-syntax'

Plug 'junegunn/fzf.vim'
Plug '/usr/local/opt/fzf'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'tpope/vim-rails'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
call plug#end()

" Theme
colorscheme onedark

" Settings
filetype plugin indent on
syntax on
set cursorline
set number relativenumber
set backspace=indent,eol,start
set tabstop=2 shiftwidth=2 expandtab
set shiftround     " Use multiple of shiftwidth when indenting with > and <
set autoindent
set incsearch      " Show matches While searching
set ignorecase     " ignore case on search
set smartcase      " Ignores case if search is all lower, case sensitive otherwise
set hlsearch       " Highlight Search
set re=1           " Sets regex engine
set scrolloff=4    " Keep 4 lines below cursonr
set visualbell     " don't beep
set noerrorbells   " don't beep
set belloff=all    " don't flash
set pastetoggle=<F2>
set noswapfile

set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
autocmd filetype html,xml set listchars-=tab:>.

" for coc.vim
set hidden
set nobackup
set nowritebackup
set cmdheight=2    " Better cmd height; needed for coc
set updatetime=300 " You will have bad experience for diagnostic messages when it's default 4000.
set shortmess+=c   " don't give ins-completion-menu messages.
set signcolumn=yes " always show signcolumns

if has("multi_byte")
  set encoding=utf-8
  setglobal fileencoding=utf-8
else
  echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif

if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif

autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2

" Autoreload changed files
set autoread
au CursorHold,CursorHoldI * checktime
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" Relative line numbers in Normal mode, absolute numbers in Insert mode
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END


" Key Mappings
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
let mapleader = "\<Space>"

nmap <leader>vi :tabe $MYVIMRC<cr>
nmap <leader>so :source $MYVIMRC<cr>

" Escape from insert mode with jj
imap jj <esc>

" More sane vertical navigation
nmap k gk
nmap j gj

nnoremap ; :

" Use Q for formatting the current paragraph (or selection)
vmap Q gq
nmap Q gqap

"Remove Arrow Keys in Normal Mode
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

"Remove Arrow Keys in Insert Mode
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

" Enter inserts newline without leaving Normal mode
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Remaps 0 to take you to the beginning of the lines content (^ behavior) instead of line start
nmap 0 ^

" Moves selected Lines up and Down with alt-j/k
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
inoremap ∆ <Esc>:m .+1<CR>==gi
inoremap ˚ <Esc>:m .-2<CR>==gi
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv

" Clears Search
nmap <silent> ,/ :nohlsearch<CR>


" EASYALIGN
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Output the current syntax group
nnoremap <f10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans <' . synIDattr(synID(line("."),col("."),0),"name") . "> lo <" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<cr>

" Plugin Mappings
map - :NERDTreeToggle<CR>
nnoremap ]r :ALENextWrap<CR>
nnoremap [r :ALEPreviousWrap<CR>
nnoremap <c-p> :FZF<cr>

" COC - enter selects completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" COC - Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" COC - Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
" COC - Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
" COC - Remap for format selected region
nmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" COC - Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
" COC - Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" COC - Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)
" COC - Press Tab or Shift-Tab and navigate around completion selections
inoremap <silent><expr> <Tab>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<Tab>" :
  \ coc#refresh()
inoremap <silent><expr> <S-Tab>
  \ pumvisible() ? "\<C-p>" :
  \ <SID>check_back_space() ? "\<S-Tab>" :
  \ coc#refresh()

" FZF
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit',
      \ 'ctrl-t': 'tab split' }

augroup fzf
  autocmd!
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" ONEDARK Theme
let g:onedark_terminal_italics = 1
let g:onedark_hide_endofbuffer = 1

" AIRLINE
let g:airline_theme = 'deus'
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_left_sep = '█'
let g:airline_right_sep = '█'
let g:airline_left_alt_sep = '|'
let g:airline#extensions#tabline#left_sep = '█'
let g:airline#extensions#tabline#right_sep = '█'
let g:airline#extensions#tabline#left_alt_sep = '|'

" NERDTree
let NERDTreeShowHidden=1
let NERDTreeMinimalUI = 1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" NERDtree Git Plugin
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeShowIgnoredStatus = 0
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "!",
    \ "Staged"    : "+",
    \ "Untracked" : "?",
    \ "Renamed"   : "»",
    \ "Unmerged"  : "=",
    \ "Deleted"   : "x",
    \ "Dirty"     : "#",
    \ "Clean"     : "✔︎",
    \ "Ignored"   : "~",
    \ "Unknown"   : "*"
    \ }

" ALE
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'ruby': ['rubocop'],
\}

let g:ale_linters_explicit = 1
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 0
let g:ale_sign_error = '>>'
let g:ale_sign_warning = ''

" MATCHUP
let g:matchup_surround_enabled = 1
hi MatchParen guifg=#1d2127 guibg=#60aeed
hi MatchWord  guifg=#1d2127 guibg=#c678dd
let g:matchup_matchparen_deferred = 1
let g:matchup_matchparen_offscreen = {}

" COC START
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Close window when done
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
" COC Plugin END

" Ruby Syntax
let ruby_operators = 1
let ruby_pseudo_operators = 1

" Custom Italics
highlight htmlArg   cterm=italic
highlight Comment   cterm=italic
highlight Type      cterm=italic
highlight sassClass cterm=italic
highlight slimClass cterm=italic ctermfg=YELLOW
highlight slimId    cterm=italic
highlight slimAttr  cterm=italic
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

" Set Transparent Terminal Background
hi Normal guibg=NONE ctermbg=NONE
