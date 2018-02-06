let s:Keymap = g:VIMRC.Keymap

let g:notes_directories = ['~/Documents/Notes']
let g:notes_suffix = '.txt'
let g:notes_title_sync = 'rename_file'
let g:notes_word_boundaries = 1

call s:Keymap.mapNormalCommands('<F7>', ':Note<cr>')
call s:Keymap.mapVisualCommands('<F7>', ':TabNoteFromSelectedText<cr>')
