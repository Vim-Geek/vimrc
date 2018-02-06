let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_cmd = 'CtrlPMRUFiles'
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](\.(git|hg|svn)|node_modules)$',
    \ 'file': '\v\.(DS_Store|dll|view\.art\.js)$',
    \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
    \ }
let g:ctrlp_match_window = 'min:1,max:20'
let g:ctrlp_reuse_split = 'netrw\|help\|quickfix\|NERD'
let g:ctrlp_show_hidden = 1
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']
"let g:ctrlp_types = ['mru', 'file']
let g:ctrlp_extensions = ['tag']
