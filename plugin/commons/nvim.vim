if exists('g:loaded_commons')
  finish
endif
let g:loaded_commons=1

let s:is_win = has('win32') || has('win64')

if s:is_win && &shellslash
  set noshellslash
  let s:base_dir = expand('<sfile>:p:h:h')
  set shellslash
else
    let s:base_dir = expand('<sfile>:p:h:h')
endif

function! commons#nvim#base_dir() abort
  return s:base_dir
endfunction
