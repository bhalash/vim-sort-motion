" sort-motion.vim - Sort based on linewise motions
" Maintainer:   Mark Grealish <mark@bhalash.com
" Version:      1.1.0
" Source:       https://github.com/bhalash/vim-sort-motion

if exists('g:loaded_sort_motion') || &cp || v:version < 700
  finish
endif

let g:loaded_sort_motion = 1

let s:sort_motion = get(g:, 'sort_motion', 'gs')
let s:sort_motion_visual = get(g:, 'sort_motion_visual', 'gs')
let s:sort_lines = s:sort_motion_visual . 's'

nnoremap <silent> <Plug>SortMotion :<C-U>set opfunc=sort_motion#sort_motion<CR>g@
xnoremap <silent> <Plug>SortMotionVisual :<C-U>call sort_motion#sort_motion(visualmode())<CR>
nnoremap <silent> <Plug>SortLines :<C-U>call sort_motion#sort_lines()<CR>

if !hasmapto('<Plug>SortMotion', 'n') && maparg(s:sort_motion, 'n') ==# ''
  execute 'nmap ' . s:sort_motion . ' <Plug>SortMotion'
endif

if !hasmapto('<Plug>SortMotionVisual', 'x') && maparg(s:sort_motion_visual, 'x') ==# ''
  execute 'xmap ' . s:sort_motion_visual . ' <Plug>SortMotionVisual'
endif

if !hasmapto('<Plug>SortLines', 'n') && maparg(s:sort_lines, 'n') ==# ''
  execute 'xmap ' . s:sort_lines . ' <Plug>SortLines'
endif
