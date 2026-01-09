" Enable 256 colors:
   set t_Co=256
   set number
   set paste
   set autoindent
   set encoding=utf-8
   set fileencoding=utf-8
   set tw=121
   set tabstop=4
   set shiftwidth=4
   set expandtab
   set softtabstop=4
   set incsearch

   set hidden

" Change how panel split works:
   set splitbelow
   set splitright

" Enable sintax highlighting:
   syntax on
" ctags (recursive search)
   set tags=./tags;,tags;$HOME

" highlight space errors (trailing whitespace, etc.)
" from: http://vim.wikia.com/wiki/Highlight_unwanted_spaces
   highlight ExtraWhitespace ctermbg=brown guibg=brown
   match ExtraWhitespace /\s\+$/
   autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
   autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
   autocmd InsertLeave * match ExtraWhitespace /\s\+$/
   autocmd BufWinLeave * call clearmatches()

" also highlight those naughty tab characters.
   highlight Tabs ctermbg=brown guibg=brown
   call matchadd("Tabs", "\t")

" highligh long lines
   if exists('+colorcolumn')
     set colorcolumn=120
     highlight ColorColumn ctermbg=234
   else
     au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
   endif

" panel navigation:
   nnoremap <C-J> <C-W><C-J>
   nnoremap <C-K> <C-W><C-K>
   nnoremap <C-L> <C-W><C-L>
   nnoremap <C-H> <C-W><C-H>
