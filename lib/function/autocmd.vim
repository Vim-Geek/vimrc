"Helper: Autocmd

let s:Autocmd = {}
let g:VIMRC.Autocmd = s:Autocmd

let s:Utils = g:VIMRC.Utils
let s:filetypes = {}

"FUNCTION: Autocmd.filetype(file_type, func){{{1
function! s:Autocmd.filetype(file_type, func)
  echom l:file_type
  let l:filetype = get(s:filetypes, a:file_type, [])
  s:filetypes[a:file_type] = add(l:filetype, func)
endfunction
"}}}

function! s:test()
  echom 'test'
endfunction


"s:Autocmd.filetype('vim', s:test)

function! s:run()
  echom start
endfunction

augroup autocmd
  autocmd!
  autocmd VimEnter call s:run()
augroup END

