set nocompatible  " Use Vim settings, rather then Vi settings
set nobackup
set nowritebackup
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

filetype plugin indent on

augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
  autocmd FileType asciidoc setlocal textwidth=78
  autocmd FileType asciidoc setlocal spell

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·

" Local config
if filereadable(".vimrc.local")
  source .vimrc.local
endif

" Color scheme
 colorscheme vividchalk
highlight NonText guibg=#060606
highlight Folded  guibg=#0A0A0A guifg=#9090D0

" Enable relative line numbers
set relativenumber

" Snippets are activated by Shift+Tab
let g:snippetsEmu_key = "<S-Tab>"

" Tab completion options
set wildmode=list:longest,list:full
set complete=.,w,t

" Tags
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" Cucumber navigation commands
autocmd User Rails Rnavcommand step features/step_definitions -glob=**/* -suffix=_steps.rb
autocmd User Rails Rnavcommand config config -glob=**/* -suffix=.rb -default=routes

" Sprocket assets
autocmd User Rails Rnavcommand jasset app/assets/javascripts -glob=**/* -suffix=.coffee
autocmd User Rails Rnavcommand jlasset lib/assets/javascripts -glob=**/* -suffix=.coffee
autocmd User Rails Rnavcommand jvasset vendor/assets/javascripts -glob=**/* -suffix=.coffee

autocmd User Rails Rnavcommand sasset app/assets/stylesheets -glob=**/* -suffix=.scss
autocmd User Rails Rnavcommand slasset lib/assets/stylesheets -glob=**/* -suffix=.scss
autocmd User Rails Rnavcommand svasset vendor/assets/stylesheets -glob=**/* -suffix=.scss

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" <Space> is the leader character
let mapleader = " "

" Edit the README_FOR_APP (makes :R commands work)
map <Leader>R :e doc/README_FOR_APP<CR>

" Hide search highlighting
map <Leader>l :set invhls <CR>

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Maps autocomplete to tab
imap <Tab> <C-P>

" Duplicate a selection
" Visual mode: D
vmap D y'>p

" No Help, please
nmap <F1> <Esc>

" Press Shift+P while in visual mode to replace the selection without
" overwriting the default register
vmap P p :call setreg('"', getreg('0')) <CR>

" Rails shortcuts
nmap <Leader>p :Rstep 
nmap <Leader>sp :RSstep 
nmap <Leader>tp :RTstep 
nmap <Leader>m :Rmodel 
nmap <Leader>c :Rcontroller 
nmap <Leader>v :Rview 
nmap <Leader>u :Runittest 
nmap <Leader>f :Rfunctionaltest 
nmap <Leader>i :Rintegrationtest 
nmap <Leader>h :Rhelper 
nmap <Leader>tm :RTmodel 
nmap <Leader>tc :RTcontroller 
nmap <Leader>tv :RTview 
nmap <Leader>tu :RTunittest 
nmap <Leader>tf :RTfunctionaltest 
nmap <Leader>ti :RTintegrationtest 
nmap <Leader>sm :RSmodel 
nmap <Leader>sc :RScontroller 
nmap <Leader>sv :RSview 
nmap <Leader>su :RSunittest 
nmap <Leader>sf :RSfunctionaltest 
nmap <Leader>si :RSintegrationtest 
nmap <Leader>g :Rconfig 
nmap <Leader>sg :RSconfig 
nmap <Leader>tg :RTconfig 
nmap <Leader>jm :Rjmodel  
nmap <Leader>sjm :RSjmodel 
nmap <Leader>tjm :RTjmodel 
nmap <Leader>jc :Rjcontroller  
nmap <Leader>sjc :RSjcontroller 
nmap <Leader>tjc :RTjcontroller 
nmap <Leader>jv :Rjview  
nmap <Leader>sjv :RSjview 
nmap <Leader>tjv :RTjview 
nmap <Leader>jl :Rjcollection  
nmap <Leader>sjl :RSjcollection 
nmap <Leader>tjl :RTjcollection 

" Window navigation
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>

" Snippets are activated by Shift+Tab
let g:snippetsEmu_key = "<S-Tab>"

" Ignore files on completion
set wildignore=*.rbc

" Highlight current line
set cul

" cucumber table autoalign
" https://gist.github.com/287147
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

" Hit ^W twice to close all splits and tabs
nmap <C-W><C-W> <C-W><C-O>:tabo<CR>

set runtimepath^=~/.vim/bundle/ctrlp.vim
