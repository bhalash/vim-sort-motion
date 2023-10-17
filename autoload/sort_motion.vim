if exists('g:autoloaded_sort_motion')
  finish
endif

let g:autoloaded_sort_motion = 1
let s:sort_motion_flags = get(g:, 'sort_motion_flags', '')
let s:sort_motion_visual_block_command = get(g:,'sort_motion_visual_block_command', 'sort')

function! sort_motion#sort_motion(mode) abort
  if a:mode == 'line'
    call s:sort_line()
  elseif a:mode == 'char'
    call s:sort_chars()
  elseif a:mode == 'V'
    call s:sort_visual()
  elseif a:mode == '^V'
    call s:sort_visual_block()
  endif
endfunction

function! s:sort_chars() abort
  execute "normal! `[v`]y"

  let l:prefix
  let l:delimiter
  let l:suffix

  let l:startpos = match(@@, '\v\i')
  let l:parts = split(@@, '\v\i+')

  if startpos > 0
    l:prefix = parts[0]
    l:delimiter = parts[1]
    l:suffix = parts[-1]
  else
    l:prefix = ''
    l:delimiter = parts[0]
    l:suffix = ''
  endif

  if l:prefix == l:delimiter
    l:prefix = ''
  endif

  if l:suffix == l:delimiter
    l:suffix = ''
  endif

  let sortstart = strlen(l:prefix)
  let sortend = strlen(@@) - sortstart - strlen(l:suffix)
  let sortables = strpart(@@, sortstart, sortend)
  let sorted = join(sort(split(sortables, '\V' . escape(delimiter, '\'))), delimiter)
  execute "normal! v`]c" . l:prefix . sorted . l:suffix
  execute "normal! `["
endfunction

function! s:sort_lines() abort
  let beginning = line('.')
  let end = v:count1 + beginning - 1
  execute beginning . ',' . end . 'sort ' . s:sort_motion_flags
endfunction

function! s:sort_line() abort
  execute "'[,']sort " . s:sort_motion_flags
endfunction

function! s:sort_visual_block() abort
  execute "'<,'>" . s:sort_motion_visual_block_command . ' ' . s:sort_motion_flags
endfunction

function! s:sort_visual() abort
  execute "'<,'>sort " . s:sort_motion_flags
endfunction
