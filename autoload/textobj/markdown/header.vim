function! g:textobj#markdown#header#select_a()
  let l:head = search('^#\+\s', 'nWbc')
  let l:tail = search('^#\+\s', 'nW')
  let l:tail -= 1
  if l:tail < l:head
    echom "vim-textob-markdown: Code fence not found, perhaps the start does not identify a language"
    return 0
  endif
  return ['V', [0, l:head, 1, 0], [0, l:tail, 1, 0]]
endfunction

function! g:textobj#markdown#header#select_i()
  let l:head = search('^#\+\s', 'nWbc')
  let l:tail = search('^#\+\s', 'nW')
  let l:tail -= 1
  if !l:head || !l:tail
    echom "vim-textob-markdown: Code fence not found, perhaps the start does not identify a language"
    return 0
  endif
  let l:head += 1
  let l:tail -= 1
  if l:tail < l:head
    echom "vim-textob-markdown: Code fence found, but zero length"
    return 0
  endif
  return ['V', [0, l:head, 1, 0], [0, l:tail, 1, 0]]
endfunction
