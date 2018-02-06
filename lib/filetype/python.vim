augroup filetype_python
    autocmd!
    autocmd FileType python call s:SetForPython()
augroup END

function! s:SetForPython()
  setlocal shiftwidth=4
  setlocal tabstop=4
endfunction
