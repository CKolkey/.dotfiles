execute pathogen#infect()

syntax on
" Ruby Syntax
let ruby_operators = 1
let ruby_pseudo_operators = 1

colorscheme onedark
" Transparent Background
hi Normal guibg=NONE ctermbg=NONE

"Remove Arrow Keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Enter inserts newline without leaving Normal mode
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

" Timeout Insert mode after idle for three seconds
set ut=7000
au CursorHoldI * stopinsert 

" Autocompletion
imap <Tab> <C-P>
set completeopt=menu,preview,menuone

" Italics
highlight htmlArg   cterm=italic
highlight Comment   cterm=italic
highlight Type      cterm=italic
highlight sassClass cterm=italic
highlight slimClass cterm=italic
highlight slimId    cterm=italic
highlight slimAttr  cterm=italic
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

" enable FZF
set rtp+=/usr/local/opt/fzf
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit',
      \ 'ctrl-t': 'tab split' }
nnoremap <c-p> :FZF<cr>
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

" Output the current syntax group
nnoremap <f10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans <' . synIDattr(synID(line("."),col("."),0),"name") . "> lo <" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<cr>

" Theme
let g:onedark_terminal_italics = 1
let g:onedark_hide_endofbuffer = 1

" Airline Settings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline_theme = 'deus'
let g:airline_powerline_fonts = 1

set cursorline
set number relativenumber
set backspace=indent,eol,start
set tabstop=2 shiftwidth=2 expandtab
set incsearch " Show matches While searching
set hlsearch " Highlight Search
set re=1 "Sets regex engine
autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2

" Autoreload changed files
set autoread
au CursorHold,CursorHoldI * checktime
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

filetype plugin indent on

if has("multi_byte")
  set encoding=utf-8
  setglobal fileencoding=utf-8
else
  echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif


"Set NerdTree toggle to ctrl-n
let NERDTreeShowHidden=1
map <C-\> :NERDTreeToggle<CR>

" Mapping for alt-<x> | Makes <Esc> to change modes laggy
" for i in range(97,122)
"   let c = nr2char(i)
"   exec 'map \e'.c." <M-".c.">"
"   exec 'map! \e'.c." <M-".c.">"
" endfor

" Move Lines up and Down with alt-j/k
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
inoremap ∆ <Esc>:m .+1<CR>==gi
inoremap ˚ <Esc>:m .-2<CR>==gi
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv

" Set specific linters with ALE
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'ruby': ['rubocop'],
\}

" Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 1
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 0

" Matchup Settings
let g:matchup_surround_enabled = 1
hi MatchParen guifg=#1d2127 guibg=#60aeed
hi MatchWord  guifg=#1d2127 guibg=#c678dd
let g:matchup_matchparen_deferred = 1
let g:matchup_matchparen_offscreen = {} 
