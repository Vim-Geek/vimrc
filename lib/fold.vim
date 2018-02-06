function! MoveAndFold(dir)
  let pos = getpos('.')[1]
  let nxt = l:pos + a:dir
  let src = foldlevel(l:pos)
  let dst = foldlevel(l:nxt)

  if l:src < l:dst
    exec l:nxt . "foldopen"
  elseif l:src > l:dst
    exec l:pos . "foldclose"
  endif
  exec ":" . l:nxt
endfunction

"nnoremap j :call MoveAndFold(1)<cr>
"nnoremap k :call MoveAndFold(-1)<cr>
