" -----------------------------------------------------------------------------
" phoenix's vimrc file
" -----------------------------------------------------------------------------
"

if has('python3')
endif

let g:vimrc_private = '~/.vimrc.private'
let g:DEBUG = 0

" script encoding
scriptencoding utf-8

set nocompatible                                           " cp   close vi-compatible
set updatetime=500

" mapleader
let g:mapleader = ';'

" -----------------------------------------------------------------------------
" source files
" -----------------------------------------------------------------------------
" Plug
runtime plug.vim

" functions
runtime lib/function.vim

" keymap
runtime lib/keymap.vim

" abbreviations
runtime lib/abbreviations.vim

" nop
runtime lib/nop.vim

"command
runtime lib/commands.vim

"fold
runtime lib/fold.vim

"config for kinds of filetype
runtime lib/filetype/*.vim

let s:Keymap = g:VIMRC.Keymap
let s:Utils = g:VIMRC.Utils

" -----------------------------------------------------------------------------
" path
" -----------------------------------------------------------------------------
set noautochdir                                              " acd  change the current working driectory
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*

" -----------------------------------------------------------------------------
" APPEARANCE
" -----------------------------------------------------------------------------
set cmdheight=1                                            " ch   set command height
set cmdwinheight=6                                         " cwh  set command-line window height
set colorcolumn=101,121                                    " cc   highlight column
set cursorcolumn                                           " cuc  highlight current column
set cursorline                                             " cul  highlight current line
set display+=lastline
set guicursor=a:block-blinkon0,i:ver30-blinkon0
set list                                                   " list list mode
set listchars=tab:>\ ,trail:_,extends:>,precedes:<,nbsp:+  " lcs  strings to use in list mode
set number                                                 " nu   line number
set previewheight=10                                       " pvh
set ruler                                                  " ru   show the cursor position all the time
set relativenumber
set scrolloff=1                                            " so   keep 2 lines as the scrolling context
set sidescrolloff=5
set showcmd                                                " sc   display incomplete command
set textwidth=120                                          " tw   maxium width of text
set wildmenu
set nowrap                                                 " wrap wrap text

" -----------------------------------------------------------------------------
" FOLD
" -----------------------------------------------------------------------------
set foldmethod=marker
set foldcolumn=2

" -----------------------------------------------------------------------------
" SEARCH
" -----------------------------------------------------------------------------
set hlsearch                                               " hls  highlight search string
set ignorecase                                             " ic   ignore case in search pattern
set incsearch                                              " is   do incremental searching
set smartcase                                              " scs  override the 'ignorecase' option if the search pattern contains upppercase char

" -----------------------------------------------------------------------------
" SYSTEM
" -----------------------------------------------------------------------------
set backupcopy=yes                                         " bkc  do when writing a file and a backup is made

" -----------------------------------------------------------------------------
" EDIT - APPEARANCE
" -----------------------------------------------------------------------------
set backspace=indent,eol,start                             " bs   allow backspacing over everything in insert mode

" -----------------------------------------------------------------------------
" EDIT - INDENT
" -----------------------------------------------------------------------------

set cindent                                                " cin  C indent

" -----------------------------------------------------------------------------
" TAB
" -----------------------------------------------------------------------------
set expandtab                                              " et   Use the appropriate number of spaces to insert a <Tab>
set shiftround
set shiftwidth=2                                           " sw   Number of spaces to use for each step of (auto)indent
set smarttab
set softtabstop=2
set tabstop=2                                              " ts   Number of spaces that a <Tab> in the file counts for

set noautoread                                             " ar   automatically read file when changed
set autowrite                                              " aw   automatically write file when changed
set history=50                                             " hi   command line history
set sidescroll=10                                          " ss   the minimal number of columns to scroll horizontally
set whichwrap=b,s,<,>,~,[,]                                " ww   move cursor left/right to the previous/next line

" -----------------------------------------------------------------------------
" NAVIGATION
" -----------------------------------------------------------------------------
set mouse=                                                 "      Enable the use of mouse

" -----------------------------------------------------------------------------
" SESSION
" -----------------------------------------------------------------------------
set sessionoptions=blank,buffers,curdir,folds,tabpages,    " ssop Change the efffect of the :mksession command
  \ unix,resize,winpos,winsize

" -----------------------------------------------------------------------------
" COLOR SCHEME
" -----------------------------------------------------------------------------
"colorscheme desertEx
"colorscheme dracula
set background=dark
colorscheme solarized

" -----------------------------------------------------------------------------
" ENCODE AND LANGUAGE
" -----------------------------------------------------------------------------
set fileformats=unix,dos                                   " ff   file format
set helplang=en                                            " hlg   set help language to English
set encoding=utf-8                                         " enc   set the character encoding
set fileencodings=utf-8,gbk,gb2312,gb18030                 " fencs set a list of character encodings
set termencoding=utf-8
set langmenu=en_US

let $LANG='en_US'

" -----------------------------------------------------------------------------
" SYNTAX
" -----------------------------------------------------------------------------
syntax enable
syntax on

" -----------------------------------------------------------------------------
" AUTOCMD
" -----------------------------------------------------------------------------

augroup cmdwin
  autocmd!
  let s:cmdwin_map_options = { 'buffer': 1, 'normal': 0, 'insert': 0 }
  autocmd CmdwinEnter * call s:Keymap.mapInsertCommands('<esc>', '<c-c><c-c>', s:cmdwin_map_options)
  autocmd CmdwinEnter * call s:Keymap.mapNormalCommands('<esc>', '<c-c><c-c>', s:cmdwin_map_options)
  autocmd CmdwinEnter * call s:Keymap.mapNormalCommands('q', '<c-c><c-c>', s:cmdwin_map_options)

  " disable vim-helptab
  autocmd CmdwinEnter * inoreabbrev <expr> h VIMRC.Utils.HelpTab()
  autocmd CmdwinEnter * cnoreabbrev h h
augroup END

augroup javascript
  autocmd!
  autocmd FileType javascript call s:autocmdJavaScript()
augroup END

augroup make
  autocmd!
  autocmd FileType make call s:autocmdMake()
augroup END

function! s:autocmdMake()
  set noexpandtab
endfunction

function! s:autocmdJavaScript()
  nnoremap <buffer> <D-d> :TernDef<cr>
  nnoremap <buffer> <D-r> :TernRename<cr>
endfunction

augroup filetype
  autocmd!
  autocmd BufNewFile,BufRead *.xtpl,*.art  set filetype=html
  autocmd BufNewFile,BufRead *.es6         set filetype=javascript
  autocmd BufNewFile,BufRead .babelrc,.eslintrc
                                         \ set filetype=json
  autocmd BufNewFile,BufRead *.scss        set filetype=scss.css
  autocmd BufNewFile,BufRead .vimrc        set filetype=vim
  autocmd BufRead vim.profile              set filetype=txt

  autocmd FileType vim,javascript,html     setlocal nowrap
augroup END


function! s:changeVimshellPWD()
  if &filetype ==? 'vimshell'
    call vimshell#cd(getcwd())
  endif
endfunction

augroup init
  autocmd!
  autocmd BufEnter * call s:changeVimshellPWD()

  " change the current directory
  "autocmd BufEnter * lcd %:p:h

  " Make sure syntax on
  "autocmd BufEnter * syntax enable

  " source vimrc after save it
  autocmd BufWritePost $MYVIMRC call ReloadVimrc()

  autocmd BufWritePost ~/.vim/abbreviations.vim runtime abbreviations.vim
  autocmd BufWritePost ~/.vim/plug.vim runtime plug.vim

  " Open NERDTree in new tabs and windows if no command line args set
  "autocmd VimEnter *  if has('gui_running') | call OpenProject('last_project') | endif

  " Save project & session
  "autocmd VimLeave *  if has('gui_running') | call SaveWorkspace() | endif

  " Save session
  "autocmd VimLeave * if (has('g:project')) | execute 'mksession ~/.session_'.g:project | endif

augroup END

" -----------------------------------------------------------------------------
" KEYMAP
" -----------------------------------------------------------------------------

" NORMAL ----------------------------------
" Exit
call s:Keymap.mapNormalCommands('<leader>qq', ':q!<cr>')

" command line
call s:Keymap.mapNormalCommands('/', 'q/i', { 'normal': 0 })
call s:Keymap.mapNormalCommands(':', 'q:i', { 'normal': 0 })
call s:Keymap.mapNormalCommands('?', 'q?i', { 'normal': 0 })

" select a jump in the list
nnoremap <silent> <leader>j :call GotoJump()<cr>

" visually select the word
call s:Keymap.mapNormalCommands('<space>', 'viw')

" convert the current workd to uppercase
call s:Keymap.mapNormalCommands('<leader>U', 'mqviwgU`q')
call s:Keymap.mapInsertCommands('<c-u>', '<ESC>mqviwU`q')
" convert the current word to lowercase
call s:Keymap.mapNormalCommands('<leader>u', 'mqviwgu`q')

" surround the world in backticks
call s:Keymap.mapNormalCommands('<leader>`', 'mqviw<c-v><esc>a\`<c-v><esc>hbi\`<c-v><esc>lel`ql')
" surround the world in double quotes
call s:Keymap.mapNormalCommands('<leader>"', 'mqviw<c-v><esc>a\"<c-v><esc>hbi\"<c-v><esc>lel`ql')
" surround the world in single quotes
call s:Keymap.mapNormalCommands('<leader>''', 'mqviw<c-v><esc>a''<c-v><esc>hbi''<c-v><esc>lel`ql')
" surround the world in parenthesis
call s:Keymap.mapNormalCommands('<leader>(', 'mqviw<c-v><esc>a)<c-v><esc>hbi(<c-v><esc>lel`ql')
" surround the world in brackets
call s:Keymap.mapNormalCommands('<leader>[', 'mqviw<c-v><esc>a]<c-v><esc>hbi[<c-v><esc>lel`ql')
" surround the world in braces
call s:Keymap.mapNormalCommands('<leader>{', 'mqviw<c-v><esc>a<space>}<c-v><esc>hbi{<space><c-v><esc>lel`ql')
" surround the lines in braces
call s:Keymap.mapNormalCommands('<leader>}', 'mqkA<c-v><space>{<c-v><esc>`qA<c-v><cr>}<c-v><esc>k=`q')
" append semicolon into the end of line
call s:Keymap.mapNormalCommands('<leader>;;', 'mqA;<c-v><esc>`q')
" append comma into the end of line
call s:Keymap.mapNormalCommands('<leader>,', 'mqA,<c-v><esc>`q')

" delete the current line
inoremap <c-d> <esc>ddi

" ESC
call s:Keymap.mapInsertCommands('kl', '<ESC>', { 'normal': 0, 'insert': 0 })
call s:Keymap.mapVisualCommands('kl', '<ESC>', { 'normal': 0 })


" VIEW ------------------------------------
" visually select the word
vnoremap <space> iw

" MOTION ----------------------------------
" CamelCase Motions
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge
sunmap w
sunmap b
sunmap e
sunmap ge

omap <silent> iw <Plug>CamelCaseMotion_iw
xmap <silent> iw <Plug>CamelCaseMotion_iw
omap <silent> ib <Plug>CamelCaseMotion_ib
xmap <silent> ib <Plug>CamelCaseMotion_ib
omap <silent> ie <Plug>CamelCaseMotion_ie
xmap <silent> ie <Plug>CamelCaseMotion_ie

" OPERATOR ------------------------------------

" Reset Keymaps
inoremap <C-TAB> <C-TAB>

" Reload and edit vimrc
nnoremap <leader>ee :call VIMRC.Utils.EditInVSplit($MYVIMRC)<cr>
nnoremap <leader>ea :call VIMRC.Utils.EditInVSplit('~/.vim/abbreviations.vim')<cr>
nnoremap <leader>ss :call ReloadVimrc()<cr>

" Edit zshrc
nnoremap <leader>ez :call VIMRC.Utils.EditInVSplit('~/.zshrc')<cr>
nnoremap <leader>sz :source ~/.zshrc<cr>

" Edit Plug config
nnoremap <leader>ep :call VIMRC.Utils.EditInVSplit('~/.vim/plug.vim')<cr>

nnoremap <leader>m :w <BAR> !lessc % > %:t:r.css<cr><space>

" TODO:NERDCommenter
call s:Keymap.mapNormalCommands('<D-/>', '<plug>NERDCommenterToggle<cr>', { 'normal': 0, 'nore': 0 })
call s:Keymap.mapInsertCommands('<D-/>', '<esc><plug>NERDCommenterToggle<cr>i', { 'normal': 0, 'insert': 0, 'debug': 1 })

" BufExplorer
nnoremap <silent> <F2> :ToggleBufExplorer<cr>

" TODO List
nnoremap <silent> <F10> :Ack --ignore-dir=node_modules --ignore-file=".view.art.js" TODO <cr>

" Ctrlp
"noremap <silent> <C-SPACE> :CtrlPMRUFiles<cr>
"noremap! <silent> <C-SPACE> <esc>:CtrlPMRUFiles<cr>

" YCM
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<cr>

" Dash
map <F1> <Plug>DashSearch
map <S-F1> :Dash

" Buffer
nnoremap <silent> <D->> :bn<cr>
nnoremap <silent> <D-<> :bp<cr>

" Window
" choosewin
nmap <silent> - <plug>(choosewin)

" Tab
nnoremap <slient> † :tab new<cr>
nnoremap <silent> ∑ :tabclose<cr>
call s:Keymap.mapNormalCommands('<D-1>', '1gt')
call s:Keymap.mapInsertCommands('<D-1>', '<ESC>1gt')
call s:Keymap.mapNormalCommands('<D-2>', '2gt')
call s:Keymap.mapInsertCommands('<D-2>', '<ESC>2gt')
call s:Keymap.mapNormalCommands('<D-3>', '3gt')
call s:Keymap.mapInsertCommands('<D-3>', '<ESC>3gt')
call s:Keymap.mapNormalCommands('<D-4>', '4gt')
call s:Keymap.mapInsertCommands('<D-4>', '<ESC>4gt')
call s:Keymap.mapNormalCommands('<D-5>', '5gt')
call s:Keymap.mapInsertCommands('<D-5>', '<ESC>5gt')
call s:Keymap.mapNormalCommands('<D-6>', '6gt')
call s:Keymap.mapInsertCommands('<D-6>', '<ESC>6gt')
call s:Keymap.mapNormalCommands('<D-7>', '7gt')
call s:Keymap.mapInsertCommands('<D-7>', '<ESC>7gt')
call s:Keymap.mapNormalCommands('<D-8>', '8gt')
call s:Keymap.mapInsertCommands('<D-8>', '<ESC>8gt')
call s:Keymap.mapNormalCommands('<D-9>', '9gt')
call s:Keymap.mapInsertCommands('<D-9>', '<ESC>9gt')

noremap <silent> <F9> :call ToggleVimShell()<cr>
noremap! <silent> <F9> <esc>:call ToggleVimShell()<cr>
nnoremap <silent> <S-F9> :call OpenVimShellTab()<cr>
noremap! <silent> <S-F9> <esc>:call OpenVimShellTab()<cr>
autocmd FileType vimshell nnoremap <buffer> i GA

" Format
"noremap <F5> :Autoformat<CR>

" JSDoc
noremap <silent> ∂ :JsDoc<cr>
noremap! <silent> ∂ :JsDoc<cr>


" Color scheme
noremap <silent> ≤ :PrevColorScheme<cr>
noremap <silent> ≥ :NextColorScheme<cr>

" Edit
inoremap <C-L> <esc>ddi
nnoremap <C-L> dd
nnoremap = V=
cmap w!! w !sudo tee > /dev/null %

" Quickfix
call s:Keymap.mapNormalCommands('<leader>qn', ':cnext<cr>', { 'normal': 0 })
call s:Keymap.mapNormalCommands('<leader>qp', ':cprevious<cr>', { 'normal': 0 })
call s:Keymap.mapNormalCommands('<leader>qc', ':cclose<cr>', { 'normal': 0 })
" Location list
call s:Keymap.mapNormalCommands('<leader>ln', ':lnext<cr>', { 'normal': 0 })
call s:Keymap.mapNormalCommands('<leader>lp', ':lprevious<cr>', { 'normal': 0 })
call s:Keymap.mapNormalCommands('<leader>lc', ':lclose<cr>', { 'normal': 0 })

" Profile
nnoremap <leader>ps :call StartProfile()<cr>
nnoremap <leader>pe :call EndProfile()<cr>

" Syntax

" }}}

" -----------------------------------------------------------------------------
" HACKS
" -----------------------------------------------------------------------------
" Fix 'git-sh-setup: No such file' issue in MacVim
if has("gui_macvim")
  set shell=/bin/bash\ -l
endif

" -----------------------------------------------------------------------------
" SETTINGS - Plugins
" -----------------------------------------------------------------------------
" load the config of all plugins
runtime! lib/plugin/**/*.vim

" -----------------------------------------------------------------------------
" SETTINGS - netrw
" -----------------------------------------------------------------------------
let g:netrw_browse_split = 4
"let g:netrw_liststyle = 4
let g:netrw_winsize = 25
let g:netrw_altv = 1

"nnoremap <silent> <F3> :Vexplore<cr>

function! ToggleVexplore()
  if &filetype ==? 'netrw'
    echom 'open'
    Vexplore
  else
    q
  endif
endfunction

augroup ProjectDrawer
  autocmd!
  "autocmd VimEnter * :call TryOpenVexplore()
augroup END

function! TryOpenVexplore()
  if &filetype != 'startify'
    Vexplore
  endif
endfunction

" -----------------------------------------------------------------------------
" SETTINGS - gitgutter
" -----------------------------------------------------------------------------
"let g:gitgutter_realtime = 0
let g:gitgutter_eager     = 0

" -----------------------------------------------------------------------------
" SETTINGS - sjl/splice.vim
" -----------------------------------------------------------------------------
let g:splice_initial_mode = 'grid'
let g:splice_initial_layout_grid = 1
let g:splice_initial_scrollbind_grid = 1
let g:splice_initial_prefix = '<leader>t'
let g:splice_wrap = 'nowrap'

" -----------------------------------------------------------------------------
" SETTINGS - devicons
" -----------------------------------------------------------------------------
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete:h15
"set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete:h14
let g:WebDevIconsOS                           = 'Darwin'
let g:WebDevIconsUnicodeDecorateFolderNodes   = 1
let g:WebDevIconsUnicodeGlyphDoubleWidth      = 1
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
let g:webdevicons_conceal_nerdtree_brackets   = 1

let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {
  \ 'jsx'      : '',
  \ 'js'       : '',
  \ 'html'     : '',
  \ 'art'      : '',
  \ 'xtpl'     : '',
  \ 'es6'      : ''
  \}

" -----------------------------------------------------------------------------
" SETTINGS - tiagofumo/vim-nerdtree-syntax-highlight
" -----------------------------------------------------------------------------
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExtensionHighlightColor = {
  \ 'es6' : 'F5C06F',
  \ 'xtpl': 'F16529',
  \ 'art' : 'F16529',
  \ 'jade': 'F16529',
  \}

" -----------------------------------------------------------------------------
" SETTINGS - vim-better-whitespace
" -----------------------------------------------------------------------------
let g:better_whitespace_filetypes_blacklist = ['markdown', 'vim', 'startify']

augroup autoFixWhitespace
  autocmd!
  " fix whitespace
  autocmd FileType javascript,java,html,art,xtpl,css,less,sass,php,json,sh,zsh,snippets,vim,graphql
    \ autocmd BufWritePre <buffer> StripWhitespace
augroup END

" -----------------------------------------------------------------------------
" SETTINGS - osyo-manga/vim-watchdogs
" -----------------------------------------------------------------------------
let g:watchdogs_check_BufWritePost_enable = 1

" -----------------------------------------------------------------------------
" SETTINGS - fatih/vim-go
" -----------------------------------------------------------------------------
let g:go_test_timeout = '10s'
" Keymap
augroup go
  autocmd!
  let s:go_map_options = { 'nore': 0, 'normal': 0 }
  autocmd FileType go call s:Keymap.mapNormalCommands('<leader>t', '<Plug>(go-test)', s:go_map_options)
  autocmd FileType go call s:Keymap.mapNormalCommands('<leader>b', '<Plug>(go-build)', s:go_map_options)
  autocmd FileType go call s:Keymap.mapNormalCommands('<leader>r', '<Plug>(go-run)', s:go_map_options)
augroup END

" -----------------------------------------------------------------------------
" SETTINGS - bling/vim-bufferline
" -----------------------------------------------------------------------------
"let g:bufferline_echo = 0

" -----------------------------------------------------------------------------
" SETTINGS - w0rp/ale
" -----------------------------------------------------------------------------
let g:ale_linters = {
      \ 'javascript': ['eslint'],
      \ 'scss': ['scsslint']
      \}

let g:ale_sign_column_always = 1
let g:ale_list_window_size = 6

let g:ale_lint_on_text_changed = 'never'

let s:ale_map_options = { 'nore': 0, 'normal': 0 }
call s:Keymap.mapNormalCommands('<c-k>', '<Plug>(ale_previous_wrap)', s:ale_map_options)
call s:Keymap.mapNormalCommands('<c-j>', '<Plug>(ale_next_wrap)', s:ale_map_options)

let g:ale_open_list = 1
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1

let g:ale_maximum_file_size = 32768

let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_sign_info = '¶'
let g:ale_sign_style_error = '»'
let g:ale_sign_style_warning = '›'


" -----------------------------------------------------------------------------
" SETTINGS - Syntastic
" -----------------------------------------------------------------------------
" Syntastic

"call s:Keymap.mapNormalCommands('<F6>', ':SyntasticCheck<cr>')

if !exists('g:hasLoadVimrc') || g:hasLoadVimrc != 1
  set statusline+=%#waringmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*
endif

"let g:syntastic_debug = 3

let g:syntastic_auto_jump=0
let g:syntastic_check_on_open=0
let g:syntastic_check_on_wq=0
let g:syntastic_auto_loc_list=1
let g:syntastic_loc_list_height=6
let g:syntastic_sort_aggregated_errors = 0
let g:syntastic_always_populate_loc_list=1
let g:syntastic_shell='/usr/local/bin/zsh'

let g:syntastic_ignore_files = ['\m\c\.bundle\.js$']

let g:syntastic_filetype_map = {
  \ 'javascript.jsx': 'javascript'
  \ }

let g:syntastic_mode_map = {
    \ 'mode': 'active',
    \ 'passive_filetypes': [
    \   'javascript',
    \   'vim'
    \ ]
\}

let g:syntastic_java_javac_autoload_maven_classpath=1

let g:syntastic_applescript_checkers=['osacompile']

let g:syntastic_coffeescript_checkers=['coffee']

let g:syntastic_css_checkers=['csslint']

let g:syntastic_html_checkers=['tidy']
let g:syntastic_html_tidy_exec='tidy5'

let g:syntastic_jade_checkers=['pug_lint']

let g:syntastic_java_checkers=['checkstyle', 'javac']

let g:syntastic_javascript_checkers=['eslint']

let g:syntastic_json_checkers=['jsonlint']

let g:syntastic_less_checkers=['lessc']

let g:syntastic_markdonw_checkers=['mdl']

let g:syntastic_sass_checkers=['sass']
let g:syntastic_scss_checkers=['sass']

let g:syntastic_sh_checkers=['bashate']

let g:syntastic_sql_checkers=['sqlint']

let g:syntastic_typescript_checkjers=['eslint', 'tslint']

let g:syntastic_vim_checkers=['vimlint']

let g:syntastic_zsh_checkers=['zsh']

" -----------------------------------------------------------------------------
" SETTINGS - jsDoc
" -----------------------------------------------------------------------------
let g:jsdoc_input_description = 1
let g:jsdoc_allow_input_prompt = 1
let g:jsdoc_access_descriptions = 1
let g:jsdoc_underscore_private = 1
let g:jsdoc_custom_args_regex_only = 1
let g:jsdoc_custom_args_hook = {
      \   '^\$': {
      \     'type': '{jQuery}'
      \   },
      \   'callback': {
      \     'type': '{Function}',
      \     'description': 'Callback function'
      \   },
      \   'data': {
      \     'type': '{Object}'
      \   },
      \   '^e$': {
      \     'type': '{Event}'
      \   },
      \   '^event$': {
      \     'type': '{Event}'
      \   },
      \   'el$': {
      \     'type': '{Element}'
      \   },
      \   '\(err\|error\)$': {
      \     'type': '{Error}'
      \   },
      \   'handler$': {
      \     'type': '{Function}'
      \   },
      \   '^i$': {
      \     'type': '{Number}'
      \   },
      \   '^_\?is': {
      \     'type': '{Boolean}'
      \   },
      \   'options$': {
      \     'type': '{Object}'
      \   },
      \ }
let g:jsdoc_enable_es6 = 1

" -----------------------------------------------------------------------------
" SETTINGS - othree/javascript-libraries-syntax.vim
" -----------------------------------------------------------------------------
let g:used_javascript_libs = "jquery,underscore,react,jasmine,vue"

" -----------------------------------------------------------------------------
" SETTINGS - ruanyl/vim-fixmyjs
" --------------- --------------------------------------------------------------
let g:fixmyjs_engine = 'eslint'
let g:fixmyjs_rc_filename = ['.eslintrc', '.eslintrc.json']
let g:fixmyjs_rc_local = 1
let g:fixmyjs_use_local = 1
noremap <leader>f :Fixmyjs<CR>

" -----------------------------------------------------------------------------
" SETTINGS - vim-javascript
" -----------------------------------------------------------------------------
set regexpengine=1
"set foldmethod=syntax

let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1
let g:javascript_enable_domhtmlcss = 1

"let g:javascript_conceal_function             = "ƒ"
"let g:javascript_conceal_null                 = "ø"
"let g:javascript_conceal_this                 = "@"
"let g:javascript_conceal_return               = "⇚"
"let g:javascript_conceal_undefined            = "¿"
"let g:javascript_conceal_NaN                  = "ℕ"
"let g:javascript_conceal_prototype            = "¶"
"let g:javascript_conceal_static               = "•"
"let g:javascript_conceal_super                = "Ω"
"let g:javascript_conceal_arrow_function       = "⇒"
"let g:javascript_conceal_noarg_arrow_function = "🞅"
"let g:javascript_conceal_underscore_arrow_function = "🞅"

" -----------------------------------------------------------------------------
" SETTINGS - maksimr/vim-jsbeautify
" -----------------------------------------------------------------------------
" Keymap

augroup jsbeautify
  autocmd!
  let s:jsbeautify_map_options = { 'buffer': 1, 'normal': 0 }
  autocmd FileType javascript call s:Keymap.mapNormalCommands('<c-f>', ':call JsBeautify()<cr>', s:jsbeautify_map_options)
  autocmd FileType json call s:Keymap.mapNormalCommands('<c-f>', ':call JsonBeautify()<cr>', s:jsbeautify_map_options)
  autocmd FileType jsx call s:Keymap.mapNormalCommands('<c-f>', ':call JsxBeautify()<cr>', s:jsbeautify_map_options)
  autocmd FileType html call s:Keymap.mapNormalCommands('<c-f>', ':call HtmlBeautify()<cr>', s:jsbeautify_map_options)
  autocmd FileType css call s:Keymap.mapNormalCommands('<c-f>', ':call CSSBeautify()<cr>', s:jsbeautify_map_options)

  autocmd FileType javascript call s:Keymap.mapVisualCommands('<c-f>', ':call RangeJsBeautify()<cr>', s:jsbeautify_map_options)
  autocmd FileType json call s:Keymap.mapVisualCommands('<c-f>', ':call RangeJsonBeautify()<cr>', s:jsbeautify_map_options)
  autocmd FileType jsx call s:Keymap.mapVisualCommands('<c-f>', ':call RangeJsxBeautify()<cr>', s:jsbeautify_map_options);
  autocmd FileType html call s:Keymap.mapVisualCommands('<c-f>', ':call RangeHtmlBeautify()<cr>', s:jsbeautify_map_options)
  autocmd FileType css call s:Keymap.mapVisualCommands('<c-f>', ':call RangeCSSBeautify()<cr>', s:jsbeautify_map_options)
augroup END

" -----------------------------------------------------------------------------
" SETTINGS - python-mode/python-mode
" -----------------------------------------------------------------------------
"let g:pymode_python = 'python3'
let g:pymode_trim_whitespaces = 1
let g:pymode_options_max_line_length = 119
let g:pymode_options_colorcolumn = 1

let g:pymode_quickfix_minheight = 3
let g:pymode_quickfix_maxheight = 6

let g:pymode_lint_on_write = 1
let g:pymode_lint_message = 1
let g:pymode_lint_cwindow = 1
let g:pymode_lint_signs = 1

let g:pymode_rope = 1
let g:pymode_rope_completion = 1
let g:pymode_rope_complete_on_dot = 1

let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_print_as_function = 0
let g:pymode_syntax_highlight_async_await = g:pymode_syntax_all
let g:pymode_syntax_highlight_equal_operator = g:pymode_syntax_all
let g:pymode_syntax_highlight_stars_operator = g:pymode_syntax_all
let g:pymode_syntax_highlight_self = g:pymode_syntax_all
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all
let g:pymode_syntax_string_formatting = g:pymode_syntax_all
let g:pymode_syntax_string_format = g:pymode_syntax_all
let g:pymode_syntax_string_templates = g:pymode_syntax_all
let g:pymode_syntax_doctests = g:pymode_syntax_all
let g:pymode_syntax_builtin_objs = g:pymode_syntax_all
let g:pymode_syntax_builtin_types = g:pymode_syntax_all
let g:pymode_syntax_highlight_exceptions = g:pymode_syntax_all
let g:pymode_syntax_docstrings = g:pymode_syntax_all

" -----------------------------------------------------------------------------
" SETTINGS - othree/html5.vim
" -----------------------------------------------------------------------------
let g:html5_event_handler_attributes_complete = 0

" -----------------------------------------------------------------------------
" SETTINGS - plasticboy/vim-markdown
" -----------------------------------------------------------------------------
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_new_list_item_indent = 2

" -----------------------------------------------------------------------------
" SETTINGS - suan/vim-instant-markdown
" -----------------------------------------------------------------------------
let g:instant_markdown_slow = 1

" -----------------------------------------------------------------------------
" SETTINGS - rizzatti/dash.vim
" -----------------------------------------------------------------------------
let g:dash_map = {
      \ 'javascript': ['react']
      \}

" -----------------------------------------------------------------------------
" SETTINGS - itchyny/calendar.vim
" -----------------------------------------------------------------------------
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1

" -----------------------------------------------------------------------------
" SETTINGS - Eclim
" -----------------------------------------------------------------------------
let g:EclimFileTypeValidate = 0

" -----------------------------------------------------------------------------
" SETTINGS - Rooter
" -----------------------------------------------------------------------------
let g:rooter_autocmd_patterns = '*.java,*.js,*.css,*.xml,*.properties,*.vm'
let g:rooter_patterns = ['.git', '.git/', 'package.json', '*.pom']
let g:rooter_use_lcd = 1
let g:rooter_change_directory_for_non_project_files = 1


" -----------------------------------------------------------------------------
" SETTINGS - vimlint
" -----------------------------------------------------------------------------
let g:vimlint#config = {}
let g:vimlint#config.EVL205=1

" -----------------------------------------------------------------------------
" SETTINGS - php-indent
" -----------------------------------------------------------------------------
let g:PHP_outdentSLComments = 1
let g:PHP_default_indenting = 1
let g:PHP_BracesAtCodeLevel = 1

" -----------------------------------------------------------------------------
" SETTINGS - nathanaelkane/vim-indent-guides
" -----------------------------------------------------------------------------
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'vimfiler', 'startify']
let g:indent_guides_color_change_percent = 15

" -----------------------------------------------------------------------------
" SETTINGS - closetag.vim
" -----------------------------------------------------------------------------
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.xtpl,*.art,*.js,*.xml'

" -----------------------------------------------------------------------------
" SETTINGS - YouCompleteMe
" -----------------------------------------------------------------------------
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

let g:ycm_filetype_blacklist = {
      \ 'tagbar' : 1,
      \ 'qf' : 1,
      \ 'notes' : 1,
      \ 'markdown' : 1,
      \ 'unite' : 1,
      \ 'text' : 1,
      \ 'vimwiki' : 1,
      \ 'gitcommit' : 1,
      \ 'startify': 1,
      \}

"let s:css_trigger = ['  ', ': ']
let s:css_trigger = [': ']
let g:ycm_semantic_triggers = {
  \ 'css':  s:css_trigger,
  \ 'less': s:css_trigger,
  \ 'sass': s:css_trigger
  \}



"let g:ycm_key_list_select_completion=['<C-TAB>', '<DOWN>']
"let g:ycm_key_list_previous_completion=['<C-S-TAB>', '<UP>']

" -----------------------------------------------------------------------------
" SETTINGS - ternjs/tern_for_vim
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" SETTINGS - ervandew/supertab
" -----------------------------------------------------------------------------
"let g:SuperTabDefaultCompletionType='<C-TAB>'

" -----------------------------------------------------------------------------
" SETTINGS - javacomplete2
" -----------------------------------------------------------------------------
autocmd FileType java setlocal omnifunc=javacomplete#Complete

nmap <S-TAB> <Plug>(JavaComplete-Imports-Add)
imap <S-TAB> <Plug>(JavaComplete-Imports-Add)
" Alt-I
nmap ˆ <Plug>(JavaComplete-Imports-AddMissing)
imap ˆ <Plug>(JavaComplete-Imports-AddMissing)
" Alt-O
nmap ø <Plug>(JavaComplete-Imports-RemoveUnused)
imap ø <Plug>(JavaComplete-Imports-RemoveUnused)

" -----------------------------------------------------------------------------
" SETTINGS - emmet-vim
" -----------------------------------------------------------------------------
let g:user_emmet_install_global = 0
let g:user_emmet_expandabbr_key = '<C-E>'
let g:user_emmet_settings = {
\  'javascript.jsx': {
\    'extends': 'jsx',
\  },
\  'javascript': {
\    'extends': 'jsx',
\  },
\}
"let g:user_emmet_leader_key='<C-Z>'

autocmd FileType html,css,javascript,markdown EmmetInstall

" -----------------------------------------------------------------------------
" SETTINGS - vim-jsx
" -----------------------------------------------------------------------------
let g:jsx_ext_required = 0      " Allow JSX in normal JS files


" -----------------------------------------------------------------------------
" SETTINGS - vim-jsx
" -----------------------------------------------------------------------------
let g:rooter_patterns = ['Rakefile', '.git/']

" -----------------------------------------------------------------------------
" SETTINGS - SirVer/ultisnips
" -----------------------------------------------------------------------------
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsEnableSnipMate       = 0
let g:UltiSnipsSnippetsDir          = $HOME.'/.vim/UltiSnips'

let g:UltiSnipsExpandTrigger        = '<S-ENTER>'
let g:UltiSnipsListSnippets         = '<C-TAB'
let g:UltiSnipsJumpForwardTrigger   = '<C-K>'
let g:UltiSnipsJumpBackwardTrigger  = '<C-J>'

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" -----------------------------------------------------------------------------
" SETTINGS - winresizer
" -----------------------------------------------------------------------------
let g:winresizer_gui_enable=1

" -----------------------------------------------------------------------------
" SETTINGS - colorscheme-switcher
" -----------------------------------------------------------------------------
let g:colorscheme_switcher_define_mappings=0

" -----------------------------------------------------------------------------
" SETTINGS - altercation/vim-colors-solarized
" -----------------------------------------------------------------------------
let g:solarized_visibility="hight"


" -----------------------------------------------------------------------------
" SETTINGS - vimshell
" -----------------------------------------------------------------------------
let g:vimshell_editor_command = '/usr/local/Cellar/macvim/HEAD/MacVim.app/Contents/MacOS/Vim'

" -----------------------------------------------------------------------------
" SETTINGS - myusuf3/numbers.vim
" -----------------------------------------------------------------------------
let g:numbers_exclude = ['unite', 'tagbar', 'startify', 'gundo', 'vimshell', 'w3m', 'nerdtree']

" -----------------------------------------------------------------------------
" FUNCTIONS
" -----------------------------------------------------------------------------

if !exists('*ReloadVimrc')
  function! ReloadVimrc()
    source $MYVIMRC
    AirlineRefresh
  endfunction
endif


function! OpenProject(project_name)
  exec 'NERDTreeProjectLoad '.a:project_name
  call UseToolPanelAppearance()
  let g:project = a:project_name
  wincmd w
endfunction

function! ToggleNERDTree()
  if &filetype ==? 'nerdtree'
    NERDTreeToggle
  else
    NERDTreeCWD
    wincmd w
    NERDTreeFind
  endif
endfunction

" -----------------------------------------------------
" Toggle Vim Shell in a new tab
" -----------------------------------------------------
function! OpenVimShellTab()
  VimShellTab
  call UseToolPanelAppearance()
endfunction

" -----------------------------------------------------
" Toggle Vim Shell
" -----------------------------------------------------
function! ToggleVimShell()
  " If in the vimshell window, close it
  if &filetype ==? 'vimshell'
    VimShellClose
    wincmd w
    return
  endif

  " Remeber the current window
  let w:originWindow = bufnr('%')
  let l:hasShellWindow = 0
  wincmd w

  while !exists('w:originWindow')
    " Check whether exist VimShell window
    if &filetype ==? 'vimshell'
      let l:hasShellWindow = 1
    endif
    wincmd w
  endwhile

  " Reset
  unlet w:originWindow

  " Does not exist VimShell window, open a new one
  if l:hasShellWindow == 0
    botright 10split
  endif

  VimShell
  call UseToolPanelAppearance()

endfunction

function! SaveWorkspace()
  if &filetype != 'nerdtree'
    NERDTreeFocus
  endif

  NERDTreeProjectRm last_project
  NERDTreeProjectSave last_project
endfunction

function! UseToolPanelAppearance()
  setlocal nocursorcolumn
  setlocal nonumber
  setlocal nolist
endfunction

function! StartProfile()
 profile start ~/.vim/vim.profile
 profile func *
 profile file *
endfunction

function! EndProfile()
  profile pause
  noautocmd qall!
endfunction

" -----------------------------------------------------
" Function: select a jump in the list
" -----------------------------------------------------
function! GotoJump()
  jumps
  let l:jump = input("Please select your jump: ")
  if l:jump != ''
    let pattern = '\v\c^\+'
    if l:jump =~ pattern
      let l:jump = substitute(l:jump, pattern, '', 'g')
      execute "normal " . l:jump . "\<c-i>"
    else
      execute "normal " . l:jump . "\<c-o>"
    endif
  endif
endfunction

" -----------------------------------------------------------------------------
" INIT
" -----------------------------------------------------------------------------
" Avoid redundantly setting some configs
let g:hasLoadVimrc = 1

" Load private vimrc
function! ExistFile(path)
  return !empty(glob(a:path))
endfunction

function! TrySource(path)
  if ExistFile(a:path)
    execute 'source '.fnameescape(a:path)
  endif
endfunction

call TrySource(g:vimrc_private)

if exists('g:loaded_webdevicons') && exists('g:loaded_nerd_tree')
  call webdevicons#refresh()
endif

