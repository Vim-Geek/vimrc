"Helper: Keymap

if !exists('g:VIMRC')
  let g:VIMRC = {}
endif

let s:KeymapFunctions = {}
let g:VIMRC.Keymap = s:KeymapFunctions
let s:Utils = g:VIMRC.Utils

"FUNCTION: s:isCommandLineCommand(){{{1
function! s:isCommandLineCommand(command)
  return strpart(a:command, 0, 1) == ':'
endfunction
"}}}

"FUNCTION: s:keymap(){{{1
function! s:keymap(...)
  let key = a:1
  let commands = a:2
  let MapGenerator = function(a:3)
  let options = a:0 == 4 ? a:4 : {}
  let debug = get(options, 'debug', g:DEBUG)

  let commandFragment = {
        \ 'nore': get(options, 'nore', 1) ? 'nore' : '',
        \ 'silent': get(options, 'silent', !g:DEBUG) ? '<silent> ' : '',
        \ 'buffer': get(options, 'buffer', 0) ? '<buffer> ' : '',
        \}

  let commands = !s:isCommandLineCommand(commands) && get(options, 'normal', 0)
        \               ? ':exec "normal! '.commands.'"<cr>'
        \               : commands

  let mapCommand = MapGenerator(key, commands, commandFragment, options)

  if debug
    call s:Utils.Debug(mapCommand)
  endif

  exec mapCommand
endfunction
"}}}

"FUNCTION: Keymap.mapNormalCommands(key, commands, options){{{1
function! s:KeymapFunctions.mapNormalCommands(...)
  let key = a:1
  let commands = a:2
  let options = a:0 == 3 ? a:3 : {}
  call s:keymap(key, commands, 's:normalMap', options)
endfunction

function! s:normalMap(key, commands, commandFragment, options)
  let nore = a:commandFragment.nore
  let silent = a:commandFragment.silent
  let buffer = a:commandFragment.buffer
  return 'n'.nore.'map '.silent.buffer.a:key.' '.a:commands
endfunction
"}}}

"FUNCTION: Keymap.mapInsertCommands(key, commands, options){{{1
function! s:KeymapFunctions.mapInsertCommands(...)
  let key = a:1
  let commands = a:2
  let options = a:0 == 3 ? a:3 : { 'normal': 0 }
  call s:keymap(key, commands, 's:insertMap', options)
endfunction

function! s:insertMap(key, commands, commandFragment, options)
  let nore = a:commandFragment.nore
  let silent = a:commandFragment.silent
  let buffer = a:commandFragment.buffer
  let insert = get(a:options, 'insert', 1) ? 'a' : ''
  return 'i'.nore.'map '.silent.buffer.a:key.' '.a:commands.insert
endfunction
"}}}

"FUNCTION: Keymap.mapVisualCommands(key, commands, options){{{1

function! s:KeymapFunctions.mapVisualCommands(...)
  let key = a:1
  let commands = a:2
  let options = a:0 == 3 ? a:3 : {}
  call s:keymap(key, commands, 's:visualMap', options)
endfunction

function! s:visualMap(key, commands, commandFragment, options)
  let nore = a:commandFragment.nore
  let silent = a:commandFragment.silent
  let buffer = a:commandFragment.buffer
  return 'v'.nore.'map '.silent.buffer.a:key.' '.a:commands
endfunction
"}}}

" vim: set fdm=marker :

