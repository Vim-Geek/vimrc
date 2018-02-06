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
autocmd FileType tagbar call s:Keymap.mapNormalCommands('j', 'j^')
autocmd FileType tagbar call s:Keymap.mapNormalCommands('k', 'k^')
autocmd FileType tagbar call s:Keymap.mapNormalCommands('<esc>', ':wincmd h')
autocmd FileType tagbar nnoremap <silent> <buffer> <esc>:wincmd h<cr>
autocmd FileType tagbar call UseToolPanelAppearance()

