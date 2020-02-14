" Plugins {{{
  " Install vim-plug
  if empty(glob('~/.config/nvim/autoload/plug.vim'))
      silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif

  call plug#begin()
    Plug 'joshdick/onedark.vim'

    Plug 'sheerun/vim-polyglot'
    Plug 'andymass/vim-matchup'
    Plug 'airblade/vim-gitgutter'
    Plug 'jiangmiao/auto-pairs'
    Plug 'junegunn/vim-easy-align'
    Plug 'AndrewRadev/splitjoin.vim'
    Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'kristijanhusak/defx-git'
    Plug 'kristijanhusak/defx-icons'


    Plug 'dense-analysis/ale'
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'Shougo/neco-syntax'
    Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }

    Plug 'ludovicchabant/vim-gutentags'
    Plug 'skywind3000/gutentags_plus'
    Plug 'majutsushi/tagbar'

    " Plug 'scrooloose/nerdtree'
    " Plug 'ryanoasis/vim-devicons'
    " Plug 'Xuyuanp/nerdtree-git-plugin'
    " Plug 'flw-cn/vim-nerdtree-l-open-h-close'
    " Plug 'vwxyutarooo/nerdtree-devicons-syntax'

    Plug 'junegunn/fzf', { 'do': './install --bin' }
    Plug 'junegunn/fzf.vim'

    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    Plug 'tpope/vim-rails'
    Plug 'tpope/vim-endwise'
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
  set ignorecase            " ignore case on search
  set smartcase             " Ignores case if search is all lower, case sensitive otherwise
  set hlsearch              " Highlight Search
  set re=1                  " Sets regex engine
  set scrolloff=4           " Keep 4 lines below cursonr
  set visualbell            " don't beep
  set noerrorbells          " don't beep
  set belloff=all           " don't flash
  set pastetoggle=<F2>      " turn on paste mode with F2
  set noswapfile
  set splitbelow            " split below, not above
  set splitright            " split right, not left
  set foldmethod=marker     " Fold code between {{{ and }}}
  set grepprg=rg\ --vimgrep " Use RipGrep for grepping
  set clipboard=unnamedplus " Use System Clipboard

  set list
  set listchars=tab:›·,nbsp:•,trail:·,extends:»,precedes:«
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

  " Autoreload changed files
  set autoread
  au CursorHold,CursorHoldI * checktime
  autocmd FileChangedShellPost *
    \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

  " Relative line numbers in Normal mode, absolute numbers in Insert mode
  augroup numbertoggle
    autocmd!
    autocmd WinEnter,BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd WinLeave,BufLeave,FocusLost,InsertEnter   * set norelativenumber
  augroup END
" }}}

" Cursor Settings {{{
  " UNDERSCORE for replace, BOX for normal, PIPE for insert
  let &t_SI = "\<Esc>[6 q"
  let &t_SR = "\<Esc>[4 q"
  let &t_EI = "\<Esc>[2 q"
" }}}

" Key Mappings {{{
  let mapleader = "\<Space>"

  nnoremap <leader>vi :tabe $MYVIMRC<cr>
  nnoremap <leader>so :source $MYVIMRC<cr>
  nnoremap <leader>bp obinding.pry<esc>:w<cr>H
  nnoremap <leader>fr :%s///gc<left><left><left><left>

  " normal mode command to write file should work in insert mode because
  " I forget to hit escape
  inoremap ;w<cr> <esc>:w<cr>

  " save file when leaving insert mode
  inoremap <esc> <esc>:w<cr>

  " More sane vertical navigation
  nmap k gk
  nmap j gj

  " rebinds semi-colon in normal mode. means you don't need to use shift!
  nnoremap ; :

  " Bind `q` to close the buffer for help files
  autocmd Filetype help nnoremap <buffer> q :q<CR>

  " Change text without putting the text into register,
  " see http://tinyurl.com/y2ap4h69
  nnoremap c "_c
  nnoremap C "_C
  nnoremap cc "_cc

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
  noremap H     ^
  noremap L     $

  " easier one-off navigation in insert mode
  inoremap <C-k> <Up>
  inoremap <C-j> <Down>
  inoremap <C-h> <Left>
  inoremap <C-l> <Right>

  " close pane using <C-w> since I know it from Chrome / Atom (cmd+w) and do
  " not use the <C-w> mappings anyway
  noremap  <C-w> :bd<Cr>

  " Enter inserts newline without leaving Normal mode
  nmap <S-Enter> O<Esc>
  nmap <CR>      o<Esc>

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

  " Clears Search
  nmap <silent> ,/ :nohlsearch<CR>

  " Output the current syntax group
  nnoremap <f10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans <' . synIDattr(synID(line("."),col("."),0),"name") . "> lo <" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<cr>

  " Plugin Mappings
  nnoremap <leader>an :ALENextWrap<CR>
  nnoremap <leader>ap :ALEPreviousWrap<CR>
  nnoremap <leader>af :ALEFix<CR>

  nnoremap <c-t> :Tags<cr>
  nnoremap <c-g> :RG<cr>
  nnoremap <silent><leader>ff :call Fzf_dev()<CR>
  nnoremap <silent><c-f> :Files<CR>
  nnoremap <c-b> :Buffers<cr>
  xmap ga <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)
  nmap <Leader>, gcc
  nmap sj :SplitjoinSplit<cr>
  nmap sk :SplitjoinJoin<cr>
  noremap <leader>tb :TagbarToggle<CR>
  nnoremap <silent> <leader>rn :call LanguageClient#textDocument_rename()<CR>
  nnoremap <leader>cm :call LanguageClient_contextMenu()<CR>

  " Remaps tab to select item in Pop up menu
  inoremap <expr> <tab> pumvisible() ? "\<C-n>" : "\<tab>"

  call deoplete#custom#option('candidate_marks',
        \ ['A', 'S', 'D', 'F', 'G'])
  inoremap <expr>A       pumvisible() ?
  \ deoplete#insert_candidate(0) : 'A'
  inoremap <expr>S       pumvisible() ?
  \ deoplete#insert_candidate(1) : 'S'
  inoremap <expr>D       pumvisible() ?
  \ deoplete#insert_candidate(2) : 'D'
  inoremap <expr>F       pumvisible() ?
  \ deoplete#insert_candidate(3) : 'F'
  inoremap <expr>G       pumvisible() ?
  \ deoplete#insert_candidate(4) : 'G'

  " inoremap <silent><expr> <Tab>
  "   \ pumvisible() ? "\<C-n>" :
  "   \ <SID>check_back_space() ? "\<Tab>" :
  "   \ coc#refresh()
  " inoremap <silent><expr> <S-Tab>
  "   \ pumvisible() ? "\<C-p>" :
  "   \ <SID>check_back_space() ? "\<S-Tab>" :
  "   \ coc#refresh()
" }}}

" Plugin Settings {{{
  " AIRLINE{{{
    let g:airline#extensions#coc#enabled          = 1
    let g:airline#extensions#ale#enabled          = 1
    let g:airline#extensions#tabline#enabled      = 1
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
    let g:ale_linters = {
    \   'javascript': ['eslint'],
    \   'ruby':       ['rubocop', 'solargraph'],
    \}

    let g:ale_fixers = {
    \   '*':          ['remove_trailing_lines', 'trim_whitespace'],
    \   'ruby':       ['rubocop'],
    \   'javascript': ['prettier'],
    \   'css' :       ['prettier'],
    \   'html' :      ['prettier'],
    \   'markdown' :  ['prettier'],
    \   'yaml':       ['prettier'],
    \   'json':       ['prettier'],
    \}

    let g:ale_fix_on_save        = 1
    let g:ale_fix_on_save_ignore = { 'ruby': ['rubocop'] }
    let g:ale_linters_explicit   = 1
    let g:ale_sign_column_always = 1
    let g:ale_sign_error         = '!!'
    let g:ale_sign_warning       = '>>'

    " Lint always in Normal Mode
    let g:ale_lint_on_text_changed = 'normal'

    " Lint when leaving Insert Mode but don't lint when in Insert Mode
    let g:ale_lint_on_insert_leave = 1

    " Set ALE's 200ms delay to zero
    let g:ale_lint_delay = 0
    "}}}
" AUTOPAIRS {{{
  " let g:AutoPairsMapCR = 0
  " let g:AutoPairsMapBS = 0
" }}}
  " DEFX Filetree browser {{{
    nnoremap <silent>- :Defx<CR>
    call defx#custom#option('_', {
      \ 'columns': 'indent:icons:space:filename:type:git',
      \ 'winwidth': 50,
      \ 'split': 'vertical',
      \ 'direction': 'topleft',
      \ 'show_ignored_files': 1,
      \ 'buffer_name': '',
      \ 'resume': 1,
      \ 'toggle': 1,
      \})

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

    let g:defx_icons_enable_syntax_highlight = 1
    let g:defx_icons_directory_symlink_icon  = '~>'
    let g:defx_icons_directory_icon          = ' +'
    let g:defx_icons_root_opened_tree_icon   = ' -'
    let g:defx_icons_nested_opened_tree_icon = ' -'
    let g:defx_icons_nested_closed_tree_icon = ' +'
    let g:defx_icons_column_length           = 2
    call defx#custom#column('git', 'show_ignored', 1)

    autocmd FileType defx call s:defx_init()
    function! s:defx_init()
      setl nonumber
      setl norelativenumber
      setl listchars=
      setl nofoldenable
      setl foldmethod=manual
      setl cursorline
      setl signcolumn=no

      " Define Mappings
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
      nnoremap <silent><buffer><expr> P
        \ defx#do_action('paste')
      nnoremap <silent><buffer><expr> l
        \ defx#do_action('open_tree')
      nnoremap <silent><buffer><expr> h
        \ defx#do_action('close_tree')
      nnoremap <silent><buffer><expr> sv
        \ defx#do_action('multi', [['drop', 'vsplit'], 'quit'])
      nnoremap <silent><buffer><expr> sh
        \ defx#do_action('multi', [['drop', 'split'], 'quit'])
      nnoremap <silent><buffer><expr> st
        \ defx#do_action('drop', 'tabedit')
      nnoremap <silent><buffer><expr> N
        \ defx#do_action('new_file')
      nnoremap <silent><buffer><expr> d
        \ defx#do_action('remove')
      nnoremap <silent><buffer><expr> r
        \ defx#do_action('rename')
      nnoremap <silent><buffer><expr> <C-r>
        \ defx#do_action('redraw')
      nnoremap <silent><buffer><expr> > defx#do_action('resize',
        \ defx#get_context().winwidth + 10)
      nnoremap <silent><buffer><expr> < defx#do_action('resize',
        \ defx#get_context().winwidth - 10)
    endfunction
  " }}}
  " DEOPLETE{{{
    call deoplete#custom#option({
      \ 'auto_complete_delay' :  50,
      \ 'ignore_case'         :  1,
      \ 'smart_case'          :  1,
      \ 'camel_case'          :  1,
      \ 'refresh_always'      :  1,
      \ })
    let g:deoplete#enable_at_startup = 1
    call deoplete#custom#option('sources', { '_': ['ale', 'buffer', 'tag'] })
  " }}}
  " EASYALIGN{{{
    let g:easy_align_delimiters = {
            \ '?': {'pattern': '?'},
            \ '>': {'pattern': '>>\|=>\|>'}
            \ }
  "}}}
  " FZF{{{
    let $FZF_DEFAULT_COMMAND = 'rg --files --no-ignore-vcs --hidden -g "!{node_modules,.git}"'
    let $FZF_DEFAULT_OPTS    = ' --color=dark --color=fg:15,bg:-1,hl:1,fg+:#ffffff,bg+:0,hl+:1 --color=info:0,prompt:0,pointer:12,marker:4,spinner:11,header:-1 --layout=reverse  --margin=1,4'

    let g:fzf_layout = { 'window': 'call FloatingFZF()' }
    let g:fzf_action = {
          \ 'ctrl-s': 'split',
          \ 'ctrl-v': 'vsplit',
          \ 'ctrl-t': 'tab split' }
    let g:fzf_colors = {
          \ 'fg':      ['fg', 'Normal'],
          \ 'bg':      ['bg', '#2c323c'],
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


    function! RipgrepFzf(query, fullscreen)
      let command_fmt     = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
      let initial_command = printf(command_fmt, shellescape(a:query))
      let reload_command  = printf(command_fmt, '{q}')
      let spec            = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
      call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
    endfunction
    command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

    function! FloatingFZF()
      let buf        = nvim_create_buf(v:false, v:true)
      call setbufvar(buf, '&signcolumn', 'no')
      let height     = float2nr(25)
      let width      = float2nr(&columns * 0.9)
      let horizontal = float2nr((&columns - width) / 2)
      let vertical   = 3
      let opts       = {
            \ 'relative': 'editor',
            \ 'row':      vertical,
            \ 'col':      horizontal,
            \ 'width':    width,
            \ 'height':   height,
            \ 'style':    'minimal'
            \ }
      call nvim_open_win(buf, v:true, opts)
    endfunction

    " Files + devicons + floating fzf
    function! Fzf_dev()
      let l:fzf_files_options = '--preview "bat --theme="TwoDark" --style=numbers,changes --color always {2..-1} | head -'.&lines.'"'
      function! s:files()
        let l:files = split(system($FZF_DEFAULT_COMMAND), '\n')
        return s:prepend_icon(l:files)
      endfunction

      function! s:prepend_icon(candidates)
        let l:result = []
        for l:candidate in a:candidates
          let l:filename = fnamemodify(l:candidate, ':p:t')
          let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
          call add(l:result, printf('%s %s', l:icon, l:candidate))
        endfor

        return l:result
      endfunction

      function! s:edit_file(item)
        let l:pos = stridx(a:item, ' ')
        let l:file_path = a:item[pos+1:-1]
        execute 'silent e' l:file_path
      endfunction

      call fzf#run({
            \ 'source': <sid>files(),
            \ 'sink':   function('s:edit_file'),
            \ 'options': '-m --reverse ' . l:fzf_files_options,
            \ 'down':    '40%',
            \ 'window': 'call FloatingFZF()'})

    endfunction
  "}}}
  " GUTENTAGS {{{
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
    " LSP Language Server Client {{{
    let g:LanguageClient_serverCommands = {
        \ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
        \ }
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
" }}}

" Language Settings {{{
  " Ruby {{{
    let ruby_operators = 1
    let ruby_pseudo_operators = 1
  " }}}
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
