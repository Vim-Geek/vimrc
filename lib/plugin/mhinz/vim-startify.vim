let s:Keymap = g:VIMRC.Keymap
let s:Utils = g:VIMRC.Utils

let s:map_options = { 'nore': 0, 'buffer': 1, 'normal': 0 }
augroup startify
  autocmd!
  autocmd User Startified setlocal cursorline
  autocmd User Startified setlocal buftype=
  autocmd User Startified call s:Keymap.mapNormalCommands('o', '<plug>(startify-open-buffers)', s:map_options)
augroup END

" Keymap
call s:Keymap.mapNormalCommands('<F4>', ':Startify<cr>')

"autocmd User Startified call UseToolPanelAppearance()

"let g:startify_list_order = ['files', 'dir', 'bookmarks', 'sessions', 'commands']
let g:startify_list_order = ['files', 'commands']
let g:startify_files_number = 20

let g:startify_custom_header = [
      \'',
      \'',
      \'           ██████╗ ██╗  ██╗ ██████╗ ███████╗███╗   ██╗██╗██╗  ██╗    ██╗  ██╗██╗   ██╗         ',
      \'           ██╔══██╗██║  ██║██╔═══██╗██╔════╝████╗  ██║██║╚██╗██╔╝    ╚██╗██╔╝██║   ██║         ',
      \'           ██████╔╝███████║██║   ██║█████╗  ██╔██╗ ██║██║ ╚███╔╝      ╚███╔╝ ██║   ██║         ',
      \'           ██╔═══╝ ██╔══██║██║   ██║██╔══╝  ██║╚██╗██║██║ ██╔██╗      ██╔██╗ ██║   ██║         ',
      \'           ██║     ██║  ██║╚██████╔╝███████╗██║ ╚████║██║██╔╝ ██╗    ██╔╝ ██╗╚██████╔╝         ',
      \'           ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝    ╚═╝  ╚═╝ ╚═════╝          ',
      \'',
      \''
      \]
