let s:Keymap = g:VIMRC.Keymap

let g:NERDTreeAutoCenter          = 1
let g:NERDTreeAutoCenterThreshold = 8
let g:NERDTreeBookmarksFile       = $HOME.'/.vim/NERDTreeBookmarks'
let g:NERDTreeChDirMode           = 2
let g:NERDTreeHighlightCursorline = 1
let g:NERDTreeWinSize             = 40
let g:NERDTreeShowHidden          = 1
let g:NERDTreeShowLineNumbers     = 0
let g:NERDTreeShowBookmarks       = 1
let g:NERDTreeIgnore = [
  \ '_.*@.*\..*\..*@.*$[[dir]]',
  \ '\..*\..*\..*@.*$[[dir]]',
  \ '[._]sw.*$[[file]]',
  \ '.tags$[[file]]',
  \ '.DS_Store[[file]]',
  \ '.view.art.js',
  \ '.git$[[dir]]',
  \ 'target$[[dir]]',
\]

" NERDTree
"nnoremap <silent> <F3> :call ToggleNERDTree()<cr>
call s:Keymap.mapNormalCommands('<F3>', ':call ToggleNERDTree()<cr>', { 'normal': 0 })

let s:map_options = { 'buffer': 1, 'nore': 1, 'normal': 0 }
let s:map_options_normal = { 'buffer': 1, 'nore': 1, 'normal': 1 }

augroup NERDTree
  autocmd!
  autocmd FileType nerdtree call s:Keymap.mapNormalCommands('h', '<nop>', s:map_options)
  autocmd FileType nerdtree call s:Keymap.mapNormalCommands('l', '<nop>', s:map_options)
  autocmd FileType nerdtree call s:Keymap.mapNormalCommands('O', '<nop>', s:map_options)
  autocmd FileType nerdtree call s:Keymap.mapNormalCommands('j', 'j0', s:map_options_normal)
  autocmd FileType nerdtree call s:Keymap.mapNormalCommands('k', 'k0', s:map_options_normal)
  autocmd FileType nerdtree call s:Keymap.mapNormalCommands('gg', 'ggjjj', s:map_options)
  autocmd FileType nerdtree call s:Keymap.mapNormalCommands('<esc>', ':windcmd w <cr>', s:map_options)
  autocmd FileType nerdtree call s:Keymap.mapNormalCommands('<C-B>', ':Bookmark<space>', s:map_options)
  autocmd FileType nerdtree call UseToolPanelAppearance()
augroup END
