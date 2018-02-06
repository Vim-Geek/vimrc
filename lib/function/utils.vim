" Utility Functions

if !exists('g:VIMRC')
  let g:VIMRC = {}
endif

let s:Utils = {}
let g:VIMRC.Utils = s:Utils

"FUNCTION: Utils.Debug(){{{1
function! s:Utils.Debug(...)
  for var in a:000
    echom var
  endfor
endfunction
"}}}

"FUNCTION: Utils.HelpTab(){{{1
function! s:Utils.HelpTab()
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
"}}}


"FUNCTION: Utils.EditInVSplit(file_name){{{1
function! s:Utils.EditInVSplit(file_name)
  " TODO: how to check the buffer is totally new?
  if &filetype ==? '' && &buftype ==? ''
    exec 'edit '.a:file_name
  else
    exec 'botright vsplit '.a:file_name
  endif
endfunction
"}}}

" vim: set fdm=marker :
