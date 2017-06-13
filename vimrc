" -----------------------------------------------------------------------------
" phoenix's vimrc file
" -----------------------------------------------------------------------------

let g:vimrc_private = '~/.vimrc.private'
let g:DEBUG = 0

function! Debug(...)
  if !g:DEBUG
    return
  endif

  for var in a:000
    echom var
  endfor
endfunction

" script encoding
scriptencoding utf-8

set nocompatible                                           " cp   close vi-compatible
set updatetime=500

" mapleader
let g:mapleader = ';'

" Plug
"source ~/.vim/dein.vim
"source ~/.vim/vundle.vim
source ~/.vim/plug.vim

" Scripting
"let V = vital#of('vital')
"let _ = V.import('Underscore').import()

" -----------------------------------------------------------------------------
" path
" -----------------------------------------------------------------------------
set noautochdir                                              " acd  change the current working driectory
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*

" -----------------------------------------------------------------------------
" APPEARANCE
" -----------------------------------------------------------------------------
set cmdheight=2                                            " ch   set command height
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
set wrap                                                   " wrap wrap text

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
set autoindent                                             " ai   Copy indent from current line when start a new line
set cindent                                                " cin  C indent
set expandtab                                              " et   Use the appropriate number of spaces to insert a <Tab>
set shiftwidth=2                                           " sw   Number of spaces to use for each
set tabstop=2                                              " ts   Number of spaces that a <Tab> in the file counts for

set noautoread                                             " ar   automatically read file when changed
set noautowrite                                            " aw   automatically write file when changed
set history=50                                             " hi   command line history
set sidescroll=10                                          " ss   the minimal number of columns to scroll horizontally
set smarttab
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
colorscheme desertEx

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
function! s:HelpTab()
  if !(getcmdwintype() == ':' && col('.') <= 2)
    return 'h'
  endif

  let helptabnr = 0
  for i in range(tabpagenr('$'))
    let tabnr = i + 1
    for bufnr in tabpagebuflist(tabnr)
      if getbufvar(bufnr, "&ft") == 'help'
        let helptabnr = tabnr
        break
      endif
    endfor
  endfor

  echo helptabnr

  if helptabnr
    if tabpagenr() == helptabnr
      return 'h'
    else
      return 'tabnext '.helptabnr.' | h'
    endif
  else
    return 'tab h'
  endif
endfunction

augroup cmdwin
  autocmd!
  let s:cmdwin_map_options = { 'buffer': 1, 'normal': 0, 'insert': 0 }
  autocmd CmdwinEnter * call s:mapInsertCommands('<esc>', '<c-c><c-c>', s:cmdwin_map_options)
  autocmd CmdwinEnter * call s:mapNormalCommands('<esc>', '<c-c><c-c>', s:cmdwin_map_options)
  autocmd CmdwinEnter * call s:mapNormalCommands('q', '<c-c><c-c>', s:cmdwin_map_options)
  autocmd CmdwinEnter * inoreabbrev <expr> h <SID>HelpTab()
  " disable vim-helptab
  autocmd CmdwinEnter * cnoreabbrev h h
augroup END

augroup javascript
  autocmd!
  autocmd FileType javascript call s:autocmdJavaScript()
augroup END

function! s:autocmdJavaScript()
  nnoremap <buffer> <D-d> :TernDef<cr>
  nnoremap <buffer> <D-r> :TernRename<cr>
endfunction

augroup file_type
  autocmd!
  autocmd BufNewFile,BufRead *.xtpl,*.art  set filetype=html
  autocmd BufNewFile,BufRead *.es6         set filetype=javascript
  autocmd BufNewFile,BufRead .babelrc,.eslintrc
                                         \ set filetype=json
  autocmd BufNewFile,BufRead *.scss        set filetype=scss.css
  autocmd BufNewFile,BufRead .vimrc        set filetype=vim

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

  autocmd BufWritePost ~/.vim/abbreviations.vim source ~/.vim/abbreviations.vim

  " source Vundle.vim after save it
  "autocmd BufWritePost ~/.vim/vundle.vim source ~/.vim/vundle.vim

  " source plug.vim after save it
  autocmd BufWritePost ~/.vim/plug.vim source ~/.vim/plug.vim

  " source dein.vim after save it
  "autocmd BufWritePost ~/.vim/dein.vim source ~/.vim/dein.vim

  " Open NERDTree in new tabs and windows if no command line args set
  autocmd VimEnter *  if has('gui_running') | call OpenProject('last_project') | endif

  " Save project & session
  autocmd VimLeave *  if has('gui_running') | call SaveWorkspace() | endif

  " Save session
  "autocmd VimLeave * if (has('g:project')) | execute 'mksession ~/.session_'.g:project | endif

augroup END

" -----------------------------------------------------------------------------
" KEYMAP {{{1
" -----------------------------------------------------------------------------
" Editor Keymaps

function! s:execMapCommand(command)
  call Debug(a:command)
  execute a:command
endfunction


" -----------------------------------------------------
" Function: helper for mapping normal commands
" -----------------------------------------------------
function! s:isCommandLineCommand(command)
  return strpart(a:command, 0, 1) == ':'
endfunction

function! s:mapNormalCommands(...)
  let key = a:1
  let commands = a:2
  let options = a:0 == 3 ? a:3 : {}

  let buffer = get(options, 'buffer', 0) ? '<buffer> ' : ' '
  let silent = get(options, 'silent', !g:DEBUG) ? '<silent> ' : ' '
  let normal = !s:isCommandLineCommand(commands) && get(options, 'normal', 1)

  let mapCommand = "nnoremap ".silent.buffer.key." ".(normal ? ':execute "normal! '.commands.'"<cr>' : commands)

  call s:execMapCommand(mapCommand)
endfunction

" -----------------------------------------------------
" Function: helper for mapping insert commands
" -----------------------------------------------------
function! s:mapInsertCommands(...)
  let key = a:1
  let commands = a:2
  let options = a:0 == 3 ? a:3 : {}

  let buffer = get(options, 'buffer', 0) ? '<buffer> ' : ' '
  let silent = get(options, 'silent', !g:DEBUG) ? '<silent> ' : ' '
  let insert = get(options, 'insert', 1)
  let normal = get(options, 'normal', 1)

  let mapCommand = "inoremap ".silent.buffer.key." ".'<esc>'
    \.(normal ? ':execute "normal! '.commands.'"<cr>' : commands)
    \.(insert ? 'a' : '')

  call s:execMapCommand(mapCommand)
endfunction

" -----------------------------------------------------
" Function: helper for mapping visual and select  commands
" -----------------------------------------------------
function! s:mapVisualCommands(...)
  let key = a:1
  let commands = a:2
  let options = a:0 == 3 ? a:3 : {}

  let buffer = get(options, 'buffer', 0) ? '<buffer> ' : ' '
  let silent = get(options, 'silent', !g:DEBUG) ? '<silent> ' : ' '
  let normal = get(options, 'normal', 1)

  let mapCommand = "vnoremap ".silent.buffer.key." ".(normal ? ':execute "normal! '.commands.'"<cr>' : commands)

  call s:execMapCommand(mapCommand)
endfunction

" NORMAL ----------------------------------
" Exit
call s:mapNormalCommands('<leader>q', ':q<cr>')

" command line
call s:mapNormalCommands('/', 'q/i', { 'normal': 0 })
call s:mapNormalCommands(':', 'q:i', { 'normal': 0 })
call s:mapNormalCommands('?', 'q?i', { 'normal': 0 })


" select a jump in the list
nnoremap <silent> <leader>j :call GotoJump()<cr>

" visually select the word
call s:mapNormalCommands('<space>', 'viw')

" convert the current workd to uppercase
call s:mapNormalCommands('<leader>U', 'mqviwgU`q')
call s:mapInsertCommands('<c-u>', 'mqviwU`q')
" convert the current word to lowercase
call s:mapNormalCommands('<leader>u', 'mqviwgu`q')

" surround the world in backticks
call s:mapNormalCommands('<leader>`', 'mqviw<c-v><esc>a\`<c-v><esc>hbi\`<c-v><esc>lel`ql')
" surround the world in double quotes
call s:mapNormalCommands('<leader>"', 'mqviw<c-v><esc>a\"<c-v><esc>hbi\"<c-v><esc>lel`ql')
" surround the world in single quotes
call s:mapNormalCommands('<leader>''', 'mqviw<c-v><esc>a''<c-v><esc>hbi''<c-v><esc>lel`ql')
" surround the lines in braces
call s:mapNormalCommands('<leader>{', 'mqkA<c-v><space>{<c-v><esc>`qA<c-v><cr>}<c-v><esc>k=`q')
" append semicolon into the end of line
call s:mapNormalCommands('<leader>;;', 'mqA;<c-v><esc>`q')
" append comma into the end of line
call s:mapNormalCommands('<leader>;;', 'mqA;<c-v><esc>`q')
call s:mapNormalCommands('<leader>,', 'mqA,<c-v><esc>`q')

" delete the current line
inoremap <c-d> <esc>ddi

" ESC
inoremap jk <esc>
"inoremap <c-u> <esc>bvegUea

" VIEW ------------------------------------
" ESC
vnoremap jk <esc>
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
nnoremap <leader>ee :call EditInVSplit($MYVIMRC)<cr>
nnoremap <leader>ea :call EditInVSplit('~/.vim/abbreviations.vim')<cr>
nnoremap <leader>ss :call ReloadVimrc()<cr>

" Edit zshrc
nnoremap <leader>ez :call EditInVSplit('~/.zshrc')<cr>
nnoremap <leader>sz :source ~/.zshrc<cr>

" Edit Plug config
nnoremap <leader>ep :call EditInVSplit('~/.vim/plug.vim')<cr>

nnoremap <leader>m :w <BAR> !lessc % > %:t:r.css<cr><space>


" TODO:NERDCommenter
map <silent> <D-/> <plug>NERDCommenterToggle<cr>
map <silent> ÷ <plug>NERDCommenterToggle<cr>
imap <silent> <D-/> jk<plug>NERDCommenterToggle<cr>i

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
call s:mapNormalCommands('<D-1>', '1gt')
call s:mapInsertCommands('<D-1>', '1gt')
call s:mapNormalCommands('<D-2>', '2gt')
call s:mapInsertCommands('<D-2>', '2gt')
call s:mapNormalCommands('<D-3>', '3gt')
call s:mapInsertCommands('<D-3>', '3gt')
call s:mapNormalCommands('<D-4>', '4gt')
call s:mapInsertCommands('<D-4>', '4gt')
call s:mapNormalCommands('<D-5>', '5gt')
call s:mapInsertCommands('<D-5>', '5gt')
call s:mapNormalCommands('<D-6>', '6gt')
call s:mapInsertCommands('<D-6>', '6gt')
call s:mapNormalCommands('<D-7>', '7gt')
call s:mapInsertCommands('<D-7>', '7gt')
call s:mapNormalCommands('<D-8>', '8gt')
call s:mapInsertCommands('<D-8>', '8gt')
call s:mapNormalCommands('<D-9>', '9gt')
call s:mapInsertCommands('<D-9>', '9gt')

noremap <silent> <F9> :call ToggleVimShell()<cr>
noremap! <silent> <F9> <esc>:call ToggleVimShell()<cr>
nnoremap <silent> <S-F9> :call OpenVimShellTab()<cr>
noremap! <silent> <S-F9> <esc>:call OpenVimShellTab()<cr>
autocmd FileType vimshell nnoremap <buffer> i GA

" Format
noremap <F5> :Autoformat<CR>

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
call s:mapNormalCommands('<leader>n', ':lnext<cr>', { 'normal': 0 })
call s:mapNormalCommands('<leader>p', ':lprevious<cr>', { 'normal': 0 })

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
" SETTINGS - Shougo/vimfiler
" -----------------------------------------------------------------------------
let g:vimfiler_as_default_explorer = 1


" -----------------------------------------------------------------------------
" SETTINGS - xolox/vim-notes
" -----------------------------------------------------------------------------
let g:notes_directories = ['~/Documents/Notes']
let g:notes_suffix = '.txt'
let g:notes_title_sync = 'rename_file'
let g:notes_word_boundaries = 1

nnoremap <silent> <F7> :Note<cr>
vnoremap <silent> <F7> :TabNoteFromSelectedText<cr>


" -----------------------------------------------------------------------------
" SETTINGS - Ctrlp
" -----------------------------------------------------------------------------
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_cmd = 'CtrlPMRUFiles'
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](\.(git|hg|svn)|node_modules)$',
    \ 'file': '\v\.(DS_Store|dll|view\.art\.js)$',
    \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
    \ }
let g:ctrlp_match_window = 'min:1,max:20'
let g:ctrlp_reuse_split = 'netrw\|help\|quickfix\|NERD'
let g:ctrlp_show_hidden = 1
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']
"let g:ctrlp_types = ['mru', 'file']
let g:ctrlp_extensions = ['tag']

" -----------------------------------------------------------------------------
" SETTINGS - mileszs/ack.vim
" -----------------------------------------------------------------------------
let g:ack_autofold_results = 1
let g:ackhighlight = 1
let g:ack_use_dispatch = 1
let g:ack_default_options = ' -s -H --nocolor --nogroup --column'

" -----------------------------------------------------------------------------
" SETTINGS - xolox/vim-easytags
" -----------------------------------------------------------------------------
set tags=./tags
let g:easytags_dynamic_files = 1

" -----------------------------------------------------------------------------
" SETTINGS - majutsushi/tagbar
" -----------------------------------------------------------------------------
" Settings
let g:tagbar_autofocus = 1
let g:tagbar_case_insensitive = 1
let g:tagbar_width = 30

" Autocmd
autocmd FileType markdown,css nested :TagbarOpen

" JavaScript
let g:tagbar_type_javascript = {
    \ 'ctagsbin': 'jsctags',
    \ 'ctagsargs' : '-f -',
    \ 'kinds': [
        \ 'c:Class',
        \ 'n:Context',
        \ 'v:Variables',
        \ 'p:Property:0:1',
        \ 'f:Function:1:1',
        \ 'e:Event',
    \ ],
    \ 'kind2scope': {
        \ 'n': 'namespace',
        \ 'c': 'class'
    \ },
    \ 'scope2kind': {
      \ 'namespace': 'n'
    \ },
    \ 'sro': '.',
    \ 'replace': 1
\ }


" LESS
let g:tagbar_type_less = {
  \ 'ctagstyle': 'less',
  \ 'kinds' : [
      \ 'c:Class',
      \ 'i:ID',
      \ 't:Tag',
      \ 'm:Media'
  \ ]
\ }

" Markdown
let g:tagbar_type_markdown = {
    \ 'ctagstype': 'markdown',
    \ 'ctagsbin' : '~/.vim/plugged/markdown2ctags/markdown2ctags.py',
    \ 'ctagsargs' : '-f - --sort=yes',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '|',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
\ }

" Keymap
nnoremap <silent> <F8> :TagbarToggle<cr>
nnoremap <silent> <S-F8> :TagbarTogglePause<cr>
autocmd FileType tagbar nnoremap <silent> <buffer> h <nop>
autocmd FileType tagbar nnoremap <silent> <buffer> l <nop>
autocmd FileType tagbar call s:mapNormalCommands('j', 'j^')
autocmd FileType tagbar call s:mapNormalCommands('k', 'k^')
autocmd FileType tagbar call s:mapNormalCommands('<esc>', ':wincmd h')
autocmd FileType tagbar nnoremap <silent> <buffer> <esc> :wincmd h<cr>
autocmd FileType tagbar call UseToolPanelAppearance()

" -----------------------------------------------------------------------------
" SETTINGS - Taglist
" -----------------------------------------------------------------------------
"let g:Tlist_Use_Right_Window                    = 1
"let g:Tlist_File_Fold_Auto_Close                = 1
"let g:Tlist_Show_One_File                       = 1
"let g:Tlist_Sort_Type                           = 'name'
"let g:Tlist_GainFocus_On_ToggleOpen             = 1
"let g:Tlist_Exit_OnlyWindow                     = 1
"let g:Tlist_WinWidth                            = 40
"let g:Tlist_Ctags_Cmd                           = '/usr/local/Cellar/ctags/5.8_1/bin/ctags'

" -----------------------------------------------------------------------------
" SETTINGS - Startify
" -----------------------------------------------------------------------------
" Settings
autocmd User Startified setlocal cursorline
autocmd User Startified setlocal buftype=
"autocmd User Startified call UseToolPanelAppearance()

" Keymap
autocmd User Startified nmap <buffer> o <plug>(startify-open-buffers)
nnoremap <silent> <F4> :Startify<cr>


"let g:startify_list_order = ['files', 'dir', 'bookmarks', 'sessions', 'commands']
let g:startify_list_order = ['files', 'commands']
let g:startify_files_number = 20

let g:startify_custom_header = [
      \'',
      \'',
      \'           ██████╗ ██╗  ██╗ ██████╗ ███████╗███╗   ██╗██╗██╗  ██╗    ██╗  ██╗██╗   ██╗         ',
      \'           ██╔══██╗██║  ██║██╔═══██╗██╔════╝████╗  ██║██║╚██╗██╔╝    ╚██╗██╔╝██║   ██║         ',
      \'           ██████╔╝███████║██║   ██║█████╗  ██╔██╗ ██║██║ ╚███╔╝      ╚███╔╝ ██║   ██║         ',
      \'           ██╔═══╝ ██╔══██║██║   ██║██╔══╝  ██║╚██╗██║██║ ██╔██╗      ██╔██╗ ██║   ██║         ',
      \'           ██║     ██║  ██║╚██████╔╝███████╗██║ ╚████║██║██╔╝ ██╗    ██╔╝ ██╗╚██████╔╝         ',
      \'           ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝    ╚═╝  ╚═╝ ╚═════╝          ',
      \'',
      \''
      \]


" -----------------------------------------------------------------------------
" SETTINGS - BufExplorer
" -----------------------------------------------------------------------------
let g:bufExplorerShowNoName=1
let g:bufExplorerShowRssativePath=1
let g:bufExplorerSortBy='mru'
let g:bufExplorerShowRelativePath=1


" -----------------------------------------------------------------------------
" SETTINGS - Airline
" -----------------------------------------------------------------------------
set laststatus=2
set noshowmode
set linespace=0

let g:airline_powerline_fonts                    = 1
let g:airline_detect_modified                    = 1

let g:airline_theme                              = 'jellybeans'

" Extensions
let g:airline#extensions#tabline#enabled         = 1
let g:airline#extensions#tabline#show_buffers    = 1
let g:airline#extensions#tabline#show_tabs       = 1
let g:airline#extensions#tabline#exclude_preview = 1
let g:airline#extensions#tabline#tab_nr_type     = 1
let g:airline#extensions#tabline#show_tab_nr     = 1

let g:airline#extensions#branch#enabled          = 1
let g:airline#extensions#branch#format           = 2

let g:airline#extensions#eclim#enabled           = 1

let g:airline#extensions#syntastic#enabled       = 1

let g:airline#extensions#tagbar#enabled          = 1

let g:airline#extensions#csv#enabled             = 1

let g:airline#extensions#wordcount#enabled       = 1

let g:airline#extensions#whitespace#enabled      = 0

" -----------------------------------------------------------------------------
" SETTINGS - NERDTree
" -----------------------------------------------------------------------------
let g:NERDTreeAutoCenter          = 1
let g:NERDTreeAutoCenterThreshold = 8
let g:NERDTreeBookmarksFile       = $HOME.'/.vim/NERDTreeBookmarks'
let g:NERDTreeChDirMode           = 2
let g:NERDTreeHighlightCursorline = 1
let g:NERDTreeIgnore              = ['*.sw*$','\..*\..*\..*@.*$[[dir]]', '.tags$[[file]]', '.DS_Store', '.view.art.js', '.git$[[dir]]', 'target$[[dir]]']
let g:NERDTreeWinSize             = 40
let g:NERDTreeShowHidden          = 1
let g:NERDTreeShowLineNumbers     = 0
let g:NERDTreeShowBookmarks       = 1

" NERDTree
nnoremap <silent> <F3> :call ToggleNERDTree()<cr>

augroup NERDTree
  autocmd FileType nerdtree nnoremap <silent> <buffer> h <nop>
  autocmd FileType nerdtree nnoremap <silent> <buffer> l <nop>
  autocmd FileType nerdtree nnoremap <silent> <buffer> O <nop>
  autocmd FileType nerdtree nnoremap <silent> <buffer> j :execute "normal! j0"<cr>
  autocmd FileType nerdtree nnoremap <silent> <buffer> k :execute "normal! k0"<cr>
  autocmd FileType nerdtree nnoremap <silent> <buffer> <esc> :wincmd w<cr>
  autocmd FileType nerdtree nnoremap <buffer> <C-B> :Bookmark<space>
  autocmd FileType nerdtree call UseToolPanelAppearance()
augroup END

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
"set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete:h16
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
let s:blank = ''

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
  autocmd FileType javascript,java,html,art,xtpl,css,less,sass,php,json,sh,zsh,snippets autocmd BufWritePre <buffer> StripWhitespace
augroup END


" -----------------------------------------------------------------------------
" SETTINGS - osyo-manga/vim-watchdogs
" -----------------------------------------------------------------------------
let g:watchdogs_check_BufWritePost_enable = 1

" -----------------------------------------------------------------------------
" SETTINGS - Syntastic
" -----------------------------------------------------------------------------
" Syntastic
"map <F6> :SyntasticCheck<cr>
call s:mapNormalCommands('<F6>', ':SyntasticCheck<cr>')

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

let g:syntastic_typescript_checkers=['eslint', 'tslint']

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
  autocmd FileType javascript call s:mapNormalCommands('<c-f>', ':call JsBeautify()<cr>', s:jsbeautify_map_options)
  autocmd FileType json call s:mapNormalCommands('<c-f>', ':call JsonBeautify()<cr>', s:jsbeautify_map_options)
  autocmd FileType jsx call s:mapNormalCommands('<c-f>', ':call JsxBeautify()<cr>', s:jsbeautify_map_options)
  autocmd FileType html call s:mapNormalCommands('<c-f>', ':call HtmlBeautify()<cr>', s:jsbeautify_map_options)
  autocmd FileType css call s:mapNormalCommands('<c-f>', ':call CSSBeautify()<cr>', s:jsbeautify_map_options)

  autocmd FileType javascript call s:mapVisualCommands('<c-f>', ':call RangeJsBeautify()<cr>', s:jsbeautify_map_options)
  autocmd FileType json call s:mapVisualCommands('<c-f>', ':call RangeJsonBeautify()<cr>', s:jsbeautify_map_options)
  autocmd FileType jsx call s:mapVisualCommands('<c-f>', ':call RangeJsxBeautify()<cr>', s:jsbeautify_map_options);
  autocmd FileType html call s:mapVisualCommands('<c-f>', ':call RangeHtmlBeautify()<cr>', s:jsbeautify_map_options)
  autocmd FileType css call s:mapVisualCommands('<c-f>', ':call RangeCSSBeautify()<cr>', s:jsbeautify_map_options)
augroup END

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
" SETTINGS - closetag.vim
" -----------------------------------------------------------------------------
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.xtpl,*.art,*.js,*.xml'

" -----------------------------------------------------------------------------
" SETTINGS - YouCompleteMe
" -----------------------------------------------------------------------------
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
let g:user_emmet_expandabbr_key = '<D-e>'
"let g:user_emmet_leader_key='<C-Z>'

autocmd FileType html,css,javascript,markdown EmmetInstall

" -----------------------------------------------------------------------------
" SETTINGS - vim-jsx
" -----------------------------------------------------------------------------
let g:jsx_ext_required = 0      " Allow JSX in normal JS files



" -----------------------------------------------------------------------------
" SETTINGS - SirVer/ultisnips
" -----------------------------------------------------------------------------
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsEnableSnipMate       = 0
let g:UltiSnipsSnippetsDir          = $HOME.'/.vim/UltiSnips'

let g:UltiSnipsExpandTrigger        = '<S-ENTER>'
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
function! EditInVSplit(file_name)
  " TODO: how to check the buffer is totally new?
  if &filetype ==? '' && &buftype ==? ''
    exec 'edit '.a:file_name
  else
    exec 'botright vsplit '.a:file_name
  endif
endfunction


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
 profile start ~/.vim/profile.log
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
      execute "normal " .  l:jump . "\<c-i>"
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

" Load abbreviations
source ~/.vim/abbreviations.vim

" Load disabled mappings
source ~/.vim/nop.vim

" Load private vimrc
function! ExistFile(path)
  return !empty(glob(a:path))
endfunction

function! TrySource(path)
  if ExistFile(a:path)
    source a:path
  endif
endfunction

"call TrySource(g:vimrc_private)

if exists("g:loaded_webdevicons")
  call webdevicons#refresh()
endif
