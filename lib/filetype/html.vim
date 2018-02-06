augroup filetype_html
    autocmd!
    autocmd FileType html call s:SetForHtml()
augroup END

function! s:SetForHtml()
  setlocal colorcolumn=121,201
  setlocal textwidth=200
endfunction
