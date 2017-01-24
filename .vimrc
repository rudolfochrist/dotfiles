
" Basic Configuration
"
""""""""""""""""""""""""""""
set nocompatible
filetype on
filetype off " mac os x workaround

"
" General
"
""""""""""""""""""""""""""""""""""""""""""

set hidden
set nowrap
set tabstop=2
set softtabstop=2
set expandtab
set backspace=indent,eol,start
set wildmenu
set autoindent
set copyindent
set relativenumber
set number
set nofoldenable

set shiftwidth=2
set shiftround
set smarttab

set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch

set visualbell
set noerrorbells

set nobackup
set noswapfile

set encoding=utf-8

set spell
set mouse=a

" automatically read file if changed outside of vim
set autoread

" Sometimes ESC delays in term.
set timeoutlen=1000
set ttimeoutlen=0

" more natural splitting
set splitbelow
set splitright

filetype plugin indent on
syntax on

"
" Key mappings
"
""""""""""""""""""""""""""""
" Don't use arrow key. They are malicious.
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

" Especially don't use them in insert mode. This freaks out some of my
" colleagues if the want to quickly type something on my machine.
inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <Left> <nop>
inoremap <Right> <nop>

" don't jump over long lines
nnoremap j gj
nnoremap k gk

" Reselect pasted lines/text
nnoremap <leader>v V`]

" Clear the search buffer when hitting return
" Taken from Gary Bernhardt
function! MapCR()
  nnoremap <cr> :nohlsearch<cr>
endfunction
call MapCR()

" Pastetoggle
set pastetoggle=<Leader>d

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
" Taken from Gary Bernhardt
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

" Color settings
"
""""""""""""""""""""""""""""
if &t_Co > 2 || has("gui_running")
  syntax on
endif

set cursorline
hi clear CursorLine
hi CursorLine cterm=underline gui=underline
hi clear CursorLineNr
hi CursorLineNr cterm=bold ctermfg=226 gui=bold guifg=Yellow

hi clear SpellBad
hi SpellBad cterm=underline

" always show statusline
set laststatus=2

"
" Whitespaces
"
""""""""""""""""""""""""""""
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.


"
" Filetype settings
"
""""""""""""""""""""""""""""
au FileType make set noexpandtab
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru} set ft=ruby
au BufRead,BufNewFile *.json set ft=javascript softtabstop=4 tabstop=4 shiftwidth=4
au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79
au BufRead,BufNewFile *.mustache set ft=html
au FileType javascript set softtabstop=4 tabstop=4 shiftwidth=4
au FileType markdown set wrap linebreak nolist

"
" GUI settings
"
"""""""""""""""""""""""""""

set guifont=Ubuntu\ Mono:h13.5
if has("gui_running")

  " No toolbar
  set guioptions-=T
  set guioptions-=r
  set guioptions-=L

endif
