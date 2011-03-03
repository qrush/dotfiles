function! PrefixStep(type)
  let lineno = line(".") - 1
  let line = getline(lineno)

  while match(line, "^\\s\\+And") != -1
    let lineno = lineno - 1
    let line = getline(lineno)
  endwhile

  if match(line, "^\\s\\+" . a:type, "") == -1
    return a:type
  else
    return "And"
  endif
endfunction

" Capybara steps
Snippet press ``PrefixStep("When")`` I press "<{}>"
Snippet follow ``PrefixStep("When")`` I follow "<{}>"
Snippet fillin ``PrefixStep("When")`` I fill in "<{field}>" with "<{}>"
Snippet select ``PrefixStep("When")`` I select "<{value}>" from "<{}>"
Snippet check ``PrefixStep("When")`` I check "<{}>"
Snippet uncheck ``PrefixStep("When")`` I uncheck "<{}>"
Snippet choose ``PrefixStep("When")`` I choose "<{}>"
Snippet go ``PrefixStep("When")`` I go to the <{}>
Snippet see ``PrefixStep("Then")`` I should see "<{}>"
Snippet notsee ``PrefixStep("Then")`` I should not see "<{}>"

" Factory steps
Snippet exist ``PrefixStep("Then")`` a <{factory}> exists with a <{attribute}> of "<{}>"
Snippet texist ``PrefixStep("Then")`` the following <{factory}> exists:<CR>| <{}> |
Snippet mexist ``PrefixStep("Then")`` the following <{factory}>s exist:<CR>| <{}> |

function! AlignAsciiTable()
  let startline = line(".")
  while match(getline(startline), "|") != -1
    let startline = startline - 1
  endwhile
  let startline = startline + 1

  let endline = startline
  while match(getline(endline), "|") != -1
    let endline = endline + 1
  endwhile
  let endline = endline - 1

  if startline >= endline
    return
  endif

  exec startline . "," . endline . "!align_ascii_table"
endfunction

function! CountSubstring(string, substring)
  let start = 0
  let result = 0
  let index = stridx(a:string, a:substring, start)
  while index != -1
    let start = index + 1
    let result += 1
    let index = stridx(a:string, a:substring, start)
  endwhile
  return result
endfunction

function! CucumberTab(command)
  let lineUpToCursor = strpart(getline('.'), 0, col(".") - 1)
  let quotes = CountSubstring(lineUpToCursor, "\"")

  if quotes > 0
    return "\<C-X>\<C-U>"
  else
    return "\<C-X>\<C-O>"
  endif
endfunction

nmap <buffer> <C-A> :call AlignAsciiTable()<CR>
vmap <buffer> <C-A> !align_ascii_table<CR>
set completefunc=ValuesComplete

im <buffer> <Tab> <C-n>
ino <buffer> <C-N> <C-R>=CucumberTab('n')<CR>
ino <buffer> <C-P> <C-R>=CucumberTab('p')<CR>
