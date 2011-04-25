function! ToTranslateKey(text)
  let key = tolower(a:text)
  let key = substitute(key, " ", "_", "g")
  return "." . substitute(key, "\\W\\+", "", "g")
endfunction

function! ToTranslate(text)
  let key = ToTranslateKey(a:text)
  let result = 't("' . key . '", :default => "' . a:text . '")'
  return result
endfunction

function! ToTranslateErb(text)
  return "<%= " . ToTranslate(a:text) . " %>"
endfunction

function! StringToTranslate(string)
  let result = matchlist(a:string, "^\\(\\s*\\)['\"]\\(.*\\)['\"]\\(\\s*\\)$")
  let head = result[1]
  let text = result[2]
  let tail = result[3]
  return head . ToTranslate(text) . tail
endfunction

nmap ytit vitc<C-R>=ToTranslateErb(getreg('"'))<CR><Esc>
nmap yta' ca'<C-R>=StringToTranslate(getreg('"'))<CR><Esc>
nmap yta" ca"<C-R>=StringToTranslate(getreg('"'))<CR><Esc>

