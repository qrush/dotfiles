function! Git(args)
  if a:args == 'add'
    write
    execute "silent !git add %"
  elseif a:args == 'unmerged'
    let unmerged = system("git-unmerged-next")
    if unmerged == ''
      echo "No unmerged files remaining"
    else
      execute "edit " . unmerged
    endif
  elseif a:args == 'rm'
    silent! !git rm %
  elseif a:args == 'resolve'
    call Git('add')
    call Git('unmerged')
  else
    echoe "No such git command: " . a:args
  endif
endfunction

function! GitComplete(A,L,P)
  return "unmerged\nresolve\nrm"
endfunction

command! -nargs=1 -complete=custom,GitComplete Git call Git(<q-args>)
