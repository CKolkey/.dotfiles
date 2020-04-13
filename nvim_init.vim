" Plugins {{{
  " Install vim-plug
  if empty(glob('~/.config/nvim/autoload/plug.vim'))
      silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif

  call plug#begin()
    Plug 'joshdick/onedark.vim'

    Plug 'mbbill/undotree'
    Plug 'romainl/vim-cool'
    Plug 'Krasjet/auto.pairs'
    Plug 'rhysd/clever-f.vim'
    Plug 'justinmk/vim-sneak'
    Plug 'sheerun/vim-polyglot'
    Plug 'andymass/vim-matchup'
    Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
    Plug 'airblade/vim-gitgutter'
    Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
    Plug 'chaoren/vim-wordmotion'
    Plug 'junegunn/vim-easy-align'
    Plug 'AndrewRadev/splitjoin.vim'
    Plug 'machakann/vim-highlightedyank'

    Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'kristijanhusak/defx-git'
    Plug 'kristijanhusak/defx-icons'

    Plug 'dense-analysis/ale'
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'Shougo/neco-syntax'

    Plug 'ludovicchabant/vim-gutentags'
    Plug 'skywind3000/gutentags_plus'
    Plug 'majutsushi/tagbar'

    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    Plug 'tpope/vim-rails'
    Plug 'tpope/vim-endwise'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-sensible'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
  call plug#end()
" }}}

" General Settings {{{
  filetype plugin indent on
  set cursorline            " Highlight cursor line
  set number                " Show line number
  set relativenumber        " Show Relative Line Numbers
  set noshowmode            " Status line makes this unneeded
  set numberwidth=5         " Make the line number column wider
  set backspace=indent,eol,start
  set tabstop=2
  set shiftwidth=2
  set expandtab
  set shiftround            " Use multiple of shiftwidth when indenting with > and <
  set autoindent
  set incsearch             " Show matches While searching
  set inccommand=split      " Show substitutions live
  set ignorecase            " ignore case on search
  set smartcase             " Ignores case if search is all lower, case sensitive otherwise
  set hlsearch              " Highlight Search
  set re=1                  " Sets regex engine
  set visualbell            " don't beep
  set noerrorbells          " don't beep
  set belloff=all           " don't flash
  set pastetoggle=<F2>      " turn on paste mode with F2
  set noswapfile
  set splitbelow            " split below, not above
  set splitright            " split right, not left
  set foldmethod=marker     " Fold code between {{{ and }}}
  set grepprg=rg\ --vimgrep " Use RipGrep for grepping
  set clipboard+=unnamedplus " Use system Clipboard
  set scrolloff=6          " Keep 10 lines above/below cursor
  set lazyredraw           " Don't redaw screen while executing macro
  set winwidth=80
  set winheight=10
  set list
  set listchars=tab:››,nbsp:·,trail:•,extends:»,precedes:«
  set shortmess=atIAc       "Hidden startup messages
  set hidden         " allows you to nav away from an unsaved buffer
  set updatetime=300 " You will have bad experience for diagnostic messages when it's default 4000.
  " set shortmess+=c   " don't give ins-completion-menu messages.
  set signcolumn=yes " always show signcolumns

  set backup
  set undofile              " Persistant Undo
  set undodir=$HOME/.cache/nvim/undo
  set backupdir=$HOME/.cache/nvim/backup

  set wildmenu
  set wildmode=full
  set wildoptions-=pum
  set wildignore+=*.so,*.pyc,*.png,*.jpg,*.gif,*.jpeg,*.ico,*.pdf
  set wildignore+=*.wav,*.mp4,*.mp3
  set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
  set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
  set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*
  set wildignore+=*.swp,*~,._*
  set wildignore+=_pycache_,.DS_Store,.vscode,.localized
  set wildignore+=.cache,node_modules,package-lock.json,yarn.lock,dist,.git
  set wildignore+=.vimruncmd

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

  " As Root {{{
    if exists('$SUDO_USER')
      set noswapfile
      set nobackup
      set nowritebackup
      set noundofile
    endif
  " }}}
" }}}

" AutoCommands {{{
" AUTORELOAD CHANGED FILES {{{
    set autoread
    augroup autoreadfiles
      autocmd!
      autocmd FocusGained,BufEnter * silent! checktime
      autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk - Buffer reloaded" | echohl None
    augroup END
" }}}
" AUTOSAVE CURRENT BUFFER {{{
  augroup autosavebuffer
    autocmd!
    autocmd InsertLeave * nested silent! update
  augroup end
" }}}
  " RELATIVE LINE NUMBERS IN NORMAL MODE, ABSOLUTE NUMBERS IN INSERT MODE {{{
    augroup numbertoggle
      autocmd!
      autocmd InsertLeave * set relativenumber
      autocmd InsertEnter * set norelativenumber
    augroup END
  " }}}
  " AUTOSOURCE VIMRC ON SAVE {{{
    augroup autosource
      autocmd!
      autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
    augroup END
  " }}}
  " TERMINAL BEHAVIOR {{{
    augroup TerminalBehavior
      autocmd!
      autocmd TermOpen * setlocal listchars= nonumber norelativenumber nowrap winfixwidth laststatus=0 noruler signcolumn=no noshowmode
      autocmd TermOpen * startinsert
      autocmd TermClose * set laststatus=2 showmode ruler
    augroup END
  " }}}
  " EASYQUIT {{{
    augroup easyquit
      autocmd!
      autocmd Filetype help nnoremap <buffer> q :q<CR>
    augroup END
  " }}}
" }}}

" Functions {{{
  " RESIZE MODE {{{
    let g:resize_active=0
    function! ToggleResizeMode()
      if g:resize_active == 0
        let g:resize_active = 1
        " ESC should exit
        nnoremap <esc> :call ToggleResizeMode()<CR>
        " Switch to resize keys
        nnoremap h <C-w><
        nnoremap j <C-w>-
        nnoremap k <C-w>+
        nnoremap l <C-w>>
        " Switch to window moving keys
        nnoremap H <C-w>H
        nnoremap J <C-w>J
        nnoremap K <C-w>K
        nnoremap L <C-w>L
        nnoremap = <C-w>=
        nnoremap _ <C-w>_
        nnoremap + <C-w><bar>
        echom 'Resize Mode'
      else
        let g:resize_active = 0
        " Switch back to 'normal' keys
        nnoremap <esc> <esc>
        nnoremap h h
        nnoremap k gk
        nnoremap j gj
        nnoremap l l
        nnoremap K {
        nnoremap J }
        nnoremap H ^
        nnoremap L $
        nnoremap = =
        nnoremap _ _
        nnoremap + +
        echom ''
      endif
    endfunction
    nnoremap <silent> <Leader>r :call ToggleResizeMode()<CR>
  " }}}
  " TERMINAL DRAWER {{{
    " depends on: CLEAN UI and Terminal Behavior
    nnoremap <silent><leader>\           :call ToggleTerminalDrawer()<CR>
    tnoremap <silent><leader>\ <C-\><C-n>:call ToggleTerminalDrawer()<CR>

    let g:terminal_drawer = { 'win_id': v:null, 'buffer_id': v:null }
    function! ToggleTerminalDrawer() abort
      if win_gotoid(g:terminal_drawer.win_id)
        hide
        set laststatus=2 showmode ruler
      else
        botright new
        if !g:terminal_drawer.buffer_id
          call termopen($SHELL, {"detach": 0})
          let g:terminal_drawer.buffer_id = bufnr("")
        else
          exec 'buffer' g:terminal_drawer.buffer_id
          call RemoveEmptyBuffers()
        endif

        exec 'resize' float2nr(&lines * 0.25)
        setlocal laststatus=0 noshowmode noruler
        setlocal nobuflisted
        echo ''
        startinsert!
        let g:terminal_drawer.win_id = win_getid()

        tnoremap <buffer><Esc> <C-\><C-n>
        nnoremap <buffer><silent><Esc> :q<cr>
        nnoremap <buffer><silent> q :q<CR>
      endif
    endfunction
  " }}}
  " LAZYGIT {{{
    function! ToggleLazyGit()
      echo "Loaded Lazygit"
      call ToggleTerm('lazygit')
    endfunction

    nnoremap <silent><leader>ll :call ToggleLazyGit()<cr>
    tnoremap <silent><leader>ll <C-\><C-n>:call ToggleLazyGit()<CR>
  " }}}
  " CREATE FLOATING WINDOW {{{
    function! CreateCenteredFloatingWindow()
      let width  = float2nr(&columns * 0.9)
      let height = float2nr(&lines * 0.8)
      let top    = ((&lines - height) / 2) - 1
      let left   = (&columns - width) / 2
      let opts   = { 'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal' }
      let top    = "╭" . repeat("─", width - 2) . "╮"
      let mid    = "│" . repeat(" ", width - 2) . "│"
      let bot    = "╰" . repeat("─", width - 2) . "╯"
      let lines  = [top] + repeat([mid], height - 2) + [bot]
      let s:buf  = nvim_create_buf(v:false, v:true)

      call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
      call nvim_open_win(s:buf, v:true, opts)
      set winhl=Normal:Floating
      call InvertBackground()

      call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, CreatePadding(opts))
      autocmd BufWipeout <buffer> exe 'bwipeout '.s:buf
      autocmd BufWipeout <buffer> call ResetBackground()
    endfunction

    function! CreatePadding(opts)
      let a:opts.row    += 1
      let a:opts.height -= 2
      let a:opts.col    += 2
      let a:opts.width  -= 4
      return a:opts
    endfunction
  " }}}
  " TOGGLE TERMINAL && ON TERMINAL EXIT {{{
    function! ToggleTerm(cmd)
      if empty(bufname(a:cmd))
        call CreateCenteredFloatingWindow()
        call termopen(a:cmd, { 'on_exit': function('OnTermExit') })
      else
        bwipeout!
      endif
    endfunction

    function! OnTermExit(job_id, code, event) dict
      if a:code == 0
        bwipeout!
      endif
    endfunction
  " }}}
  " INVERT && RESET BACKGROUND {{{
    function! InvertBackground()
      hi InactiveWindow guibg=NONE
      hi ActiveWindow   guibg=#2c323c
      set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
    endfunction

    function! ResetBackground()
      hi ActiveWindow   guibg=NONE
      hi InactiveWindow guibg=#2c323c
      set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
    endfunction
  " }}}
  " REMOVE EMPTY BUFFERS {{{
    function! RemoveEmptyBuffers()
      let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val)<0 && !getbufvar(v:val, "&mod")')
      if !empty(buffers)
          silent exe 'bw ' . join(buffers, ' ')
      endif
    endfunction
  " }}}
" }}}

" Key Mappings {{{
  let mapleader = "\\"

  nnoremap <leader>vi :tabe $MYVIMRC<cr>
  nnoremap <leader>ut :UndotreeToggle<cr>
  nnoremap <leader>pu :PlugUpdate<cr>
  nnoremap <leader>pi :PlugInstall<cr>
  nnoremap <leader>h  :Helptags<cr>
  nnoremap <leader>bb obinding.pry<esc>:w<cr>^
  nnoremap <leader>fr :%s///gc<left><left><left><left>
  nnoremap <leader>j J

  " More sane vertical navigation - respects columns
  nnoremap k gk
  nnoremap j gj
  vnoremap k gk
  vnoremap j gj

  " rebinds semi-colon in normal mode.
  nnoremap ; :

  nnoremap <f7> :bprevious<cr>
  nnoremap <f8> :tabnext<cr>
  nnoremap <f9> :bnext<cr>

  " Change text without putting the text into register,
  nnoremap c "_c
  nnoremap C "_C
  nnoremap cc "_cc

  " Make s/S/ss behave like d/D/dd without saving to register
  nnoremap s  "_d
  nnoremap S  "_D
  nnoremap ss "_dd

  " Don't yank whitespace at the beginning of a line
  nnoremap Y ^y$

  " Remove Arrow Keys in Normal & Insert Mode
  noremap  <Up>    <Nop>
  noremap  <Down>  <Nop>
  noremap  <Left>  <Nop>
  noremap  <Right> <Nop>
  inoremap <Up>    <Nop>
  inoremap <Down>  <Nop>
  inoremap <Left>  <Nop>
  inoremap <Right> <Nop>
  " And remove other navigations that are defined elsewhere
  map $            <Nop>
  map ^            <Nop>
  map {            <Nop>
  map }            <Nop>
  nmap >>          <Nop>
  nmap <<          <Nop>
  vmap >>          <Nop>
  vmap <<          <Nop>

  " easier navigation in normal / visual / operator pending mode
  noremap K     {
  noremap J     }
  noremap H     g^
  noremap L     g_

  " easier one-off navigation in insert mode
  inoremap <C-k> <Up>
  inoremap <C-j> <Down>
  inoremap <C-h> <Left>
  inoremap <C-l> <Right>

  " Close pane using c-w
  noremap  <C-w> :bd<Cr>

  " Enter inserts newline without leaving Normal mode
  nmap <s-cr> O<Esc>
  nmap <cr>   o<Esc>

  " Search results centered please
  nnoremap <silent> n nzz
  nnoremap <silent> N Nzz
  nnoremap <silent> * *zz
  nnoremap <silent> # #zz

  " jump list (previous, next)
  nnoremap <C-p> <C-i>

  " use tab and shift tab to indent and de-indent code
  nnoremap <Tab>   >>
  nnoremap <S-Tab> <<
  vnoremap <Tab>   >><Esc>gv
  vnoremap <S-Tab> <<<Esc>gv

  " Quicker window movement
  nnoremap <C-j> <C-w>j
  nnoremap <C-k> <C-w>k
  nnoremap <C-h> <C-w>h
  nnoremap <C-l> <C-w>l

  " Moves selected Lines up and Down with alt-j/k
  nnoremap ∆ :m .+1<CR>==
  nnoremap ˚ :m .-2<CR>==
  inoremap ∆ <Esc>:m .+1<CR>==gi
  inoremap ˚ <Esc>:m .-2<CR>==gi
  vnoremap ∆ :m '>+1<CR>gv=gv
  vnoremap ˚ :m '<-2<CR>gv=gv
" }}}

" Plugin Settings & Mappings {{{
  " AIRLINE{{{
    let g:airline#extensions#ale#enabled          = 1
    let g:airline#extensions#tabline#enabled      = 1
    let g:airline#extensions#tabline#formatter    = 'unique_tail_improved'
    let g:airline#extensions#bufferline#enabled   = 1
    let g:airline#extensions#gutentags#enabled    = 1
    let g:airline_theme                           = 'deus'
    let g:airline_powerline_fonts                 = 1
    let g:airline_left_sep                        = '█'
    let g:airline_right_sep                       = '█'
    let g:airline_left_alt_sep                    = ' '
    let g:airline#extensions#tabline#left_sep     = '█'
    let g:airline#extensions#tabline#right_sep    = '█'
    let g:airline#extensions#tabline#left_alt_sep = ' '
  "}}}
  " ALE{{{
    nnoremap <leader>an :ALENextWrap<CR>
    nnoremap <leader>ap :ALEPreviousWrap<CR>
    nnoremap <leader>af :ALEFix<CR>
    nnoremap <f10> :ALEFix<CR>

    let g:ale_linters = {
      \   'javascript': ['eslint'],
      \   'ruby':       ['rubocop'],
      \}

    let g:ale_fixers = {
      \   '*':          ['remove_trailing_lines', 'trim_whitespace'],
      \   'ruby':       ['rubocop'],
      \   'javascript': ['prettier', 'eslint'],
      \   'css' :       ['prettier'],
      \   'html' :      ['prettier'],
      \   'markdown' :  ['prettier'],
      \   'yaml':       ['prettier'],
      \   'json':       ['prettier'],
      \}

    let g:ale_fix_on_save        = 1
    let g:ale_fix_on_save_ignore = { 'ruby': ['rubocop'], 'javascript': ['eslint', 'prettier'] }
    let g:ale_linters_explicit   = 1
    let g:ale_sign_column_always = 1
    let g:ale_sign_error         = '!!'
    let g:ale_sign_warning       = '>>'
    let g:ale_lint_delay         = 0
  "}}}
  " CLEVER-F {{{
    let g:clever_f_smart_case        = 1
    let g:clever_f_fix_key_direction = 1
    " let g:clever_f_mark_char_color   = 'Function'
  " }}}
  " DEFX Filetree browser {{{
    nnoremap <silent>- :Defx<CR>
    call defx#custom#option('_', {
      \ 'columns': 'indent:icons:filename:type:git',
      \ 'winwidth': 50,
      \ 'split': 'vertical',
      \ 'direction': 'topleft',
      \ 'show_ignored_files': 1,
      \ 'buffer_name': 'defx',
      \ 'resume': 1,
      \ 'toggle': 1,
      \ 'root_marker': ':',
      \})

    call defx#custom#column('git', 'show_ignored', 1)
    call defx#custom#column('filename', { 'root_marker_highlight': 'Ignore' })

    let g:defx_git#indicators = {
      \ 'Modified'  : '!',
      \ 'Staged'    : '✚',
      \ 'Untracked' : '?',
      \ 'Renamed'   : '»',
      \ 'Unmerged'  : '≠',
      \ 'Ignored'   : 'ⁱ',
      \ 'Deleted'   : '✖',
      \ 'Unknown'   : '*'
      \ }

    let g:defx_icons_directory_symlink_icon  = '~>'
    let g:defx_icons_directory_icon          = ' +'
    let g:defx_icons_root_opened_tree_icon   = ' -'
    let g:defx_icons_nested_opened_tree_icon = ' -'
    let g:defx_icons_nested_closed_tree_icon = ' +'
    let g:defx_icons_enable_syntax_highlight = 0
    let g:defx_icons_column_length           = 2
    let g:defx_icons_enable_syntax_highlight = 1
    let g:defx_icons_mark_icon               = '*'
    let g:defx_icons_copy_icon               = ''
    let g:defx_icons_move_icon               = ''
    let g:defx_icons_parent_icon             = ''
    let g:defx_icons_default_icon            = ''

    augroup defx_colors
      autocmd!
      autocmd ColorScheme * highlight DefxIconsOpenedTreeIcon guifg=#FFCB6B
      autocmd ColorScheme * highlight DefxIconsNestedTreeIcon guifg=#FFCB6B
      autocmd ColorScheme * highlight DefxIconsClosedTreeIcon guifg=#FFCB6B
    augroup END

    augroup defx_init
      autocmd!
      autocmd BufWritePost * call defx#redraw() " Redraw on file change
      autocmd FileType defx call s:defx_init()  " Load Settings
    augroup END

    function! s:defx_init()
      setl nonumber
      setl norelativenumber
      setl listchars=
      setl nofoldenable
      setl foldmethod=manual
      setl signcolumn=no

      " Define Mappings
      nnoremap <silent><buffer><expr> <esc>
        \ defx#do_action('quit')
      nnoremap <silent><buffer><expr> <CR>
        \ defx#do_action('multi', ['drop', 'quit'])
      nnoremap <silent><buffer><expr> .
        \ defx#do_action('toggle_ignored_files')
      nnoremap <silent><buffer><expr> c
        \ defx#do_action('copy')
      nnoremap <silent><buffer><expr> q
        \ defx#do_action('quit')
      nnoremap <silent><buffer><expr> m
        \ defx#do_action('move')
      nnoremap <silent><buffer><expr> p
        \ defx#do_action('paste')
      nnoremap <silent><buffer><expr> l
        \ defx#do_action('open_tree')
      nnoremap <silent><buffer><expr> h
        \ defx#do_action('close_tree')
      nnoremap <silent><buffer><expr> v
        \ defx#do_action('multi', [['drop', 'vsplit'], 'quit'])
      nnoremap <silent><buffer><expr> s
        \ defx#do_action('multi', [['drop', 'split'], 'quit'])
      nnoremap <silent><buffer><expr> t
        \ defx#do_action('drop', 'tabedit')
      nnoremap <silent><buffer><expr> n
        \ defx#do_action('new_file')
      nnoremap <silent><buffer><expr> d
        \ defx#do_action('remove')
      nnoremap <silent><buffer><expr> r
        \ defx#do_action('rename')
      nnoremap <silent><buffer><expr> <C-r>
        \ defx#do_action('redraw')
      nnoremap <silent><buffer><expr> >
        \ defx#do_action('resize', defx#get_context().winwidth + 10)
      nnoremap <silent><buffer><expr> <
        \ defx#do_action('resize', defx#get_context().winwidth - 10)
    endfunction
  " }}}
  " DEOPLETE{{{
    " Remaps tab and shift-tab to select item in Pop up menu
    inoremap <expr>  <tab> pumvisible() ? "\<C-n>" : "\<tab>"
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    "<TAB>: completion.
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ deoplete#manual_complete()

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~ '\s'
    endfunction

    let g:deoplete#enable_at_startup = 1
    call deoplete#custom#option({
      \ 'num_processes' : -1,
      \ 'max_list'      : 20,
      \ 'sources'       : {
        \ '_': ['tag', 'buffer', 'file', 'syntax'],
        \ 'ruby': ['tag', 'LanguageClient', 'buffer', 'file', 'syntax']
        \ }
      \ })
    call deoplete#custom#option('auto_complete_delay', 0)
    call deoplete#custom#option('smart_case', v:true)
    call deoplete#custom#option('min_pattern_length', 1)
  " }}}
  " EASYALIGN{{{
    xnoremap <leader>ea <Plug>(EasyAlign)
    nnoremap <leader>ea <Plug>(EasyAlign)
  "}}}
  " FZF{{{
    nnoremap <c-t> :Tags<cr>
    nnoremap <c-g> :RG<cr>
    nnoremap <silent><c-f> :Files<CR>
    nnoremap <c-b> :Buffers<cr>

    let $FZF_DEFAULT_COMMAND = 'rg --files --no-ignore-vcs --hidden -g "!{node_modules,.git}"'
    let $FZF_DEFAULT_OPTS    = ' --color=dark --color=fg:15,bg:-1,hl:1,fg+:#ffffff,bg+:0,hl+:1 --color=info:0,prompt:0,pointer:12,marker:4,spinner:11,header:-1 --layout=reverse  --margin=1,4'

    let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }
    let g:fzf_action = {
          \ 'ctrl-s': 'split',
          \ 'ctrl-v': 'vsplit',
          \ 'ctrl-t': 'tab split' }

    let g:fzf_colors = {
          \ 'fg':      ['fg', 'Normal'],
          \ 'bg':      ['bg', 'Normal'],
          \ 'hl':      ['fg', 'Keyword'],
          \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'PreProc'],
          \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
          \ 'hl+':     ['fg', 'Keyword'],
          \ 'info':    ['fg', 'Statement'],
          \ 'border':  ['fg', 'Comment'],
          \ 'prompt':  ['fg', 'Conditional'],
          \ 'pointer': ['fg', 'Statement'],
          \ 'marker':  ['fg', 'Keyword'],
          \ 'spinner': ['fg', 'Label'],
          \ 'header':  ['fg', 'Keyword'] }

    function! RipgrepFzf(query, fullscreen)
      let command_fmt     = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
      let initial_command = printf(command_fmt, shellescape(a:query))
      let reload_command  = printf(command_fmt, '{q}')
      let spec            = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
      call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
    endfunction
    command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
  "}}}
  " GITGUTTER {{{
    let g:gitgutter_sign_added             = '▌'
    let g:gitgutter_sign_modified           = '▌'
    let g:gitgutter_sign_modified_removed  = '▌'
    let g:gitgutter_sign_removed_first_line = '▔'
    let g:gitgutter_sign_removed           = '▁'
  " }}}
  " GUTENTAGS & TAGBAR{{{
    " Tagbar Plugin Binding
    noremap <leader>tb :TagbarToggle<CR>

    " enable gtags module
    let g:gutentags_modules = ['ctags', 'gtags_cscope']

    " config project root markers.
    let g:gutentags_project_root = ['.root', '.git']

    " generate datebases in cache directory, prevent gtags files polluting my project
    let g:gutentags_cache_dir = expand('~/.cache/tags')

    " change focus to quickfix window after search (optional).
    let g:gutentags_plus_switch              = 1

    let g:gutentags_generate_on_new          = 1
    let g:gutentags_generate_on_missing      = 1
    let g:gutentags_generate_on_write        = 1
    let g:gutentags_generate_on_empty_buffer = 0

    let g:gutentags_ctags_exclude = [
      \ '*.git', '*.svg', '*.hg',
      \ '*/tests/*',
      \ 'build',
      \ 'dist',
      \ '*sites/*/files/*',
      \ 'bin',
      \ 'node_modules',
      \ 'bower_components',
      \ 'cache',
      \ 'compiled',
      \ 'docs',
      \ 'example',
      \ 'bundle',
      \ 'vendor',
      \ '*.md',
      \ '*-lock.json',
      \ '*.lock',
      \ '*bundle*.js',
      \ '*build*.js',
      \ '.*rc*',
      \ '*.json',
      \ '*.min.*',
      \ '*.map',
      \ '*.bak',
      \ '*.zip',
      \ '*.pyc',
      \ '*.class',
      \ '*.sln',
      \ '*.Master',
      \ '*.csproj',
      \ '*.tmp',
      \ '*.csproj.user',
      \ '*.cache',
      \ '*.pdb',
      \ 'tags*',
      \ 'cscope.*',
      \ '*.css',
      \ '*.less',
      \ '*.scss',
      \ '*.exe', '*.dll',
      \ '*.mp3', '*.ogg', '*.flac',
      \ '*.swp', '*.swo',
      \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
      \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
      \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
      \ ]

  " }}}
  " HEXOKINASE (COLORIZER) {{{
    let g:Hexokinase_highlighters = [ 'backgroundfull' ]
    let g:Hexokinase_ftEnabled    = ['css', 'html', 'javascript', 'sass', 'slim', 'vim']
    let g:Hexokinase_optInPatterns = [
    \     'full_hex',
    \     'triple_hex',
    \     'rgb',
    \     'rgba',
    \     'hsl',
    \     'hsla'
    \ ]
  " }}}
  " MATCHUP{{{
    augroup matchup_matchparen_highlight
      autocmd!
      autocmd ColorScheme * hi MatchParen guifg=#c678dd gui=bold
      autocmd ColorScheme * hi MatchWord  guifg=#FFCB6B gui=italic
    augroup END
    let g:matchup_surround_enabled     = 1
    let g:matchup_matchparen_deferred  = 1
    let g:matchup_matchparen_offscreen = {}
  "}}}
    " LSP Language Server Client {{{
      nnoremap <silent> <leader>rn :call LanguageClient#textDocument_rename()<CR>
      nnoremap <leader>cm :call LanguageClient_contextMenu()<CR>
      let g:LanguageClient_serverCommands = {
        \ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
        \ }
      let g:LanguageClient_autoStart = 1
      let g:LanguageClient_autoStop  = 0
    " }}}
  " SNEAK {{{
    let g:sneak#label  = 0
    let g:sneak#s_next = 1

    map s <Plug>Sneak_s
    map S <Plug>Sneak_S

    highlight Sneak guifg=black guibg=red
    highlight SneakScope guifg=red guibg=yellow
    highlight SneakLabel guifg=red guibg=yellow
  " }}}
  " SPLITJOIN {{{
    nnoremap <leader>sj :SplitjoinSplit<cr>
    nnoremap <leader>sk :SplitjoinJoin<cr>
  " }}}
  " UNDO TREE {{{
    let g:undotree_WindowLayout       = 4
    let g:undotree_SetFocusWhenToggle = 1
    let g:undotree_ShortIndicators    = 1
  " }}}
" }}}

" Language Settings {{{
  " Ruby {{{
    let ruby_operators = 1
    let ruby_pseudo_operators = 1
  " }}}
" }}}

" Snippits {{{
  inoremap ;do do<space>\|\|<cr>end<up><up><c-o>$<left>
" }}}

" Colorscheme & Highlights {{{
  if (has("autocmd") && !has("gui_running"))
    augroup colorset
      autocmd!
      let s:yellow      = { "gui": "#FFE082", "cterm": "180", "cterm16": "3"  }
      let s:purple      = { "gui": "#C792EA", "cterm": "170", "cterm16": "5"  }
      let s:blue        = { "gui": "#82AAFF", "cterm": "39",  "cterm16": "4"  }
      let s:red         = { "gui": "#E06C75", "cterm": "204", "cterm16": "1"  }
      let s:dark_yellow = { "gui": "#FFCB6B", "cterm": "173", "cterm16": "11" }

      autocmd ColorScheme * call onedark#set_highlight("Constant",            { "fg": s:yellow      })
      autocmd ColorScheme * call onedark#set_highlight("Statement",           { "fg": s:blue        })
      autocmd ColorScheme * call onedark#set_highlight("Macro",               { "fg": s:blue        })
      autocmd ColorScheme * call onedark#set_highlight("CursorLineNr",        { "fg": s:yellow      })
      autocmd ColorScheme * call onedark#set_highlight("rubyConstant",        { "fg": s:dark_yellow })
      autocmd ColorScheme * call onedark#set_highlight("rubySymbolDelimiter", { "fg": s:red         })
      autocmd ColorScheme * call onedark#set_highlight("rubySymbol",          { "fg": s:yellow      })
      autocmd ColorScheme * call onedark#set_highlight("rubyKeywordAsMethod", { "fg": s:blue        })
      autocmd ColorScheme * call onedark#set_highlight("rubyPseudoVariable",  { "fg": s:red         })
      autocmd ColorScheme * call onedark#set_highlight("rubyBoolean",         { "fg": s:red         })
      autocmd ColorScheme * call onedark#set_highlight("rubyInteger",         { "fg": s:red         })
    augroup END
  endif

  let g:onedark_terminal_italics = 1
  let g:onedark_color_overrides  = {
    \ "black":       { "gui": "#181a1b", "cterm": "235", "cterm16": "0"  },
    \ "green":       { "gui": "#C3E88D", "cterm": "114", "cterm16": "2"  },
    \ "yellow":      { "gui": "#FFE082", "cterm": "180", "cterm16": "3"  },
    \ "dark_yellow": { "gui": "#FFCB6B", "cterm": "173", "cterm16": "11" },
    \ "blue":        { "gui": "#82AAFF", "cterm": "39",  "cterm16": "4"  },
    \ "purple":      { "gui": "#C792EA", "cterm": "170", "cterm16": "5"  },
    \ "cyan":        { "gui": "#89DDF3", "cterm": "38",  "cterm16": "6"  },
    \ "white":       { "gui": "#FCFCFC", "cterm": "145", "cterm16": "7"  },
    \}

  syntax on
  colorscheme onedark

  " Custom Italics
  highlight htmlArg   gui=italic
  highlight Comment   gui=italic
  highlight Type      gui=italic
  highlight sassClass gui=italic
  highlight slimClass gui=italic guifg=#ffe082
  highlight slimId    gui=italic guifg=#82AAFF
  highlight slimAttr  gui=italic

  " Active and Inactive window bg color
  hi ActiveWindow   guibg=NONE
  hi InactiveWindow guibg=#2c323c
  set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow

  " Set Transparent Background
  hi Normal guibg=NONE
" }}}
