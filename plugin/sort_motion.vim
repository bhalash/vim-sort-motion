" sort-motion.vim - Sort based on linewise motions
" Maintainer:   Mark Grealish <mark@bhalash.com
" Version:      0.2
" Source:       https://github.com/bhalash/vim-sort-motion

if exists('g:loaded_sort_motion') || &cp || v:version < 700
  finish
endif

let g:loaded_sort_motion = 1
let s:sort_motion = get(g:, 'sort_motion', 'gs')

nnoremap <silent> <Plug>SortMotion
      \ :<C-U>set opfunc=sort_motion#sort_motion<CR>g@
xnoremap <silent> <Plug>SortMotionVisual
      \ :<C-U>call sort_motion#sort_motion(visualmode())<CR>
nnoremap <silent> <Plug>SortLines
      \ :<C-U>call sort_motion#sort_lines()<CR>

if !hasmapto('<Plug>SortMotion', 'n') && maparg(s:sort_motion, 'n') ==# ''
  " nmap gs <Plug>SortMotion
  execute 'nmap ' . s:sort_motion . ' <Plug>SortMotion'
endif

if !hasmapto('<Plug>SortMotionVisual', 'x') && maparg(s:sort_motion, 'x') ==# ''
  " xmap gs <Plug>SortMotionVisual
  execute 'xmap ' . s:sort_motion . ' <Plug>SortMotionVisual'
endif

if !hasmapto('<Plug>SortLines', 'n') && maparg(s:sort_motion . 's', 'n') ==# ''
  " nmap gss <Plug>SortLines
  execute 'xmap ' . s:sort_motion . 's' . ' <Plug>SortMotionVisual'
endif
