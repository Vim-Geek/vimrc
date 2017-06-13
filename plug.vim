"
" Plug config
"
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

call plug#begin('~/.vim/plugged')

"--------------
" Scripting
"--------------
Plug 'vim-jp/vital.vim'
  \| Plug 'haya14busa/underscore.vim'

Plug 'tpope/vim-dispatch'
Plug 'mattn/webapi-vim'

"----------------------
" Programming Languages
"----------------------
" JavaScript
"Plug 'pangloss/vim-javascript'
"Plug 'mxw/vim-jsx'
"Plug 'isRuslan/vim-es6'
"Plug 'kchmck/vim-coffee-script'
"
Plug 'heavenshell/vim-jsdoc'
"Plug 'othree/javascript-libraries-syntax.vim'
Plug 'vim-geek/javascript-libraries-syntax.vim'
Plug 'othree/yajs.vim'
Plug 'othree/es.next.syntax.vim'
Plug 'maksimr/vim-jsbeautify', { 'do': 'git submodule update --init --recursive' }

" Node.js
Plug 'moll/vim-node'
Plug 'sidorares/node-vim-debugger'

" JSON
Plug 'elzr/vim-json'

" Go
"Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

" Lua
"Plug 'xolox/vim-lua-ftplugin'
"Plug 'xolox/vim-lua-inspect'

" Java

" Scala
"Plug 'derekwyatt/vim-scala'

" PHP
"Plug '2072/PHP-Indenting-for-VIm'

" Plug 'lepture/vim-jinja'
"Plug 'digitaltoad/vim-jade'

" Web
Plug 'othree/html5.vim'
Plug 'tpope/vim-haml'
Plug 'briancollins/vim-jst'
Plug 'Valloric/MatchTagAlways'
Plug 'digitaltoad/vim-pug'

" CSS
Plug 'hail2u/vim-css3-syntax'
Plug 'cakebaker/scss-syntax.vim'
Plug 'groenewege/vim-less'
Plug 'ap/vim-css-color'
Plug 'gorodinskiy/vim-coloresque'

" Plug 'nono/jquery.vim'
"Plug 'wavded/vim-stylus'

" Markdown
Plug 'jszakmeister/markdown2ctags'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
"Plug 'kannokanno/previm'
"Plug 'suan/vim-instant-markdown'

" Ruby

" Scheme
" Plug 'kien/rainbow_parentheses.vim'

" CSV
Plug 'chrisbra/csv.vim'

" Vim
Plug 'syngan/vim-vimlint'
Plug 'ynkdir/vim-vimlparser'

"------------------
" Code Completions
"------------------

Plug 'mattn/emmet-vim'

" Plug 'rizzatti/funcoo.vim'
function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.status == 'updated' || a:info.force
    !./install.py --clang-completer --gocode-completer --tern-completer
  endif
endfunction

Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'marijnh/tern_for_vim', { 'do': 'npm install' }

"Plug 'MarcWeber/vim-addon-mw-utils'
"Plug 'tomtom/tlib_vim'
"Plug 'garbas/vim-snipmate'

Plug 'SirVer/ultisnips'
  \| Plug 'honza/vim-snippets'

Plug 'gisphm/vim-gitignore'

"Plug 'dansomething/vim-eclim'
Plug 'artur-shaik/vim-javacomplete2'

Plug 'tpope/vim-endwise'

"-----------------
" Fast navigation
"-----------------
" window
Plug 't9md/vim-choosewin'
Plug 'simeji/winresizer'

" Plug 'tsaleh/vim-matchit'
Plug 'easymotion/vim-easymotion'
Plug 'bkad/CamelCaseMotion'

" Plug 'vim-scripts/ShowMarks'
" Plug 'vim-scripts/Marks-Browser'
" Plug 'spiiph/vim-space'
Plug 'tmhedberg/matchit'

Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'

Plug 'wellle/targets.vim'
Plug 'haya14busa/incsearch.vim'

"--------------
" Fast editing
"--------------
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'alvan/vim-closetag'
"Plug 'closetag.vim'
"Plug 'Raimondi/delimitMate'
"Plug 'AndrewRadev/splitjoin.vim'

Plug 'jiangmiao/auto-pairs'
" Plug 'sjl/gundo.vim'
" Plug 'kana/vim-smartinput'
" Plug 'yonchu/accelerated-smooth-scroll'
" Plug 'michaeljsmith/vim-indent-object'
" Plug 'vim-scripts/argtextobj.vim'
Plug 'terryma/vim-multiple-cursors'

"--------------
" IDE features
"--------------
"Plug 'mivok/vimtodo'
"Plug 'TaskList.vim'

Plug 'fidian/hexmode'

Plug 'myusuf3/numbers.vim'

Plug 'Chiel92/vim-autoformat'

Plug 'mileszs/ack.vim'
Plug 'dyng/ctrlsf.vim'

Plug 'KabbAmine/gulp-vim'

Plug 'nathanaelkane/vim-indent-guides'

Plug 'scrooloose/syntastic', { 'do': 'sudo npm install -g eslint babel-eslint eslint-plugin-react' }

"Plug 'thinca/vim-quickrun'
"Plug 'osyo-manga/shabadou.vim'
"Plug 'jceb/vim-hier'
"Plug 'dannyob/quickfixstatus'
"Plug 'osyo-manga/vim-watchdogs'

" NERDTree
Plug 'scrooloose/nerdtree'
  \| Plug 'scrooloose/nerdtree-project-plugin'
  \| Plug 'ivalkeen/nerdtree-execute'
  \| Plug 'tyok/nerdtree-ack'
  \| Plug 'Xuyuanp/nerdtree-git-plugin'

"Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'vim-geek/vim-nerdtree-syntax-highlight'

Plug 'tpope/vim-fugitive'
  \| Plug 'low-ghost/nerdtree-fugitive'

"Plug 'tpope/vim-sensible'


Plug 'szw/vim-tags'
Plug 'majutsushi/tagbar'

Plug 'vim-airline/vim-airline'
  \| Plug 'vim-airline/vim-airline-themes'

Plug 'jlanzarotta/bufexplorer'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'terryma/vim-expand-region'

Plug 'xolox/vim-misc'
"Plug 'xolox/vim-session'
Plug 'xolox/vim-easytags'
Plug 'xolox/vim-notes'

Plug 'airblade/vim-rooter'

Plug 'editorconfig/editorconfig-vim'

"Plug 'wesleyche/SrcExpl'

" Plug 'Lokaltog/vim-powerline'
" Plug 'vim-scripts/mru.vim'
" Plug 'junegunn/goyo.vim'
" Plug 'amix/vim-zenroom2'
" Plug 'vim-scripts/session.vim--Odding'
Plug 'rizzatti/dash.vim'
"Plug 'vim-scripts/Conque-Shell'

Plug 'mattn/vim-terminal'

Plug 'Shougo/vimproc.vim', { 'do': 'make' } 
  \| Plug 'Shougo/vimshell.vim'
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler.vim'

Plug 'edkolev/promptline.vim'

"-------------
" VCS
"-------------
Plug 'christoomey/vim-conflicted'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-git'
Plug 'gregsexton/gitv'

Plug 'mattn/gist-vim'
Plug 'sjl/splice.vim'

"Plug 'rdolgushin/gitignore.vim'

"-------------
" Other Utils
" ------------
Plug 'itchyny/calendar.vim'

Plug 'yuratomo/w3m.vim'

Plug 'Yggdroot/indentLine'
" Plug 'nvie/vim-togglemouse'
" Plug 'vim-scripts/Gist.vim'
" Plug 'vim-scripts/cmdline-completion'
" Plug 'vim-scripts/YankRing.vim'
" Plug 'vim-pandoc/vim-pandoc'
Plug 'tpope/vim-pastie'
" Plug 'ianva/vim-youdao-translater'
Plug 'ntpeters/vim-better-whitespace'

Plug 'airblade/vim-helptab'

Plug 'mhinz/vim-startify'


"--------------
" Color Scheme
"--------------
Plug 'xolox/vim-colorscheme-switcher'

"Plug 'flazz/vim-colorschemes'

Plug 'mbbill/desertEx'

Plug 'altercation/vim-colors-solarized'

Plug 'ryanoasis/vim-devicons'


" All of your Plugins must be added before the following line
call plug#end()            " required
