" {{{1 select_a
function! g:textobj#markdown#sheader#select_a()
  let l:head = search('^#\+\s', 'nWbc')
  let l:level = len(matchstr(getline(l:head), '^#\+'))
  let l:tail = search('^#\{1,'.l:level.'}\s', 'nW')
  if !l:head
    let l:head = 1
  endif
  if !l:tail
    let l:tail = line("$")+1 " +1是因为后面要-1
  endif
  " {{{2 修改大小
  let l:tail -= 1
  if l:tail < l:head
    echom "l:tail < l:head failed"
    return 0
  endif
  return ['V', [0, l:head, 1, 0], [0, l:tail, 1, 0]]
endfunction

" {{{1 select_i
function! g:textobj#markdown#sheader#select_i()
  let l:head = search('^#\+\s', 'nWbc')
  let l:level = len(matchstr(getline(l:head), '^#\+'))
  let l:tail = search('^#\{1,'.l:level.'}\s', 'nW')
  if !l:head
    let l:head = 1-1 " 因为要+1
  endif
  if !l:tail
    let l:tail = line("$")+1 " +1是因为后面要-1
  endif
  " {{{2 修改大小
  let l:tail -= 1
  let l:head += 1
  if l:tail < l:head
    echom "l:tail < l:head failed"
    return 0
  endif
  return ['V', [0, l:head, 1, 0], [0, l:tail, 1, 0]]
endfunction

function! g:textobj#markdown#sheader#move_p()
  let l:head = search('^#\+\s', 'nWbc')
  let l:level = len(matchstr(getline(l:head), '^#\+'))
  " 不包括当前行
  let next_line = search('^#\{1,'.l:level.'}\s', 'nWb')

  " Just in case the notebook has no starting cell.
  if next_line == 0
    " echom "not found next same header"
    let next_line = 1
  endif

  let curr_pos = getpos('.')
  let pos = [curr_pos[0], next_line, 1, curr_pos[3]]

  return ['V', pos, 0]
endfunction
  
function! g:textobj#markdown#sheader#move_n()
  let l:head = search('^#\+\s', 'nWbc')
  let l:level = len(matchstr(getline(l:head), '^#\+'))
  " 不包括当前行
  let next_line = search('^#\{1,'.l:level.'}\s', 'nW')

  if next_line == 0 " We are the last cell
    let next_line = line('$')
  endif

  let curr_pos = getpos('.')
  let next_pos = [curr_pos[0], next_line, 0, curr_pos[3]]

  return ['V', next_pos, 0]
endfunction
