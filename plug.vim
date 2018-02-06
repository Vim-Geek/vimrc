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

let g:plug_options = {
  \ 'nerdtree': { 'on': ['NERDTreeToggle', 'NERDTreeCWD', 'NERDTreeFind'] },
\}

function g:plug_options.filetype(...)
  let filetype = a:1
  let options = copy(a:0 == 2 ? a:2 : {})
  let options.for = filetype
  return options
endfunction


call plug#begin('~/.vim/plugged')

"--------------
" Scripting
"--------------

"Plug 'google/vim-maktaba'
"Plug 'google/vim-glaive'

"Plug 'vim-jp/vital.vim'
"Plug 'haya14busa/underscore.vim'

Plug 'tpope/vim-dispatch'
Plug 'mattn/webapi-vim'
Plug 'skywind3000/asyncrun.vim'

"----------------------
" Programming Languages
"----------------------
"Plug 'metakirby5/codi.vim'

" JavaScript
"Plug 'mxw/vim-jsx'
"Plug 'isRuslan/vim-es6'
"Plug 'kchmck/vim-coffee-script'
"Plug 'othree/javascript-libraries-syntax.vim'
Plug 'ruanyl/vim-fixmyjs', g:plug_options.filetype(['javascript', 'typescript'])
Plug 'leafgarland/typescript-vim', g:plug_options.filetype('typescript')
Plug 'othree/yajs.vim', g:plug_options.filetype('javascript')
Plug 'othree/es.next.syntax.vim', g:plug_options.filetype('javascript')
Plug 'maksimr/vim-jsbeautify', g:plug_options.filetype('javascript', { 'do': 'git submodule update --init --recursive' })
Plug 'pangloss/vim-javascript', g:plug_options.filetype('javascript')
Plug 'posva/vim-vue', g:plug_options.filetype('javascript')
Plug 'heavenshell/vim-jsdoc', g:plug_options.filetype('javascript')
Plug 'galooshi/vim-import-js', g:plug_options.filetype('javascript')

" Node.js
Plug 'moll/vim-node', g:plug_options.filetype('javascript')
Plug 'sidorares/node-vim-debugger', g:plug_options.filetype('javascript')

" JSON
Plug 'elzr/vim-json', g:plug_options.filetype('json')

" GraphQL
Plug 'jparise/vim-graphql'

" Dockerfile
Plug 'ekalinin/Dockerfile.vim'

" Go
Plug 'fatih/vim-go', g:plug_options.filetype('go', { 'do': ':GoInstallBinaries' })
Plug 'vim-jp/vim-go-extra', g:plug_options.filetype('go')

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
Plug 'othree/html5.vim', g:plug_options.filetype('html')
"Plug 'tpope/vim-haml'
"Plug 'briancollins/vim-jst'
Plug 'Valloric/MatchTagAlways', g:plug_options.filetype(['html', 'javascript'])
Plug 'digitaltoad/vim-pug', g:plug_options.filetype('pug')

" CSS
Plug 'hail2u/vim-css3-syntax', g:plug_options.filetype(['css', 'less', 'scss'])
Plug 'cakebaker/scss-syntax.vim', g:plug_options.filetype('scss')
Plug 'groenewege/vim-less', g:plug_options.filetype('less')
Plug 'ap/vim-css-color', g:plug_options.filetype(['css', 'less', 'scss'])
"Plug 'lccf/vim-coloresque', g:plug_options.filetype(['css', 'less', 'scss'])

" Plug 'nono/jquery.vim'
"Plug 'wavded/vim-stylus'

" Markdown
Plug 'jszakmeister/markdown2ctags', g:plug_options.filetype('markdown')
Plug 'plasticboy/vim-markdown', g:plug_options.filetype('markdown')
"Plug 'suan/vim-instant-markdown', g:plug_options.filetype('markdown')
Plug 'godlygeek/tabular'
"Plug 'kannokanno/previm'

" Ruby

" Scheme
" Plug 'kien/rainbow_parentheses.vim'

" CSV
Plug 'chrisbra/csv.vim', g:plug_options.filetype('csv')

" LaTeX
"Plug 'lervag/vimtex'

" Python
Plug 'python-mode/python-mode'

" Vim
Plug 'syngan/vim-vimlint', g:plug_options.filetype('vim')
Plug 'ynkdir/vim-vimlparser', g:plug_options.filetype('vim')

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
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }

"Plug 'MarcWeber/vim-addon-mw-utils'
"Plug 'tomtom/tlib_vim'
"Plug 'garbas/vim-snipmate'

Plug 'SirVer/ultisnips'
  \| Plug 'honza/vim-snippets'

Plug 'gisphm/vim-gitignore', g:plug_options.filetype('gitignore')

"Plug 'dansomething/vim-eclim'
Plug 'artur-shaik/vim-javacomplete2', g:plug_options.filetype('java')

Plug 'tpope/vim-endwise'

"-----------------
" Fast navigation
"-----------------
" window
Plug 't9md/vim-choosewin'
Plug 'simeji/winresizer'

" Plug 'tsaleh/vim-matchit'
Plug 'easymotion/vim-easymotion'
"Plug 'bkad/CamelCaseMotion'

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
Plug 'AndrewRadev/splitjoin.vim'

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
"Plug 'TaskList.vim'

"Plug 'andreshazard/vim-logreview'
"Plug 'dzeban/vim-log-syntax'

" Project Management
"Plug 'wakatime/vim-wakatime'

" Explorer: File/Project
Plug 'tpope/vim-vinegar'

" Edit
Plug 'fidian/hexmode'

Plug 'chrisbra/vim-autoread'

" Utility
"Plug 'vitalk/vim-simple-todo'

" Tool Helper
Plug 'KabbAmine/gulp-vim'
Plug 'rizzatti/dash.vim'
Plug 'mattn/vim-terminal'

" View
Plug 'myusuf3/numbers.vim'

" Code
"Plug 'google/vim-syncopate'

" Format
"Plug 'google/vim-codefmt'
Plug 'Chiel92/vim-autoformat'

" Syntax
Plug 'w0rp/ale'

" Search
Plug 'mileszs/ack.vim'
Plug 'dyng/ctrlsf.vim'


Plug 'nathanaelkane/vim-indent-guides'

"Plug 'scrooloose/syntastic', { 'do': 'sudo npm install -g eslint babel-eslint eslint-plugin-react' }
"Plug 'thinca/vim-quickrun'
"Plug 'osyo-manga/shabadou.vim'
"Plug 'jceb/vim-hier'
"Plug 'dannyob/quickfixstatus'
"Plug 'osyo-manga/vim-watchdogs'

" Explorer: Buffer
Plug 'jlanzarotta/bufexplorer'
"Plug 'bling/vim-bufferline'

" Explorer: Tag
Plug 'szw/vim-tags'
Plug 'majutsushi/tagbar'

" Explorer: NERDTree
Plug 'scrooloose/nerdtree', g:plug_options.nerdtree
  \| Plug 'ivalkeen/nerdtree-execute', g:plug_options.nerdtree
  \| Plug 'tyok/nerdtree-ack', g:plug_options.nerdtree
  \| Plug 'Xuyuanp/nerdtree-git-plugin', g:plug_options.nerdtree

"Plug 'scrooloose/nerdtree-project-plugin'
"Plug 'tiagofumo/vim-nerdtree-syntax-highlight', g:plug_options.nerdtree

" VCS
Plug 'tpope/vim-fugitive'
  \| Plug 'low-ghost/nerdtree-fugitive', g:plug_options.nerdtree

"Plug 'tpope/vim-sensible'


Plug 'vim-airline/vim-airline'
  \| Plug 'vim-airline/vim-airline-themes'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'terryma/vim-expand-region'

Plug 'xolox/vim-misc'
"Plug 'xolox/vim-session'
Plug 'xolox/vim-easytags'
"Plug 'xolox/vim-notes'

Plug 'airblade/vim-rooter'

Plug 'editorconfig/editorconfig-vim'

"Plug 'wesleyche/SrcExpl'

" Plug 'Lokaltog/vim-powerline'
" Plug 'vim-scripts/mru.vim'
" Plug 'junegunn/goyo.vim'
" Plug 'amix/vim-zenroom2'
" Plug 'vim-scripts/session.vim--Odding'
"Plug 'vim-scripts/Conque-Shell'


Plug 'Shougo/vimproc.vim', { 'do': 'make' }
  \| Plug 'Shougo/vimshell.vim'
Plug 'Shougo/unite.vim'
"Plug 'Shougo/vimfiler.vim'

Plug 'edkolev/promptline.vim'

"-------------
" VCS
"-------------
Plug 'christoomey/vim-conflicted'
"Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-git'
Plug 'gregsexton/gitv'
Plug 'mhinz/vim-signify'

"Plug 'mattn/gist-vim'
Plug 'sjl/splice.vim'

"-------------
" Other Utils
" ------------
Plug 'itchyny/calendar.vim'

Plug 'yuratomo/w3m.vim'

"Plug 'Yggdroot/indentLine'
" Plug 'nvie/vim-togglemouse'
" Plug 'vim-scripts/Gist.vim'
" Plug 'vim-scripts/cmdline-completion'
" Plug 'vim-scripts/YankRing.vim'
" Plug 'vim-pandoc/vim-pandoc'
Plug 'tpope/vim-pastie'
" Plug 'ianva/vim-youdao-translater'
Plug 'ntpeters/vim-better-whitespace'

"Plug 'airblade/vim-helptab'

Plug 'mhinz/vim-startify'

" Color Scheme
"--------------
Plug 'xolox/vim-colorscheme-switcher'
"Plug 'flazz/vim-colorschemes'
Plug 'mbbill/desertEx'
"Plug 'dracula/vim'
Plug 'ryanoasis/vim-devicons'

"--------------
" vim-geek
"--------------
Plug 'vim-geek/largefile.vim'
Plug 'vim-geek/CamelCaseMotion'
Plug 'vim-geek/vim-nerdtree-syntax-highlight', g:plug_options.nerdtree
Plug 'vim-geek/javascript-libraries-syntax.vim', g:plug_options.filetype('javascript')
Plug 'vim-geek/vim-colors-solarized'

"--------------

" All of your Plugins must be added before the following line
call plug#end()            " required

"call glaive#Install()
