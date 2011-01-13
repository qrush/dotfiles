augroup afterscss
  au!
  au BufWrite <buffer> sil! !rm -f public/stylesheets/*.css
augroup END

