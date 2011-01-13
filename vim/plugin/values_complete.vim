function! ValuesComplete(findstart, base)
  let lineUpToCursor = strpart(getline('.'), 0, col(".") - 1)
  let quoteIndex = matchend(lineUpToCursor, '.*"')

  if a:findstart
    return quoteIndex
  endif

  let values = []

  let lineNum = 1
  while lineNum <= line("$")
    let line = getline(lineNum)

    if stridx(line, "|") != -1
      " values in ascii tables
      let values_with_spaces = split(line, "|")
      let values += map(values_with_spaces, 'substitute(v:val, "^\\s\\+\\|\\s\\+$", "", "g")')
    else
      " values in quotes
      let value = matchstr(line, '"[^"]\+"')
      let values += [substitute(value, '"', '', "g")]
    endif

    let lineNum += 1
  endwhile
  call filter(values,'strpart(v:val,0,strlen(a:base)) ==# a:base')
  return values
endfunction

